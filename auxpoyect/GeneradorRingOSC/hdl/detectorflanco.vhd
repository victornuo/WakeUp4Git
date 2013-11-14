-- detectorflanco.vhd
library igloo;
use igloo.all;

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity detectorflanco is 
port ( rstn   : in    std_logic;
       Clk   : in    std_logic;
	   b_msg : in std_logic;
	   ext_trig : in std_logic;	 
	   edge : out std_logic);
	   
end detectorflanco; 
	   
architecture def_arch of detectorflanco is 

signal flancoBoton : std_logic;
signal flancoExtTrig : std_logic;

signal bd0 : std_logic;
signal bd1 : std_logic;
signal ed0 : std_logic;
signal ed1 : std_logic;

begin

flancoBoton <= bd0 xor bd1;
edge <= flancoBoton or flancoExtTrig;
process (clk, rstn)
begin

	if rstn = '0' then 
		bd0 <= '0';
		bd1 <= '0';
		
	elsif clk'event and clk = '1' then
	
		bd0 <= b_msg;
		bd1 <= bd0;
	
	end IF;
	
end process;

flancoExtTrig <= ed0 xor ed1;
process (clk, rstn)
begin

	if rstn = '0' then 
		ed0 <= '0';
		ed1 <= '0';
		
	elsif clk'event and clk = '1' then
	
		ed0 <= ext_trig;
		ed1 <= ed0;
	
	end IF;
end process;



end def_arch;