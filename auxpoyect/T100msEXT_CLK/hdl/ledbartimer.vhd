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

entity ledbarTimer is
  port(Clock : in std_logic;
       Q : out std_logic_vector(9 downto 0);
       Aclr : in std_logic);
end ledbarTimer;

architecture behavioral of ledbarTimer is

  signal Qaux : integer range 0 to 10**6;
  signal EnabLed : std_logic;
  signal Ledaux : unsigned (9 downto 0);
begin

  enableLedbars_p: process(Clock, Aclr)
  begin

    if (Aclr = '0') then
      Qaux <= 0;
    elsif (Clock'event and Clock = '1') then
      Qaux <= Qaux + 1;
    end if;

  end process;

	EnabLed <= '1' when Qaux = 10**6 else '0';
  
    ledbarCouter_p: process(Clock, Aclr)
	begin

    if (Aclr = '0') then
      Ledaux <= (others => '0');
    elsif (Clock'event and Clock = '1') then
		if EnabLed = '1' then
			Ledaux <= Ledaux + 1;
		end if;
    end if;

  end process;

  Q <= std_logic_vector (Ledaux);
  
end behavioral;
