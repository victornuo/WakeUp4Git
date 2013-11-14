
-- paridad par el numero total de '1' transmitido es par (incluido el bit de paridad)
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

-- library wupu_lib;
-- use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;

entity manchester_encoder_ctrl is
--generic (DIVIDER : integer := 829*2); -- --2400/2 para 48 MHZ |||||   553 para 11.0592 |||| 553*3 para IR a 11.0592 ||| 829*2 para 150 us para starbit (300 para data bit)

port (
    din : in std_logic_vector (1 downto 0);
	load_din : in std_logic;
    nextHopAddress : in std_logic_vector (ADDRESSLENGTH-1 downto 0);
	Encoderfree : in std_logic;
	start : in std_logic;
    loadEncoder : out std_logic;
	enableEncoder : out std_logic;
    dout : out std_logic_vector (MEILENGTH-1 downto 0);
	addParity : out std_logic;
    d_hk : out std_logic;
    clk : in std_logic;
    rstn : in std_logic
    );
end manchester_encoder_ctrl;

architecture rtl of manchester_encoder_ctrl is

constant preamble :std_logic_vector (PREAMBLELENGTH-1 downto 0) :=     "10101010";
constant msgHeader :std_logic_vector (HEADERLENGTH-1 downto 0) :=     "1111";

type state_type is (FREE, loadpreamble1, sendpreamble1, loadheaderAndCommand, sendheaderAndCommand, loadAddress, sendAddress);
signal state, next_state : state_type; 

signal command2send : std_logic_vector (3 downto 0); 

 
signal cuentaEnvios : integer range 0 to (CONSECUTIVEMSGS+2);

signal enableCuenta : std_logic; 
signal nuevoEnvio : std_logic; 
 

 
begin

	load_din_p : process (clk, rstn)
	begin
	if rstn = '0' then
			command2send <= "0000";
	elsif clk'event and clk ='1' then
		if load_din = '1' then
			command2send <= din & not din (1) & not din (0);
		end if;
	end if;
	
	end process;
	
	
	SYNC_PROC: process (rstn, clk)
	begin
      if (rstn = '0') then
         state <= FREE;
      elsif (clk'event and clk = '1') then
           state <= next_state;
      end if;
	end process;
 
 	NEXT_STATE_DECODE: process (state, start, load_din, Encoderfree, command2send, cuentaEnvios  )
	begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
        
		when FREE =>
			if start = '1' then
				next_state <= loadpreamble1;
			end if;
        
		when loadpreamble1 => 
			if Encoderfree = '0'  then
				next_state <= sendpreamble1;
			end if;
		   				
		when sendpreamble1 => 
			if Encoderfree = '1' AND cuentaEnvios = 0 then
				next_state <= loadpreamble1;
			
			elsif Encoderfree = '1' AND cuentaEnvios = 1 then
				next_state <= loadheaderAndCommand;
			end if;
		
		when loadheaderAndCommand => 
			if cuentaEnvios = CONSECUTIVEMSGS+2 then
				next_state <= Free;
			elsif Encoderfree = '0' then
				next_state <= sendheaderAndCommand;
			end if;
		   				
		when sendheaderAndCommand => 
			
			if Encoderfree = '1' AND command2send (3) = '0' then
				next_state <= loadAddress;
			elsif Encoderfree = '1' AND command2send (3) = '1' then
				next_state <= loadheaderAndCommand;
			end if;		
			
		when loadAddress => 
			if Encoderfree = '0' then
				next_state <= sendAddress;
			end if;
		
    	when sendAddress => 
			if Encoderfree = '1' then
				next_state <= loadheaderAndCommand;
			end if;
		
      end case;      
   end process;
   
    OUTPUT_DECODE: process (state, load_din, Encoderfree, command2send, cuentaEnvios)
	begin
      --declare default state for next_state to avoid latches
      --next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
		if (state = FREE ) then
			enableCuenta <= '0';
			nuevoEnvio <= '0';
			loadEncoder <= '0';
			enableEncoder <= '0';
			dout <= (others => '0');
			addParity <= '0';
			d_hk <= '1';
		
		elsif (state = loadpreamble1) then
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '1';
				enableEncoder <= '1';
				dout <= preamble;
				addParity <= '0';
				d_hk <= '0';
				
		elsif (state = sendpreamble1) then
			if Encoderfree = '1' then
				enableCuenta <= '1';
				nuevoEnvio <= '1';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= preamble;
				addParity <= '0';
				d_hk <= '0';
			else
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= preamble;
				addParity <= '0';
				d_hk <= '0';
			end if;
		
		elsif ( state = loadheaderAndCommand) then  
			if cuentaEnvios = CONSECUTIVEMSGS+2 then
				enableCuenta <= '0';
				nuevoEnvio <= '0';
				loadEncoder <= '0';
				enableEncoder <= '0';
				dout <= msgHeader & command2send;
				addParity <= '0';
				d_hk <= '0';
			
			elsif command2send(3) = '1' then
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '1';
				enableEncoder <= '1';
				dout <= msgHeader & command2send ;
				addParity <= '1';
				d_hk <= '0';
			
			else
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '1';
				enableEncoder <= '1';
				dout <= msgHeader & command2send;
				addParity <= '0';
				d_hk <= '0';
			
			end if;
		   				
		elsif ( state = sendheaderAndCommand) then
			
			if Encoderfree = '1' AND command2send (3) = '0' then
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= msgHeader & command2send;
				addParity <= '0';
				d_hk <= '0';
			
			elsif Encoderfree = '1' AND command2send (3) = '1'then
				enableCuenta <= '1';
				nuevoEnvio <= '1';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= msgHeader & command2send;
				addParity <= '0';
				d_hk <= '0';
			
			else
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= msgHeader & command2send;
				addParity <= '0';
				d_hk <= '0';
			end if;	
			
		elsif ( state = loadAddress) then
			enableCuenta <= '1';
			nuevoEnvio <= '0';
			loadEncoder <= '1';
			enableEncoder <= '1';
			dout <= nextHopAddress;
			addParity <= '1';
			d_hk <= '0';
		
    	elsif ( state = sendAddress) then
			if Encoderfree = '1' then
				enableCuenta <= '1';
				nuevoEnvio <= '1';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= nextHopAddress;
				addParity <= '0';
				d_hk <= '0';
			else
				enableCuenta <= '1';
				nuevoEnvio <= '0';
				loadEncoder <= '0';
				enableEncoder <= '1';
				dout <= nextHopAddress;
				addParity <= '0';
				d_hk <= '0';
			end if;	
		
		end if;      
   end process;
   
	cuenta_tramos_P : process (clk, rstn)
	begin
		if rstn = '0' then
			cuentaEnvios <= 0;
		elsif clk'event and clk = '1' then
			if enableCuenta = '0' then
				cuentaEnvios <= 0;
			elsif enableCuenta = '1' and nuevoEnvio = '1' then
				if cuentaEnvios = CONSECUTIVEMSGS+2 then
					cuentaEnvios <= 0;
				else
					cuentaEnvios <= cuentaEnvios + 1;
				end if;
			end if;
		end if;
	end process;
	



	
end;