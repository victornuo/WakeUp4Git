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

signal cuenta : integer range 0 to 2**16 -1;
signal milisegundos : integer range 0 to 2**16 -1;


begin

process (clk, rst)
begin
    if (rst = '0') then
       
        cuenta<= 0;
        milisegundos<= 0;
        milisegundos10<='0';
      

    elsif clk'event and clk = '1' then
        
           if EN ='1' then 
           if cuenta < 48000 then 
                  cuenta<=cuenta+1;
                    milisegundos10<='0';
                    
                  

 
           else cuenta <= 0; 
                 if milisegundos < 2000 then 
                    milisegundos <= milisegundos +1;
                    
                    milisegundos10<='0';
                    

               else milisegundos <= 0;
                    milisegundos10<='1';
                    
                    
                 end if; 
             end if;
         


           end if;
           end if; 
  
 
    
end process;

end def_arch;