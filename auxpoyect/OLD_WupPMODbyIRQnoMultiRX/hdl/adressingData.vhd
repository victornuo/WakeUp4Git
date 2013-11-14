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
	addressload 	:out std_logic;
	clk			: in std_logic;
	rst			: in std_logic;
	sel			   : in std_logic_vector (1 downto 0)
);
end addressingData;

architecture symplified of addressingData is
constant address1 : std_logic_vector (ADDRESSLENGTH-1 downto 0) := "11110000";
begin
	process (clk, rst)
	begin
		if rst = '0' then
			NodeAddress  <= (others => '0');
			NextHopAddress <= (others => '0');
			addressload <= '0';
		elsif clk'event and clk = '1' then
			case sel is
				when "00" =>
					NodeAddress  <=    "10101010";
					NextHopAddress  <= "11001100";
					addressload <= '1';
				when "01" =>
					NodeAddress    <= "11001100";
					NextHopAddress <= "11101110";
					addressload <= '1';
				when "10" =>
					NodeAddress    <= "11101110";
					NextHopAddress <= "01100110";
					addressload <= '1';
				when "11" =>
					NodeAddress    <= "01100110";
					NextHopAddress <= "00000000";
					addressload <= '1';
				when others =>
					NodeAddress    <= "11111111";
					NextHopAddress <= "11111111";
					addressload <= '0';
			end case;
		end if;
	end process;
end ;