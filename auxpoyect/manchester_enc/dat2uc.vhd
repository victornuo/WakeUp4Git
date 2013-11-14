--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:33 09/05/2011
-- Design Name:   
-- Module Name:   C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/manchester_enc/dat2uc.vhd
-- Project Name:  manchester_enc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: addressingData
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
 
ENTITY dat2uc IS
END dat2uc;
 
ARCHITECTURE behavior OF dat2uc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT addressingData
    PORT(
         new_data : IN  std_logic;
         din : IN  std_logic;
         load : IN  std_logic;
         NodeAddress : OUT  std_logic_vector(15 downto 0);
         NextHopAddress : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         done_hk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal new_data : std_logic := '0';
   signal din : std_logic := '0';
   signal load : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal NodeAddress : std_logic_vector(15 downto 0);
   signal NextHopAddress : std_logic_vector(15 downto 0);
   signal done_hk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   dat2uc: addressingData PORT MAP (
          new_data => new_data,
          din => din,
          load => load,
          NodeAddress => NodeAddress,
          NextHopAddress => NextHopAddress,
          clk => clk,
          rst => rst,
          done_hk => done_hk
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
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
