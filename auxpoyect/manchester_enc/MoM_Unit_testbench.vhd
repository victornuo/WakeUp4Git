--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:11:47 09/01/2011
-- Design Name:   
-- Module Name:   C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/manchester_enc/MoM_Unit_testbench.vhd
-- Project Name:  manchester_enc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MoM_unit
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
 
ENTITY MoM_Unit_testbench IS
END MoM_Unit_testbench;
 
ARCHITECTURE behavior OF MoM_Unit_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MoM_unit
    PORT(
         RX_active : IN  std_logic;
         RX_commandType : IN  std_logic;
         RX_commandReady : IN  std_logic;
         uC_commandType : IN  std_logic;
         uC_commandReady : IN  std_logic;
         uC_addressingData : IN  std_logic;
         uC_active : IN  std_logic;
         activate_uC : OUT  std_logic;
         TX_active : IN  std_logic;
         TX_messageEnd : IN  std_logic;
         WuR_commandType : OUT  std_logic;
         WuR_commandReady : OUT  std_logic;
         NodeAddress : IN  std_logic_vector(15 downto 0);
         comandToSend : OUT  std_logic;
         Enable_encoder : OUT  std_logic;
         RF_selector : OUT  std_logic;
         TX_load : OUT  std_logic;
         RX_processed : OUT  std_logic;
         uC_ACK : IN  std_logic;
         uC_processed : OUT  std_logic;
         d_hk : OUT  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RX_active : std_logic := '0';
   signal RX_commandType : std_logic := '0';
   signal RX_commandReady : std_logic := '0';
   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal uC_active : std_logic := '0';
   signal TX_active : std_logic := '0';
   signal TX_messageEnd : std_logic := '0';
   signal NodeAddress : std_logic_vector(15 downto 0) := (others => '0');
   signal uC_ACK : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal activate_uC : std_logic;
   signal WuR_commandType : std_logic;
   signal WuR_commandReady : std_logic;
   signal comandToSend : std_logic;
   signal Enable_encoder : std_logic;
   signal RF_selector : std_logic;
   signal TX_load : std_logic;
   signal RX_processed : std_logic;
   signal uC_processed : std_logic;
   signal d_hk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   MoM_test: MoM_unit PORT MAP (
          RX_active => RX_active,
          RX_commandType => RX_commandType,
          RX_commandReady => RX_commandReady,
          uC_commandType => uC_commandType,
          uC_commandReady => uC_commandReady,
          uC_addressingData => uC_addressingData,
          uC_active => uC_active,
          activate_uC => activate_uC,
          TX_active => TX_active,
          TX_messageEnd => TX_messageEnd,
          WuR_commandType => WuR_commandType,
          WuR_commandReady => WuR_commandReady,
          NodeAddress => NodeAddress,
          comandToSend => comandToSend,
          Enable_encoder => Enable_encoder,
          RF_selector => RF_selector,
          TX_load => TX_load,
          RX_processed => RX_processed,
          uC_ACK => uC_ACK,
          uC_processed => uC_processed,
          d_hk => d_hk,
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
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
