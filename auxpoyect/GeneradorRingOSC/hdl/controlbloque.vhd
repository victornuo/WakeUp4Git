-- controlbloque.vhd

library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

use work.wupu_pck.all;

entity control is 
 
 port (
    clk:in std_logic;
    din : in std_logic;
    TX_active : in std_logic;
    rstn:in std_logic;
    sendMsg: in std_logic;
    MSB_A_B : in std_logic;
	adress3 : in std_logic;
    adress2 : in std_logic;
    adress1 : in std_logic;
    adress0   : in std_logic;
	dout : out std_logic_vector (1 downto 0);
    led5 : out std_logic;
    led6 : out std_logic;
    led7 : out  std_logic;
    led8   : out std_logic;
	led9 : out std_logic;

    leddin1: out std_logic; 
    leddin0: out std_logic;

    nextHopeAdress : out std_logic_vector (ADDRESSLENGTH-1 downto 0); 
    --luzadress:out std_logic_vector(3 downto 0); 
 
 --din : in std_logic_vector (1 downto 0);
 --nextHopAddress : in std_logic_vector (ADDRESSLENGHT-1 downto 0);
    load_TX : out std_logic;
	start_TX : out std_logic
    );
    end control; 
architecture controlada of control is 

signal  address_T : std_logic_vector (3 downto 0);

signal  MSBaddress : std_logic_vector (3 downto 0);


begin 

dout <= '0' & din;
process (clk, rstn)
    begin
        if rstn = '0' then
            start_TX<='0';           

        elsif clk='1' and clk'event then
            if  sendMsg = '1' and TX_Active = '0' then  
				start_TX<= '1'; 
           
		   else 
                start_TX<= '0'; 
            end if;    
            
        end if; 
 end process; 
 
 process (clk, rstn)
    begin
        if rstn = '0' then
            load_TX<= '0';
         

        elsif clk='1' and clk'event then
            if  TX_Active = '1' then  
				load_TX<= '0'; 
           
		   else 
                load_TX <= '1'; 
            end if;    
            
        end if; 
 end process;
	


  MSBaddress <= "1010" when MSB_A_B = '0' ELSE
				"1011";
				
  address_T <= adress3 & adress2 & adress1 & adress0 ;
  nextHopeAdress<= MSBaddress & address_T;
  led9 <=MSB_A_B ;
  led8<=adress3; 
  led7<=adress2;
  led6<=adress1;
  led5<=adress0;
  
  leddin1 <= '0'; 
  leddin0 <= din;  
 
    
end;