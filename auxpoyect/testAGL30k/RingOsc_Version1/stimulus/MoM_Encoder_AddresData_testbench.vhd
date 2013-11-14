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
 
ENTITY TB_pre_MoM_Encoder IS
END TB_pre_MoM_Encoder;
 
ARCHITECTURE preamble OF TB_pre_MoM_Encoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MoM_unit
    PORT(
		RX_port : IN std_logic;
		RX_active : IN  std_logic;
		RX_commandType : IN  std_logic_vector (1 downto 0);
		RX_commandReady : IN  std_logic;
		uC_commandType : IN  std_logic;
		uC_commandInput : IN  std_logic;
		uC_active : IN  std_logic;
		activate_uC : OUT  std_logic;
		TX_messageEnd : IN  std_logic;
		commandType2uC: OUT  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute o un R2SINK_ACK
        commandReady2uC : OUT std_logic;
		uCcommandinQueue : OUT std_logic;  		
		NodeAddress : IN  std_logic_vector(15 downto 0);
		nextHopAddress : IN std_logic_vector(15 downto 0);
		commandToEncoder : OUT  std_logic_vector (1 downto 0);
		Enable_encoder : OUT  std_logic;
		RF_selector : OUT  std_logic;
		TX_load : OUT  std_logic;
		RX_processed : OUT  std_logic;
		uC_ACK : IN  std_logic;
		MoMState: out std_logic_vector (2 downto 0);
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
    END COMPONENT;
        
	COMPONENT manchester_encoder
    PORT(
		din : IN  std_logic_vector (1 downto 0);
		nextHopAddress : IN  std_logic_vector(15 downto 0);
		load : IN  std_logic;
		enable : IN  std_logic;
		end_msg : OUT  std_logic;
		d_hk : OUT  std_logic;
		dout : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
    END COMPONENT;
	
   --Inputs
   signal RX_active : std_logic := '0';
   signal RX_commandType : std_logic_vector (1 downto 0) := "00";
   signal RX_commandReady : std_logic := '0';
   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal uC_active : std_logic := '0';
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
   signal comandToSend : std_logic_vector (1 downto 0);
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
   constant R2SINK : std_logic_vector (1 downto 0) := "00";
   constant rRouteNWK : std_logic_vector (1 downto 0) := "10";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	MoM_test: MoM_unit PORT MAP (
		RX_port => '0',
		RX_active => RX_active, ---- from input
		RX_commandType => RX_commandType,---- from input
		RX_commandReady => RX_commandReady,---- from input
		uC_commandType => uC_commandType,---- from input
		uC_commandInput => uC_commandReady,---- from input
		uC_active => uC_active,  --- from input
		activate_uC => activate_uC, -- to output
		TX_messageEnd => TX_messageEnd, -- from encoder
		commandType2uC => WuR_commandType, -- to output
		commandReady2uC => WuR_commandReady, -- to output
		NodeAddress => NodeAddress, -- from addressing
		nextHopAddress => "0000000000000000",
		commandToEncoder => comandToSend,-- to encoder
		Enable_encoder => Enable_encoder, -- to encoder
		RF_selector => RF_selector, -- to output
		TX_load => TX_load, -- to encoder
		RX_processed => RX_processed, -- to output
		uC_ACK => uC_ACK, -- from input
		MoMState => open,
		d_hk => d_hk_mom, -- to output
		clk => clk, -- in
		rst => rst --in
	);
		
	manchester_enc_0: manchester_encoder PORT MAP (
		din => comandToSend, -- from mom
		nextHopAddress => "0000000000000000", --from addressing data
		load => TX_load, -- from mom
		enable => Enable_encoder, -- from mom
		end_msg => TX_messageEnd, --to mom
		d_hk => d_hk_enc, -- output
		dout => mdo, -- output
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
		
	wait for 15us;
	uC_Active <= '0';
	
	wait for 150us;
	
	uC_Active <= '1';
	wait for 10us;
	uC_commandType  <= rRouteNWK(1); 
	wait for 54 ns;
	uC_commandReady <= '1'; 
	
	wait until rising_edge(uC_processed);
	wait for 1us; 
	uC_commandReady <= '0';
	wait for  90 ns;
	
	
	wait until falling_edge(TX_messageEnd);
	wait for 1000us;
		
	uC_Active <= '0';
	--wait for 20 us;

	
	wait;
	--wait until falling_edge(TX_messageEnd);
	--wait for clk_period;

	--RX_commandReady <= '0';
		
	-- wait until  rising_edge(activate_uC);
	-- wait for 6us;
	-- uC_Active <= '1';
	
	-- wait for clk_period;
	-- uC_ACK <= '1';
	-- wait until falling_edge(uc_processed);
	-- uC_commandReady <= '0';	
	
	-- wait for clk_period;
	-- uC_ACK <= '0';
	
	-- wait until falling_edge(uc_processed);
	-- uC_commandReady <= '0';	
	
	-- wait for 15us;
	-- uC_Active <= '0';

    wait;
   end process;

END;
