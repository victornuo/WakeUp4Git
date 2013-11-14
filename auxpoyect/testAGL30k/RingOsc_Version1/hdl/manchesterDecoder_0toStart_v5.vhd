library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all ;

--library wupu_lib;
--use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;

LIBRARY igloo;
   USE igloo.all;   

-- rstn Reset for clk16, no_bits_rcvd, nrzf
-- clk clock imput used as referenRef_clk for clock recovery, Ref_clknter sampling
-- mdi serial manchester  data input
-- rdn  Control signal initiatea a read operation
-- dout paralell NRZ bus output
-- data_ready Status signal indicating data is present on the data bus dout
-- cambios EoM pasa a ser dataProcRef_clksed
-- el primer flanco q se reciba se proRef_clksa (el primer bit q se espera es un '0')

entity md_v5 is
generic ( ERROR_TIME : integer := RX_ERROR_REF); 
port(  
    mdi  : in std_logic;
	bit_error  : out std_logic;
	RX_end : out std_logic;
	dout  : out std_logic;
	new_data : out std_logic;
	--edge : out std_logic;
	--receivingAux : out std_logic;
	--Aux : out std_logic;	
	rstn: in std_logic ;
	d_hk : out std_logic;
    
	clk: in std_logic  
	
) ;
end md_v5 ;

architecture rtl of md_v5 is

      
signal edgeMDI, newDataEdgeAux, mdi1, mdi2, mdiSync,  receiving, dataFiltered : std_logic; -- para detectar el flanco de subida, el primer bit debe ser un '0'
signal ctd0, ctd1, ctd2 : std_logic;
signal Ref_clk : std_logic;

--signal enableJohnson : std_logic;
signal data : std_logic;
signal error_counter : integer range 0 to ERROR_TIME;
signal error_happens : std_logic;
signal error_flag : std_logic;
signal error_type : std_logic;
--signal too_short_bit : std_logic;
--signal too_long_bit : std_logic;
--signal Ref_clk : std_logic; 

 
signal rst_error_counter : std_logic;

signal Enable_freqref : std_logic;



signal rx_error : std_logic;

signal signalRX_end : std_logic;

component frec_ref 
	generic (VALUEREF : integer :=  DECODER_REF); -- 415 para asegurar que detecto los msgs con wubit.   ,137 para 100 us (fclk*tbit/8) 207 para poder detectar el wup bit y bit end.
    port( rstn   : in    std_logic;
          Clk   : in    std_logic;
		  CEO    : out   std_logic;
          Enable : in    std_logic
        );
end component;


begin
--receivingAux <= receiving;
--edge <= edgeMDI;

 --Aux <= mdiSync;

fre_ref_0 : frec_ref port map
(
	rstn => rstn,
	Clk => clk,
	CEO => Ref_clk, 
	Enable => receiving
);
dout <= data;
RX_end <= signalRX_end; 
--Ref_clk <= Ref_clk;
--signalRX_end <= dataProcRef_clksed or rx_error;
--signalRX_end <=  rx_error;
process (rstn,clk)
begin
	if rstn = '0' then
		mdi1 <= '0' ;
		mdi2 <= '0' ;
		
	elsif clk'event and clk = '0' then 
		if signalRX_end = '1' then
			mdi2 <= '0';
			mdi1 <= '0';
		elsif Ref_clk = '1' then
			--mdi2 <= not mdi1 ;
			mdi2 <= mdi1 ;
			mdi1 <= mdiSync;
		end if;	
	end if;
end process;

edgeMDI <=  ( mdi2 xor mdi1);

data <= not mdi2;


--===============================================================
--Detector de flanco de subida para el primer bit 

process (rstn,clk)
begin
if rstn = '0' then
    mdiSync <= '0';
elsif clk'event and clk = '1' then 
    if signalRX_end = '1' then
		mdiSync <= '0';
	elsif  receiving = '1' then
        mdiSync <= mdi;
	end if;
end if ;
end process ;


--cuando detecto el primer flanco de subida habilito la el clk ref
process (rstn,clk)
begin
if rstn = '0' then
    receiving <= '0';
elsif clk'event and clk = '1' then 
   if signalRX_end = '1' then
		receiving <= '0';
  	elsif mdi = '1'  then
		receiving <= '1';
    end if;
end if ;
end process ;

d_hk <= not receiving;


-- CONTADOR JOHNSON

process (rstn,clk)
begin
if rstn = '0' then
    ctd0 <= '0' ;
    ctd1 <= '0' ;
    ctd2 <= '0' ;
elsif clk'event and clk = '1' then
	if  signalRX_end = '1' then
		ctd2 <= '0';
        ctd1 <= '0';
        ctd0 <= '0';
    elsif Ref_clk = '1' then
        ctd2 <= ctd1 and (ctd0 or ctd2);
        ctd1 <= ctd0;
        ctd0 <= ((edgeMDI  or ctd0) and (not ctd2));
    end if;
end if ;

end process ;

process (rstn,clk)
begin
if rstn = '0' then
    dataFiltered <= '0' ;
elsif clk'event and clk = '1' then 
    if signalRX_end = '1' then
		dataFiltered <= '0';
	elsif Ref_clk = '1' then
        dataFiltered <= edgeMDI and ((not ctd0) and (not ctd2));        
    end if;
end if ;
end process;

process (rstn,clk)
begin
if rstn = '0' then
    newDataEdgeAux <= '0';
elsif clk'event and clk = '1' then 
   	if signalRX_end = '1' then
		newDataEdgeAux <= '0';
	elsif receiving = '1' then
		newDataEdgeAux <= dataFiltered;
   end if;
end if ;
end process ;

new_data <= not dataFiltered and newDataEdgeAux; 



error_happens <= '1' when error_counter = ERROR_TIME else '0';

				 
process (rstn,clk)
begin
	if rstn = '0' then
		error_counter <= 0 ;

	elsif clk'event and clk = '0' then 
		if edgeMDI = '1' or signalRX_end= '1' then-- or rx_error = '1' then
			error_counter <= 0;
		elsif Ref_clk = '1'then -- and rx_error = '0' then	--elsif Ref_clk = '1' then	--elsif Ref_clk = '1' then	
			if error_counter = ERROR_TIME then
				error_counter <= 0;

			else
				error_counter <= error_counter + 1;

			end if;
		end if;
	end if ;
end process ;

process (rstn,clk)
begin
	if rstn = '0' then
		error_flag <= '0' ;
		error_type <= '0';
	elsif clk'event and clk = '1' then 
		if error_happens = '1'  then
			error_flag <= '1';
			error_type <= mdiSync;
		elsif mdiSync = '0' or edgeMDI = '1' then  
			 error_flag <= '0'; 
			 error_type <= '0';
		end if;
	end if ;
end process ;

signalRX_end <= error_flag and not error_type; 
RX_end <= signalRX_end;
bit_error <= error_flag;

-- process (rstn,clk)
-- begin
	-- if rstn = '0' then
		-- rx_error <= '0' ;
	-- elsif clk'event and clk = '1' then 
		-- if  error_happens = '1' and mdiSync = '1' then 
			-- rx_error <= '1';
		-- else 
			 -- rx_error <= '0';
		-- end if;
	-- end if ;
-- end process ;

end ;