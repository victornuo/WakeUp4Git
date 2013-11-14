-- ****************************************************
-- Created by: ACTgen 10.1.3.1
-- Date : Thu Feb 28 12:18:51 2013 
-- Parameters:
--   WIDTH:4
--   DIRECTION:UP
--   CLK_EDGE:RISE
--   CLR_POLARITY:0
--   PRE_POLARITY:2
--   EN_POLARITY:2
--   LD_POLARITY:2
--   TCNT_POLARITY:2
-- ****************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity clkCouter is
  port(Clock : in std_logic;
       Q : out std_logic_vector(3 downto 0);
       Aclr : in std_logic);
end clkCouter;

architecture behavioral of clkCouter is

  signal Qaux : UNSIGNED(3 downto 0);

begin

  process(Clock, Aclr)
  begin

    if (Aclr = '0') then
      Qaux <= (others => '0');
    elsif (Clock'event and Clock = '1') then
      Qaux <= Qaux + 1;
    end if;

  end process;

  Q <= std_logic_vector(Qaux);

end behavioral;
