-- controlbloque.vhd

library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

use work.wupu_pck.all;

entity control is 
 
 port (
    clk:in std_logic;
    din : in std_logic_vector (1 downto 0);
    end_msg : in std_logic;
    rst:in std_logic;
    milisegundos10: in std_logic;
    start: in std_logic;
    adress1 : in std_logic;
    adress2 : in std_logic;
    adress3 : in std_logic;
    adress4   : in std_logic;
    led1 : out std_logic;
    led2 : out std_logic;
    led3 : out  std_logic;
    led4   : out std_logic;

    leddin1: out std_logic; 
    leddin0: out std_logic;

    nextHopeAdress : out std_logic_vector (ADDRESSLENGTH-1 downto 0); 
    --luzadress:out std_logic_vector(3 downto 0); 
 
 --din : in std_logic_vector (1 downto 0);
 --nextHopAddress : in std_logic_vector (ADDRESSLENGHT-1 downto 0);
    load : out std_logic;
	enable : out std_logic
    );
    end control; 
architecture controlada of control is 

signal  luz : std_logic_vector (3 downto 0);


begin 
process (clk, rst)
    begin
        if rst = '0' then
            load<= '0';
            enable<='0';           

        elsif clk='1' and clk'event then
            if start = '1' then
                if  milisegundos10= '1' then  
                    load<= '1'; 
                    enable<= '1'; 

                elsif end_msg = '1' then 
                    enable<='0'; 
                else 
                    load <='0';
                end if;    
            end if;

        end if; 
 end process; 
	



  luz <= adress1 & adress2 & adress3 & adress4 ;
  nextHopeAdress<= luz & luz & luz & luz;
  led1<=adress1; 
  led2<=adress2;
  led3<=adress3;
  led4<=adress4;
 
    
end;