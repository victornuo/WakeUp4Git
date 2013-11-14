-- ZBControl.vhd
library ieee ;
use ieee.std_logic_1164.all ;

--use work.ASCII_Char.all;

entity InintialMsgInjector is

port (
  
	
	NewMsgInjector : OUT std_logic; -- el microcontrolador esta despierto

	
	clk			: in std_logic;
	clear 		: in std_logic;
	rstn			: in std_logic

);
end InintialMsgInjector;

architecture symplified of InintialMsgInjector is



signal aux1 : std_logic;
signal aux2 : std_logic; 
signal aux3: std_logic;
signal aux4 : std_logic;
signal aux5 : std_logic;

begin
	
	NewMsgInjector <=  aux4;
	
	process (clk, rstn)
	begin
		if (rstn = '0') then
			aux1 <= '0';
			aux2 <= '0';		
			aux3 <= '0';
			aux4 <= '0';
		
		elsif (clk'event and clk= '1' ) then	
			if aux5 = '1' then
				aux1 <= '0';
				aux2 <= '0';		
				aux3 <= '0';
				aux4 <= '0';
			else
				aux1 <= '1';
				aux2 <= aux1;		
				aux3 <= aux2;
				aux4 <= aux3;
			end if;
		end if;	  
	end process;

	process (clk, rstn)
	begin
		if (rstn = '0') then
			aux5 <= '0';
		
		elsif (clk'event and clk= '1' ) then	
			if clear = '1' then
				aux5 <= '1';
			end if;
		end if;	  
	end process;
	
end ;