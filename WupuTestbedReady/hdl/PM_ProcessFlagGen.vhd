--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: PM_ProcessFlagGen.vhd
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

entity ProcessFlagGen is
port (
   
    MoMState : in std_logic_vector(2 downto 0);
	ProcessFlag: out std_logic;
	clearPF: in std_logic;
	clk: in std_logic;
	rstn : in std_logic
        
);
end ProcessFlagGen;

architecture rtl of ProcessFlagGen is
   -- signal, component etc. declarations
signal prev_MomState: std_logic;
signal act_MomState: std_logic;

begin
	
	process (rstn,clk)
	begin
		if rstn = '0' then
			prev_MomState <= '0' ;
					
		elsif clk'event and clk = '1' then 
			if MoMState = "101" then
				prev_MomState <= '1';
			else 
				prev_MomState <= '0';
			end if;
		end if;
	end process;
	
	act_MomState <= '1' when MoMState = "100" ELSE
					'1' when MoMState = "111" ELSE
					'0';
						
	ProcessFlag <=  prev_MomState and act_MomState ;
	

   -- architecture body
end rtl;
