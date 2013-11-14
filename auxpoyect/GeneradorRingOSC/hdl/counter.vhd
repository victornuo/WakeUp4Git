-- counter.vhd



library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

use work.wupu_pck.all;

entity contador is
    
    port( rstn   : in    std_logic;
          Clk   : in    std_logic;
		  EN    : in    std_logic;
          milisegundos10: out std_logic;
		  milisegundos100: out std_logic;
		  milisegundos1000: out std_logic

        );

end contador;


architecture def_arch of contador is 

constant timeRef : integer := FCLK/100;
signal cuenta10 : integer range 0 to timeRef;
signal cuenta100 : integer range 0 to timeRef*10;
signal cuenta1000 : integer range 0 to timeRef*100;

signal ms10 : std_logic;
signal ms100 : std_logic;
signal ms1000 : std_logic;


begin
milisegundos10 <= ms10;
milisegundos100<= ms100; 
milisegundos1000<= ms1000;

ms10 <='1' when cuenta10 = timeRef else '0';

process (clk, rstn)
begin
    if (rstn = '0') then
        cuenta10<= 0;
		
	elsif clk'event and clk = '1' then
        
        if EN ='1' then 
           if cuenta10 = timeRef then 
                  cuenta10<=0;
			else
				cuenta10<= cuenta10 + 1;    
			end if;
		end if;
    end if;
end process;

ms100 <='1' when cuenta100 = timeRef*10 else '0';
process (clk, rstn)
begin
    if (rstn = '0') then
            cuenta100<= 0;
		--	milisegundos100 <= '0';
    elsif clk'event and clk = '1' then
        
        if EN ='1'  then 
           if cuenta100 = timeRef*10 then 
                  cuenta100<=0;
			--	  milisegundos100 <= '1';
			else
                cuenta100<= cuenta100 + 1;   
			--	milisegundos100 <= '0';				
			end if;
		end if;
    end if;
end process;

ms1000 <='1' when cuenta1000 = timeRef*100 else '0';
process (clk, rstn)
begin
    if (rstn = '0') then
            cuenta1000<= 0;
			--milisegundos1000 <= '0';
         
    elsif clk'event and clk = '1' then
        
        if EN ='1'  then 
           if cuenta1000 = timeRef*100 then 
                  cuenta1000<=0;
			--	  milisegundos1000 <= '1';
			else
                cuenta1000<= cuenta1000 + 1; 
			--	milisegundos1000 <= '0';
			end if;
		end if;
    end if;
end process;

end def_arch;