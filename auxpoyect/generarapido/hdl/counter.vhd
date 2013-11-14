-- counter.vhd

library igloo;
use igloo.all;

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity contador is
    
    port( rst   : in    std_logic;
          Clk   : in    std_logic;
		  EN    : in    std_logic;
          milisegundos10: out std_logic

        );

end contador;


architecture def_arch of contador is 

signal cuenta : integer range 0 to 480000;


begin
milisegundos10 <='1' when cuenta = 480000 else '0';

process (clk, rst)
begin
    if (rst = '0') then
       
        cuenta<= 0;
       
     
    elsif clk'event and clk = '1' then
        
        if EN ='1' then 
           if cuenta = 480000 then 
                  cuenta<=0;
			else
                cuenta<= cuenta + 1;    
			end if;
		end if;
    end if;
end process;

end def_arch;