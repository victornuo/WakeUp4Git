--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:49:25 07/21/2011
-- Design Name:   
-- Module Name:   C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/manchester_enc/TB_manchester_enc.vhd
-- Project Name:  manchester_enc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: manchester_encoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY TB_manchester_enc IS
END TB_manchester_enc;
 
ARCHITECTURE behavior OF TB_manchester_enc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT manchester_encoder
    PORT(
         din : IN  std_logic;
         nextHopAddress : IN  std_logic_vector(15 downto 0);
         load : IN  std_logic;
         enable : IN  std_logic;
         TX_active : OUT  std_logic;
         end_msg : OUT  std_logic;
         d_hk : OUT  std_logic;
         mdo : OUT  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal din : std_logic := '0';
   signal nextHopAddress : std_logic_vector(15 downto 0) := (others => '0');
   signal load : std_logic := '0';
   signal enable : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal TX_active : std_logic;
   signal end_msg : std_logic;
   signal d_hk : std_logic;
   signal mdo : std_logic;

   -- Clock period definitions
   constant clk_period : time := 90.42ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   manchester_enc_0: 
	manchester_encoder PORT MAP (
          din => din,
          nextHopAddress => nextHopAddress,
          load => load,
          enable => enable,
          TX_active => TX_active,
          end_msg => end_msg,
          d_hk => d_hk,
          mdo => mdo,
          clk => clk,
          rst => rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '0';-- hold reset state for 100ms.
		nextHopAddress <= "1100001100111100";
      wait for 0.01us;	
		rst <= '1';
      din <= '0';
		wait for clk_period*5;
	   load <= '1';
		enable <= '1';
		
		wait for clk_period*4;
		load <= '0';

      -- insert stimulus here 

      wait on end_msg;
		
		wait for 100us; 
		enable <= '0';
		din <= '1';
		wait for clk_period*2;
		load <= '1';
		enable <= '1';
		wait for clk_period*2;
		load <= '0';
		wait;
   end process;

END;
