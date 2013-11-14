-- freq_ref.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all ;
library igloo;
use igloo.all;

entity frec_ref is
    generic ( VALUEREF : integer := 137); --595 para 48 MHZ --137 para 11.0592
    port( rst   : in    std_logic;
          Clk   : in    std_logic;
          CEO    : out   std_logic;
          Enable : in    std_logic
        );

end frec_ref;


architecture DEF_ARCH of frec_ref is 

  signal q : integer range 0 to VALUEREF;

begin 

    process (clk, rst)
    begin

        if (rst = '0') then 
            CEO <= '0';
			q <= 0;
        elsif (clk'event and clk='1') then
            if enable = '1' then
                if q = VALUEREF then
                    CEO <= '1';
					q <=0;
                else
                    q <= q + 1;
					CEO <= '0';
                end if;
            else
                CEO <= '0';
				q <= 0;
             end if;
        end if;
    end process;

end DEF_ARCH;  