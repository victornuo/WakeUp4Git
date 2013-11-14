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

library igloo;
use igloo.all;
 
ENTITY FF_MoM_Encoder_Address IS
END FF_MoM_Encoder_Address;
 
ARCHITECTURE behavior OF FF_MoM_Encoder_Address IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	component LowPowerManagement is

	port( Flash_Freeze_N    : in    std_logic;
		  RST_N             : in    std_logic;
		  CLK               : in    std_logic;
		  CLK_GATED         : out   std_logic;
		  Done_Housekeeping : in    std_logic;
		  Wait_Housekeeping : out   std_logic;
		  SleepActive       : out   std_logic
		);

	end component;
    
	COMPONENT MoM_unit
    PORT(
		RX_active : IN  std_logic;
		RX_commandType : IN  std_logic;
		RX_commandReady : IN  std_logic;
		uC_commandType : IN  std_logic;
		uC_commandInput : IN  std_logic;
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
    
	COMPONENT addressingData
    PORT(
		new_data : IN  std_logic;
		din : IN  std_logic;
		load : IN  std_logic;
		NodeAddress : OUT  std_logic_vector(15 downto 0);
		NextHopAddress : OUT  std_logic_vector(15 downto 0);
		clk : IN  std_logic;
		rst : IN  std_logic
        );
    END COMPONENT;
	
	signal AUX_CLK : std_logic_vector (0 downto 0);
	signal AUX_CLK_GATED : std_logic_vector (0 downto 0);
	signal main_clk : std_logic;
	signal d_hk_ff : std_logic;
	signal ff_enabled : std_logic;
	signal wakeup : std_logic := '1';
	
	signal hk_done : std_logic;
   
   --Inputs
   signal RX_active : std_logic := '0';
   signal RX_commandType : std_logic := '0';
   signal RX_commandReady : std_logic := '0';
   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal uC_active : std_logic := '0';
   signal TX_active : std_logic;
   signal TX_messageEnd : std_logic;
   signal NodeAddress : std_logic_vector(15 downto 0);
   signal uC_ACK : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   --Inputs
   signal new_data : std_logic := '0';
   signal address_bit : std_logic := '0';
  

   --Inputs
   signal din_enc : std_logic := '0';
   signal nextHopAddress : std_logic_vector(15 downto 0);
   signal uc_load : std_logic := '1';
   signal enable : std_logic := '0';
  
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
   signal d_hk_mom : std_logic;

 	--Outputs
  -- signal end_msg : std_logic;
   signal d_hk_enc : std_logic;
   signal mdo : std_logic;

   -- Clock period definitions
   constant clk_period : time := 90.42ns;
   constant R2SINK : std_logic := '0';
   constant rRouteNWK : std_logic := '1';
 
BEGIN
 
	-- Instantiate the Units Under Test
	FF_U :LowPowerManagement port map(
		Flash_Freeze_N=>wakeup,
		RST_N=>rst,
		CLK=>main_clk,
		CLK_GATED=>clk,
		Wait_Housekeeping=>d_hk_ff,
		Done_Housekeeping=>hk_done,
		SleepActive=>ff_enabled
	);
			
	MoM_test: MoM_unit PORT MAP (
		RX_active => RX_active, ---- from input
		RX_commandType => RX_commandType,---- from input
		RX_commandReady => RX_commandReady,---- from input
		uC_commandType => uC_commandType,---- from input
		uC_commandInput => uC_commandReady,---- from input
		uC_addressingData => uC_addressingData,---- from input
		uC_active => uC_active,  --- from input
		activate_uC => activate_uC, -- to output
		TX_active => TX_active,---- from encoder
		TX_messageEnd => TX_messageEnd, -- from encoder
		WuR_commandType => WuR_commandType, -- to output
		WuR_commandReady => WuR_commandReady, -- to output
		NodeAddress => NodeAddress, -- from addressing
		comandToSend => comandToSend,-- to encoder
		Enable_encoder => Enable_encoder, -- to encoder
		RF_selector => RF_selector, -- to output
		TX_load => TX_load, -- to encoder
		RX_processed => RX_processed, -- to output
		uC_ACK => uC_ACK, -- from input
		uC_processed => uC_processed, -- to output
		d_hk => d_hk_mom, -- to output
		clk => clk, -- in
		rst => rst --in
	);
	
	manchester_enc_0: manchester_encoder PORT MAP (
		din => comandToSend, -- from mom
		nextHopAddress => nextHopAddress, --from addressing data
		load => TX_load, -- from mom
		enable => Enable_encoder, -- from mom
		TX_active => TX_active, -- to mom
		end_msg => TX_messageEnd, --to mom
		d_hk => d_hk_enc, -- output
		mdo => mdo, -- output
		clk => clk, 
		rst => rst
	);
	
	add_dat_uc: addressingData PORT MAP (
		new_data => new_data, -- from input
		din => address_bit, --from input
		load => uc_load, -- from input
		NodeAddress => NodeAddress, -- to mom
		NextHopAddress => NextHopAddress, -- to encoder
		clk => clk,
		rst => rst
	);

   
  hk_done <= d_hk_enc and d_hk_mom and d_hk_ff;
   
   -- Clock process definitions
   
   clk_process :process
   begin
		main_clk <= '0';
		wait for clk_period/2;
		main_clk <= '1';
		wait for clk_period/2;
   end process;
 
load_process :process
	begin
		uc_load <= '1';
		wait for 30us;
		uc_load <= '0';
		wait;
	end process;
	
	newData_process :process
	begin
		
		if (uc_load = '1') then--wait for 13us;
			new_data <= '0';
			wait for clk_period*4;
			new_data <= '1';
			wait for clk_period*4;
		else
			wait;
		end if;
		
	end process;

	din_process :process
	begin
		--wait for 7us;
		if (uc_load = '1') then
			address_bit <= '0';
			wait for clk_period*3;
			address_bit <= '1';
			wait for clk_period*3;
		else
			wait;
		end if;
		
	end process;
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
	rst <= '0';
	RX_commandType <= rRouteNWK; 
	wait for clk_period*3.2;	
	rst <= '1';
	wait for clk_period*11.3;
	
	wait until falling_edge(uc_load);
	
	RX_commandReady <= '1';
	wait until rising_edge(activate_uC);
	wait for 6us;
	uC_Active <= '1';
	
	wait for clk_period;
	uC_ACK <= '1';

	wait until falling_edge(RX_processed);
	RX_commandReady <= '0';
	--activate_uC <= '1';
	uc_ACK <= '0';
	wait for 1us;
	wakeup <= '0';
	
	
	wait for 100us;
	wakeup <= '1';
	wait until falling_edge(ff_enabled);
	uC_Active <= '0';
	
	wait for 150us;
	
	uC_Active <= '1';
	wait for 10us;
	uC_commandType  <= rRouteNWK; 
	wait for 54 ns;
	uC_commandReady <= '1'; 
	wakeup <= '0';
	
	wait until rising_edge(uC_processed);
	wait for 1us; 
	uC_commandReady <= '0';
	wait for  90 ns;
	
	
	wait until falling_edge(TX_messageEnd);
	wait for 1000us;
	wakeup <= '1';
	wait until falling_edge(ff_enabled);
	uC_Active <= '0';
	wakeup <= '0';
	--wait for 20 us;

	
	wait;
	

    wait;
   end process;

END;
