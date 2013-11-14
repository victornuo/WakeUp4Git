--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: edgedetector.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO> <Die::AGL030V5> <Package::100 VQFP>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity edgedetector is
port (
   
    sin : in std_logic;
	edge: out std_logic;
	clk: in std_logic;
	rstn : in std_logic
        
);
end edgedetector;

architecture rtl of edgedetector is
   -- signal, component etc. declarations
signal d: std_logic;

begin
process (rstn,clk)
begin
	if rstn = '0' then
		d <= '0' ;
				
	elsif clk'event and clk = '1' then 
		d <= sin;
	end if;
end process;

edge <=  not d and sin;
   -- architecture body
end rtl;
