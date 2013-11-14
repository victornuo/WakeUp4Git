-- adressingData.vhd
-- data_ctrl.vhd
-- This is a sample state-machine using enumerated types.
-- This will allow the synthesis tool to select the appropriate
-- encoding style and will make the code more readable.
 
--Insert the following in the architecture before the begin keyword
   --Use descriptive names for the states, like st1_reset, st2_search
library ieee ;
use ieee.std_logic_1164.all ;

entity addressingData is

port (
    NodeAddress : out std_logic_vector (15 downto 0);
	NextHopAddress : out std_logic_vector (15 downto 0);
	sel			   : in std_logic
);
end addressingData;

architecture symplified of addressingData is
constant address1 : std_logic_vector (15 downto 0) := "1111000011110000";
constant address2 : std_logic_vector (15 downto 0) := "0000111100001111";
begin
	process (sel)
	begin
		case (sel) is
			when '1' =>
				NodeAddress (15 downto 0) <= address1;
				NextHopAddress (15 downto 0) <= address2;
			when '0' => 
				5  (15 downto 0) <= address1;
				NodeAddress (15 downto 0) <= address2;
			when others =>
				NextHopAddress  (15 downto 0) <= address1;
				NodeAddress (15 downto 0) <= address2;
		end case;
	end process;
end ;