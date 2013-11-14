--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:56:52 09/15/2011
-- Design Name:   
-- Module Name:   C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/manchester_enc/addressinsymple.vhd
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
 
ENTITY addressinsymple IS
END addressinsymple;
 
ARCHITECTURE behavior OF addressinsymple IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT addressingData
    PORT(
         NodeAddress : OUT  std_logic_vector(15 downto 0);
         NextHopAddress : OUT  std_logic_vector(15 downto 0);
         sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';

 	--Outputs
   signal NodeAddress : std_logic_vector(15 downto 0);
   signal NextHopAddress : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: addressingData PORT MAP (
          NodeAddress => NodeAddress,
          NextHopAddress => NextHopAddress,
          sel => sel
        );
 
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
		sel <= not sel;
		
		wait for 10 ms;

   end process;

END;
