-- manchester_encoder4WuR.vhd
-- paraidad par el numero total de unos trnsmitido es par (incluido el bit de paridad)
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

-- library wupu_lib;
-- use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;

entity manchester_encoder is
--generic (DIVIDER : integer := 829*2); -- --2400/2 para 48 MHZ |||||   553 para 11.0592 |||| 553*3 para IR a 11.0592 ||| 829*2 para 150 us para starbit (300 para data bit)

port (
    clk 		: in std_logic;
    rstn 		: in std_logic;
	din 		: in std_logic_vector (MEILENGTH-1 downto 0); --data to transmit
    load 		: in std_logic; -- read the data in din 
	enable 		: in std_logic; -- enable manchester encoding
	paritybit 	: in std_logic; -- if '1' a extra bit is added to the transmitted code as parity bit, the aprity is generated in the encoder
    data_end 	: out std_logic; -- if '1' tx buffer is empty
    dout 		: out std_logic; -- manchester data encoded 
    d_hk 		: out std_logic -- done housekeeping
    
    );
end manchester_encoder;

architecture rtl of manchester_encoder is

constant preamble :std_logic_vector (PREAMBLELENGTH-1 downto 0) :=     "10101010";
constant msgHeader :std_logic_vector (HEADERLENGTH-1 downto 0) :=     "1111";
--constant TRIPLE_MSG : integer range 0 to PREAMBLELENGTH

--constant slowpreamble : std_logic_vector (7 downto 0) := "11111111";
signal symbol_t : integer range 0 to ENCODER_REF;
signal messageCount : integer range 0 to CONSECUTIVEMSGS;
signal Cout : std_logic;
signal bit_count : integer range 0 to 7 --MSGLENGTH-1; -- Preamble + starrsequence + 2 msg type + 16 bits + parity
signal rsr : std_logic_vector (PREAMBLELENGTH-1 downto 0);
---signal tx_bit : std_logic;
signal msg_bit : std_logic;
signal reg_tc : std_logic;
signal reg_Cout : std_logic;
signal tc : std_logic;
signal last_bit : std_logic;

signal last_bit_sent : std_logic;
--signal deadTimeElapsed : std_logic;
--signal start_bit : std_logic; -- Cout_half xnor Cout
--signal end_bit : std_logic; -- Cout_half xor Cout
signal bit_end : std_logic; -- Cout_half xor Cout
signal sendingMsg : std_logic; -- activa por nivel alto (1 mientras envio)
--signal EoC : std_logic; -- fin de cuenta del contador de bits para mensaje
signal encoder_busy: std_logic;
signal Enable_freqref: std_logic;
signal rstn_freqRef: std_logic;
signal Add_parityBit:std_logic;
--signal parityBit_aux: std_logic;
signal mdo: std_logic;
--signal sel_mdo: std_logic;


