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
	rstn			: in std_logic;
	sel			   : in std_logic_vector (1 downto 0)
);
end addressingData;

architecture symplified of addressingData is

begin
	process (clk, rstn)
	begin
		if rstn = '0' then
			NodeAddress  <= (others => '0');
			NextHopAddress <= (others => '0');
			addressload <= '0';
		
		elsif clk'event and clk = '1' then
			case sel is
				when "00" =>
					NodeAddress  <=    "00001010";
					NextHopAddress  <= "00001100";
					addressload <= '1';
				when "01" =>
					NodeAddress    <= "00001100";
					NextHopAddress <= "00001110";
					addressload <= '1';
				when "10" =>
					NodeAddress    <= "00001110";
					NextHopAddress <= "00000110";
					addressload <= '1';
				when "11" =>
					NodeAddress    <= "00000110";
					NextHopAddress <= "00000000";
					addressload <= '1';
				when others =>
					NodeAddress    <= "00001111";
					NextHopAddress <= "00001111";
					addressload <= '0';
			end case;
		end if;
	end process;
end ;