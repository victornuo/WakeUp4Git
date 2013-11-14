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

entity md_v3 is
generic ( ERROR_TIME : integer := RX_ERROR_REF); 
port(  
    mdi  : in std_logic;
    EoM : in std_logic; 
--	sel_bit_time_ref : in std_logic;
--	errorTime_select: in std_logic_vector (1 downto 0);
	bit_error  : out std_logic;
	dout  : out std_logic;
	new_data : out std_logic;
	rst: in std_logic ;  
    clk: in std_logic ;  
    d_hk: out std_logic 
) ;
end md_v3 ;

architecture v1 of md_v3 is

      
signal edgeMDI, mdi0, mdi1, mdi2,mdi3, mdi4, mdi5, shift_data : std_logic; -- para detectar el flanco de subida, el primer bit debe ser un '0'
signal ctd0, ctd1, ctd2 : std_logic;
signal clk_enable : std_logic;

signal enableJohnson : std_logic;
signal data : std_logic;
signal error_counter : integer range 0 to 12;
signal error_happens : std_logic;
signal too_short_bit : std_logic;
signal too_long_bit : std_logic;
signal CE : std_logic; 

 
signal rst_error_counter : std_logic;

signal Enable_freqref : std_logic;
signal Enable_decoder : std_logic;
signal double_speed : std_logic;

signal done_hk : std_logic;
signal rx_error : std_logic;

signal EndOfMsg : std_logic;

signal errorTime : integer range 0 to 12;
signal errorTime_reg : integer range 0 to 12;
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


process (rst,clk)
begin
if rst = '0' then
    EndOfMsg <= '1';
elsif clk'event and clk = '1' then 
    if EoM = '1' then
        EndOfMsg <= '1';
    elsif EndOfMsg = '1' and mdi = '0' then    
		EndOfMsg <= '0';
    end if;
end if ;
end process ;

process (rst,clk)
begin
if rst = '0' then
    Enable_decoder <= '1';
elsif clk'event and clk = '1' then 
    if EndOfMsg = '1' or rx_error = '1' then
        Enable_decoder <= '0';
    elsif mdi5 = '1' then    
		Enable_decoder <= '1';
    end if;
end if ;
end process ;

d_hk<=done_hk;
process (rst,clk)
begin
if rst = '0' then
	done_hk <= '1';
elsif clk'event and clk = '1' then 
	if EndOfMsg = '1' or (rx_error = '1' and mdi = '0') then    
		done_hk<= '1';
	elsif mdi5 = '1' then
		done_hk<= '0';
    end if;
end if ;
end process ;

process (rst,clk)
begin
	if rst = '0' then
		mdi1 <= '0' ;
		mdi2 <= '0' ;
	elsif clk'event and clk = '1' then 
		if Enable_decoder = '0' then
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
    if  Enable_decoder = '0' then
        mdi4 <= '0';
        mdi3 <= '0';
    else    
        mdi4 <= mdi4 or (mdi3 and not mdi);
		mdi3 <= mdi;
	end if;
end if ;
end process ;

process (rst,clk)
begin
if rst = '0' then
	mdi5 <= '0';
elsif clk'event and clk = '1' then 
    if  EndOfMsg = '1' or (rx_error = '1' and mdi = '0') then
		mdi5 <= '0';
    else 
        mdi5 <= mdi5 or ( not mdi5 and mdi); 
	end if;
end if ;
end process ;


--detecto flanco de bajada en shift data para curarme en salud al capturar el dato del msg
process (rst,clk)
begin
if rst = '0' then
    mdi0 <= '0';
elsif clk'event and clk = '1' then 
    if Enable_decoder = '0' then
		mdi0 <= '0';
    else    
		mdi0 <= shift_data;
    end if;
end if ;
end process ;

new_data <= not shift_data and mdi0; 


Enable_freqref <= Enable_decoder; 
enableJohnson <= mdi4; 

clk_enable <= CE and enableJohnson;

-- CONTADOR JOHNSON

process (rst,clk)
begin
if rst = '0' then
    ctd0 <= '0' ;
    ctd1 <= '0' ;
    ctd2 <= '0' ;
elsif clk'event and clk = '1' then
	if  Enable_decoder = '0' then
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

error_happens <= too_long_bit; -- or ( too_short_bit and edgeMDI);

too_long_bit <= '1' when error_counter = ERROR_TIME else '0';

process (error_counter)
begin 
	case (error_counter) is
		when 1 => 
			too_short_bit <= '1';
		when 2 => 
			too_short_bit <= '1';
		when 3 => 
			too_short_bit <= '1';
		when 4 => 
			too_short_bit <= '1';
		when others =>
			too_short_bit <= '0';
	end case;
end process;
				 
process (rst,clk)
begin
	if rst = '0' then
		error_counter <= 0 ;
	elsif clk'event and clk = '1' then 
		if rst_error_counter = '1' or EndOfMsg = '1' or rx_error = '1' then
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

-- process (rst,clk)
-- begin
	-- if rst = '0' then
		-- too_short_bit <= '1' ;
	-- elsif clk'event and clk = '1' then 
		-- if error_counter = ERROR_TIME / 4 then
			-- too_short_bit <= '1';
		-- elsif rst_error_counter = '1' or EndOfMsg = '1' or rx_error = '1' then
			-- too_short_bit <= '0';
		-- end if;
	-- end if ;
-- end process ;


process (rst,clk)
begin
	if rst = '0' then
		rx_error <= '0' ;
	elsif clk'event and clk = '1' then 
		if error_happens = '1' then
			rx_error <= '1';
		elsif EndOfMsg = '1' or (rx_error = '1' and mdi = '0') then--ready2sleep = '1'  then
			rx_error <= '0';
		end if;
	end if ;
end process ;

end ;