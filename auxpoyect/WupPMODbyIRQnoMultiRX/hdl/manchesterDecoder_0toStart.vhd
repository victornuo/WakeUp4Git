library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all ;

--library wupu_lib;
--use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;

LIBRARY igloo;
   USE igloo.all;   

-- rst Reset for clk16, no_bits_rcvd, nrzf
-- clk clock imput used as reference for clock recovery, center sampling
-- mdi serial manchester  data input
-- rdn  Control signal initiatea a read operation
-- dout paralell NRZ bus output
-- data_ready Status signal indicating data is present on the data bus dout
-- cambios EoM pasa a ser dataProccesed
-- el primer flanco q se reciba se procesa (el primer bit q se espera es un '0')

entity md_v4 is
generic ( ERROR_TIME : integer := RX_ERROR_REF); 
port(  
    mdi  : in std_logic;
--    dataProccesed : in std_logic; 
--	sel_bit_time_ref : in std_logic;
--	errorTime_select: in std_logic_vector (1 downto 0);
	bit_error  : out std_logic;
	dout  : out std_logic;
	new_data : out std_logic;
	rst: in std_logic ;  
    clk: in std_logic   
    --d_hk: out std_logic 
) ;
end md_v4 ;

architecture rtl of md_v4 is

      
signal edgeMDI, mdi0, mdi1, mdi2,mdi3, mdi4, mdi5, shift_data : std_logic; -- para detectar el flanco de subida, el primer bit debe ser un '0'
signal ctd0, ctd1, ctd2 : std_logic;
signal clk_enable : std_logic;

signal enableJohnson : std_logic;
signal data : std_logic;
signal error_counter : integer range 0 to ERROR_TIME;
signal error_happens : std_logic;
--signal too_short_bit : std_logic;
signal too_long_bit : std_logic;
signal CE : std_logic; 

 
signal rst_error_counter : std_logic;

signal Enable_freqref : std_logic;
signal Enable_decoder : std_logic;
signal double_speed : std_logic;

signal done_hk : std_logic;
signal rx_error : std_logic;

signal Restart : std_logic;

signal errorTime : integer range 0 to ERROR_TIME;
signal errorTime_reg : integer range 0 to ERROR_TIME;
component frec_ref 
	generic (VALUEREF : integer :=  DECODER_REF); -- 415 para asegurar que detecto los msgs con wubit.   ,137 para 100 us (fclk*tbit/8) 207 para poder detectar el wup bit y bit end.
    port( rst   : in    std_logic;
          Clk   : in    std_logic;
		  CEO    : out   std_logic;
          Enable : in    std_logic
        );
end component;


begin


bit_Error<=rx_error;

fre_ref_0 : frec_ref port map
(
	rst => rst,
	Clk => clk,
	CEO => CE, 
	Enable => Enable_freqref
);
dout <= data;
--Restart <= dataProccesed or rx_error;
Restart <=  rx_error;
process (rst,clk)
begin
	if rst = '0' then
		mdi1 <= '0' ;
		mdi2 <= '0' ;
	elsif clk'event and clk = '1' then 
		if Restart = '1' then
			mdi2 <= '0';
			mdi1 <= '0';
		elsif CE = '1' then
			--mdi2 <= not mdi1 ;
			mdi2 <= mdi1 ;
			mdi1 <= mdi;
		end if;	
	end if;
end process;

edgeMDI <=  ( mdi2 xor mdi1);
data <= not mdi2;


--===============================================================
--Detector de flanco de bajada para el primer bit y el primer flanco de subida

process (rst,clk)
begin
if rst = '0' then
    mdi3 <= '0';
    mdi4 <= '0';
elsif clk'event and clk = '1' then 
    if  Restart = '1' then
        mdi4 <= '0';
        mdi3 <= '0';
    else    
        mdi4 <= mdi4 or (not mdi3 and mdi);
		mdi3 <= mdi;
	end if;
end if ;
end process ;


--detecto flanco de bajada en shift data para curarme en salud al capturar el dato del msg
process (rst,clk)
begin
if rst = '0' then
    mdi0 <= '0';
elsif clk'event and clk = '1' then 
    if Restart = '1' then
		mdi0 <= '0';
    else    
		mdi0 <= shift_data;
    end if;
end if ;
end process ;

new_data <= not shift_data and mdi0; 


--Enable_freqref <= Enable_decoder; 
enableJohnson <= mdi4; 
Enable_freqref <= enableJohnson; 

clk_enable <= CE and enableJohnson;

-- CONTADOR JOHNSON

process (rst,clk)
begin
if rst = '0' then
    ctd0 <= '0' ;
    ctd1 <= '0' ;
    ctd2 <= '0' ;
elsif clk'event and clk = '1' then
	if  Restart = '1' then
		ctd2 <= '0';
        ctd1 <= '0';
        ctd0 <= '0';
    elsif clk_enable = '1' then
        ctd2 <= ctd1 and (ctd0 or ctd2);
        ctd1 <= ctd0;
        ctd0 <= ((edgeMDI  or ctd0) and (not ctd2));
    end if;
end if ;

end process ;

process (rst,clk)
begin
if rst = '0' then
    shift_data <= '0' ;
elsif clk'event and clk = '1' then 
    if clk_enable = '1' then
        shift_data <= edgeMDI and ((not ctd0) and (not ctd2));        
    end if;
end if ;

end process ;

rst_error_counter <= edgeMDI; -- (double_speed and edgeMDI and mdi) or ( not double_speed and edgeMDI);


-- deberia compararse con error_time_reg tanto aqui como dentro del process

error_happens <= too_long_bit; 

too_long_bit <= '1' when error_counter = ERROR_TIME else '0';

				 
process (rst,clk)
begin
	if rst = '0' then
		error_counter <= 0 ;
	elsif clk'event and clk = '1' then 
		if rst_error_counter = '1' or Restart = '1' then-- or rx_error = '1' then
			error_counter <= 0;
		elsif CE = '1' then	--elsif clk_enable = '1' then	
			if error_counter = ERROR_TIME then
				error_counter <= 0;
			else
				error_counter <= error_counter + 1;
			end if;
		end if;
	end if ;
end process ;


process (rst,clk)
begin
	if rst = '0' then
		rx_error <= '0' ;
	elsif clk'event and clk = '1' then 
		if error_happens = '1' then
			rx_error <= '1';
		elsif (rx_error = '1' and mdi = '0') then --dataProccesed = '1' or (rx_error = '1' and mdi = '0') then--ready2sleep = '1'  then
			rx_error <= '0';
		end if;
	end if ;
end process ;

end ;