-- adressingData.vhd
-- data_ctrl.vhd
-- This is a sample state-machine using enumerated types.
-- This will allow the synthesis tool to select the appropriate
-- encoding style and will make the code more readable.
 
--Insert the following in the architecture before the begin keyword
   --Use descriptive names for the states, like st1_reset, st2_search
library ieee ;
use ieee.std_logic_1164.all ;

use work.wupu_pck.all;

entity addressingData is

port (
    NodeAddress : out std_logic_vector (ADDRESSLENGTH-1 downto 0);
	NextHopAddress : out std_logic_vector (ADDRESSLENGTH-1 downto 0);
	--addressload 	:out std_logic;
	clk			: in std_logic;
	rstn			: in std_logic;
	selAdd		   : in std_logic_vector (2 downto 0);
	-- selExp		   : in std_logic
	selExp		   : in std_logic_vector (1 downto 0)
);
end addressingData;

architecture symplified of addressingData is
signal sel_MSB: std_logic;
signal sel_Low_add :std_logic_vector (1 downto 0);
signal MSB_NodeAddress : std_logic_vector ((ADDRESSLENGTH/2)-1 downto 0);
signal LSB_NodeAddress :std_logic_vector ((ADDRESSLENGTH/2)-1 downto 0);
signal MSB_NextHopAddress : std_logic_vector ((ADDRESSLENGTH/2)-1 downto 0);
signal LSB_NextHopAddress :std_logic_vector ((ADDRESSLENGTH/2)-1 downto 0);

begin

sel_MSB <= selAdd(2);
sel_Low_add <= selAdd(1 downto 0);


NodeAddress <= MSB_NodeAddress & LSB_NodeAddress;
NextHopAddress <= MSB_NextHopAddress & LSB_NextHopAddress;


LSB_NodeAddress <=  "1101" when sel_Low_add = "00" ELSE
					"1011" when sel_Low_add = "01" ELSE
					"0111" when sel_Low_add = "10" ELSE
					"1110" when sel_Low_add = "11" ELSE
					"1111";
					
MSB_NodeAddress <=  "1010" when sel_MSB = '0' ELSE
					"1011" when sel_MSB = '1' ELSE
					"1111";					

MSB_NextHopAddress  <= "1010" when selExp = "11" and sel_MSB = '1' and sel_Low_add = "00" ELSE
					"0000" when selExp = "10" and sel_Low_add = "10" ELSE
					"0000" when sel_Low_add = "00" ELSE
					-- "0000" when selExp = '0' and sel_Low_add = "10" ELSE
					-- "1010" when selExp = '1' and sel_MSB = '1' and sel_Low_add = "00" ELSE
					"1010" when sel_MSB = '0' ELSE
					"1011" when sel_MSB = '1' ELSE
					"1111";	
					
LSB_NextHopAddress <= "1110" when selExp = "11" and sel_MSB = '1' and sel_Low_add = "00" ELSE
					"0000" when selExp = "10" and sel_Low_add = "10" ELSE
					"0000" when sel_Low_add = "00" ELSE
					-- "0000" when selExp = '0' and sel_Low_add = "10" ELSE
					-- "1110" when selExp = '1' and sel_MSB = '1' and sel_Low_add = "00" ELSE
					LSB_NodeAddress(0)&LSB_NodeAddress(3 downto 1) ;						
end ;