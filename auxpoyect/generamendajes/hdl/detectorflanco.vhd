-- detectorflanco.vhd
library igloo;
use igloo.all;

library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity detectorflanco is 
port ( rst   : in    std_logic;
       milisegundos10: in std_logic;
       Clk   : in    std_logic;
	   b_msg : in std_logic; 
	   EN : in std_logic;
	   end_msg : in std_logic;
	   b_modo:in std_logic; 
       din : in std_logic_vector (1 downto 0);
       don : out std_logic_vector (1 downto 0);
	   enREAL : out std_logic );
	   
	   end detectorflanco; 
	   
architecture def_arch of detectorflanco is 
signal primerbiest:  std_logic;
signal segundobiest : std_logic;
signal q :std_logic; 
signal nq :std_logic; 
signal flanco : std_logic; 
signal aux: std_logic  ;



begin

process (clk, rst)
begin 
	if (rst = '0') then
		primerbiest <= '0';
		segundobiest<= '0';
	elsif clk'event and clk = '1' then
		primerbiest<= b_msg;
		segundobiest<= primerbiest; 
	end if; 

end process;

flanco <= primerbiest xor segundobiest;

process (clk, rst)
begin 
	if (rst = '0') then
		q <= '0'; 
       
        
	elsif clk'event and clk = '1' then
		if flanco = '1' then
			q <= '1';
		elsif end_msg = '1' then
			q <= '0';
		end if;
	end if; 
end process;
--enREAL <= q when b_modo = '0' else EN;

process (b_modo, q, EN)
begin
case b_modo is 
        when '0' => enREAL<=q;                   --b_modo indican si está en modo continuo o manda un solo mensaje cada vez que se cambie b_msg
		when '1' => enREAL<=EN;
end case; 
end process;

    
process (clk, rst)
  begin
    if (rst = '0') then 
    aux <= '0';
    don <= (others => '0');
    elsif clk'event and clk = '1' then

         if din(1)='0' and din(0)='0' and milisegundos10='1' and b_modo='1' then
           if aux='0' then 
             don(1)<= '0';
             don(0)<= '0'; 
             aux <= '1';            
           else  
             don(1)<= '1';
             don(0)<= '1';
             aux<= '0';
           end if;
         else 
           don(1) <= din(1);
           don(0) <= din(0);
         end if;
    end if;
end process; 

end def_arch;