begin

	
	Enable_freqref <= enable; -- deadTimeElapsed and enable;
	rstn_freqRef <= rstn and (not load);  
	-- hay q hacerlo con un for
	-- Add_parityBit <= NextHopAddress (15) xor NextHopAddress (14) xor NextHopAddress (13) xor NextHopAddress (12) xor NextHopAddress (11) xor NextHopAddress (10)
					-- xor NextHopAddress (9) xor NextHopAddress (8) xor NextHopAddress (7) xor NextHopAddress (6) xor NextHopAddress (5) xor NextHopAddress (4)
					-- xor NextHopAddress (3) xor NextHopAddress (2) xor NextHopAddress (1) xor NextHopAddress (0);
	
	parityBit_gen: process (NextHopAddress)				
	variable parityBit_aux: std_logic;
	begin
		parityBit_aux := NextHopAddress (0);
		for i in 1 to ADDRESSLENGTH-1 loop
			parityBit_aux := parityBit_aux xor NextHopAddress (i); --- parityBit
		end loop;
		
		Add_parityBit <= parityBit_aux;
	end process;
	
	end_msg <= '1' when messageCount = 3 else '0';
	triplemsgbuild: process (clk, rstn)
	begin
		if rstn = '0' then
			messageCount <= 0;
		elsif clk'event and clk = '0' then
			if load = '1' then
				messageCount <= 0;
			elsif last_bit_sent = '1' then
				messageCount <= messageCount + 1;
			end if;
		end if;
	end process;

	-- genero la señal de referencia de ENCODER_REF ciclos
    process (clk, rstn)
    begin
        if rstn = '0' then
            symbol_t <= 0;
            cout <= '0';

        elsif clk'event and clk = '1' then
            if sendingMsg = '0'  then
				symbol_t <= 0;
				cout <= '0';

			elsif enable = '1' and load = '0' then
				if symbol_t = ENCODER_REF then
             		cout <= not cout;
					symbol_t <= 0;
				else
                    symbol_t <= symbol_t + 1;
                end if;
            end if;
        end if;
    end process;
	
	--tc <= '1' when symbol_t = ENCODER_REF and cout = '1' else '0';
	process (symbol_t, cout)
    begin
        if symbol_t = ENCODER_REF and cout = '1' then
            tc <= '1';
        else
            tc <= '0';
        end if;
	end process;
	
	
	bit_end <= tc and cout;


	process (clk, rstn)
    begin
        if rstn = '0' then
            reg_tc <= '0';
			reg_cout <= '0';
        elsif clk'event and clk = '1' then
            if enable = '1'  then
				reg_tc <= tc;
				reg_cout <= cout;
			end if;
        end if;
    end process;

    -- control del flag encoder-busy q indica q el encoder esta funcionando
	process (clk, rstn)
    begin
        if rstn = '0' then
            encoder_busy <= '0';
        elsif clk'event and clk = '1' then
            if enable = '1' then
                encoder_busy <= '1' ;
            elsif last_bit_sent = '1' then
                encoder_busy <= '0' ;
            end if;
        end if;
    end process;

	d_hk <= not encoder_busy;
	
    process (clk, rstn)
    begin
        if rstn = '0' then
             sendingMsg  <= '0';
        elsif clk'event and clk = '1' then
		   if last_bit = '1' and bit_end = '1' then
                sendingMsg <= '0' ;
            elsif load = '1' then
                sendingMsg <= '1';
            end if;
        end if;
    end process;

	last_bit_sent <= last_bit and bit_end;
	end_msg <= last_bit_sent;
	-- diferencai entre sendingMsg y end_msg??n
	msg_bit <= rsr (MSGLENGTH-1);
	
    process (clk, rstn)
    begin
        if rstn = '0' then
            rsr <= (others => '0');
		elsif clk'event and clk = '1' then
            if  load = '1' then
				if din(1) = '1' then 
					rsr (MSGLENGTH-1 downto ADDRESSLENGTH)  <= preamble & msgHeader & din & not din(1) & not din (0)& '0'; 
				else
					rsr <= preamble & msgHeader & din & not din(1) & not din (0) & nextHopAddress & Add_parityBit; -- parityBit
				end if;
			elsif bit_end = '1'  then
				rsr<= rsr (MSGLENGTH-2 downto 0) & '0';
			end if;
        end if;
   end process;
    
	
	last_bit <= '1' when bit_count = 0 else '0';
   
   process (clk, rstn)
    begin
        if rstn = '0' then
			bit_count <= MSGLENGTH-1; --18			
        elsif clk'event and clk = '1' then
			if load = '1' then
				if din(1) = '0' then
					bit_count <= MSGLENGTH-1; --18
				else
					bit_count <= MSGLENGTH-ADDRESSLENGTH-1; --tamaño minimO 16+4+2+1 
				end if;
			
			elsif enable = '1' and bit_end = '1' then -- and last_bit = '0' then-- and deadTimeElapsed = '1'then
				if bit_count = 0 then
					bit_count <= MSGLENGTH-1;
				else
					bit_count <= bit_count - 1;
				end if;

			end if;
		end if;
	end process;

	process (clk, rstn)
    begin
        if rstn = '0' then
            mdo <= '0';
        elsif clk'event and clk = '1' then
            if sendingMsg = '0' then
				mdo <= '0';
			elsif enable = '1' then -- and deadTimeElapsed = '1' and load = '0' then
				mdo <= cout xor msg_bit;
			end if;
        end if;

    end process;

	dout <= mdo;
end;