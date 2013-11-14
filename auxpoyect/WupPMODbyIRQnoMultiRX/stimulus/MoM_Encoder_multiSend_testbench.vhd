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

use work.wupu_pck.all; 

ENTITY TB_pre_MoM_Encoder IS
END TB_pre_MoM_Encoder;
 
ARCHITECTURE preamble OF TB_pre_MoM_Encoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MoM_unit
	PORT(
        RX_port : IN std_logic;
		RX_active : IN std_logic; -- bandera que indica que el receptor esta activo
		RX_commandType: IN  std_logic_vector (1 downto 0); --  generada por el command processor
        RX_commandReady : IN std_logic;
		
		uC_commandType: IN  std_logic; --  generada por el microcontroller (solo necesito un bit el msg 11 ACK solo lo envia la Wupu)
        uC_commandInput : IN std_logic; -- generada por el microcontroller
		ZB_active : IN std_logic; -- el microcontrolador esta despierto
		activate_ZB : OUT std_logic; -- despierto al uC
		
		TX_Active: in std_logic; -- el encoder esta enviando un mensaje
		
		commandType2ZB: OUT  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute o un R2SINK_ACK
        commandReady2ZB : OUT std_logic; 
		---uCcommandinQueue : OUT std_logic;  
		
		NodeAddress : IN std_logic_vector (ADDRESSLENGTH-1 downto 0);
		nextHopAddress : IN std_logic_vector(ADDRESSLENGTH-1 downto 0);
		 
		commandToEncoder : OUT  std_logic_vector (1 downto 0); -- dato que se le pasa a manchester encoder
		
		Enable_encoder : out std_logic; -- habilita en manchester encoder 
		RF_selector : out std_logic; --señal de seleccion para el RF switch 0 para RX_port y 1 para TX
		TX_load : out std_logic;	
		RX_processed : out std_logic;
		ZB_ACK : in std_logic; -- señalq ue indica que el micro ha leido el comando que la MoM le quiere enviar.
		

		MoMState: out std_logic_vector (2 downto 0);
		
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
    END COMPONENT;
        
	component manchesterEncoderComplete
        -- ports
        port( 
            -- Inputs
            din : in std_logic_vector(1 downto 0);
            load_din : in std_logic;
            nextHopAddress : in std_logic_vector(7 downto 0);
            start : in std_logic;
            clk : in std_logic;
            rstn : in std_logic;

            -- Outputs
            dout : out std_logic;
            d_hk : out std_logic;
            TX_Active : out std_logic

            -- Inouts

        );
    end component;
	
   --Inputs
   signal RX_active : std_logic := '0';
   signal RX_commandType : std_logic_vector (1 downto 0) := "00";
   signal RX_commandReady : std_logic := '0';
   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal uC_active : std_logic := '0';
   signal TX_Active : std_logic;
   signal NodeAddress : std_logic_vector(7 downto 0) := "10101010";
   signal uC_ACK : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   --Inputs
   signal new_data : std_logic := '0';
   signal address_bit : std_logic := '0';
  

   --Inputs
   signal din_enc : std_logic := '0';
   signal nextHopAddress : std_logic_vector(7 downto 0):= "11110000";
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
		ZB_active => uC_active,  --- from input
		activate_ZB => activate_uC, -- to output
		TX_Active => TX_Active, -- from encoder
		commandType2ZB => WuR_commandType, -- to output
		commandReady2ZB => WuR_commandReady, -- to output
		NodeAddress => NodeAddress, -- from addressing
		nextHopAddress => nextHopAddress,
		commandToEncoder => comandToSend,-- to encoder
		Enable_encoder => Enable_encoder, -- to encoder
		RF_selector => RF_selector, -- to output
		TX_load => TX_load, -- to encoder
		RX_processed => RX_processed, -- to output
		ZB_ACK => uC_ACK, -- from input
		MoMState => open,
		d_hk => d_hk_mom, -- to output
		clk => clk, -- in
		rst => rst --in
	);
		
	manchester_enc_0: manchesterEncoderComplete PORT MAP (
		din => comandToSend, -- from mom
		nextHopAddress => nextHopAddress, --from addressing data
		load_din => TX_load, -- from mom
		start => Enable_encoder, -- from mom
		TX_Active => TX_Active, --to mom
		d_hk => d_hk_enc, -- output
		dout => mdo, -- output
		clk => clk, 
		rstn => rst
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
	
	-- newData_process :process
	-- begin
		
		-- if (uc_load = '1') then
			-- new_data <= '0';
			-- wait for clk_period*4;
			-- new_data <= '1';
			-- wait for clk_period*4;
		-- else
			-- wait;
		-- end if;
		
	-- end process;

	-- din_process :process
	-- begin
		-- wait for 7us;
		-- if (uc_load = '1') then
			-- address_bit <= '0';
			-- wait for clk_period*3;
			-- address_bit <= '1';
			-- wait for clk_period*3;
		-- else
			-- wait;
		-- end if;
		
	-- end process;
   
   
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
	
	
	wait until falling_edge(TX_Active);
	wait for 1000us;
		
	uC_Active <= '0';
	--wait for 20 us;

	
	wait;
	--wait until falling_edge(TX_Active);
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
