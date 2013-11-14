--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:11:06 01/11/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/ise_projects/practica3/mom.vhd
-- Project Name:  practica3
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
 
ENTITY TB_pre_mom IS
END TB_pre_mom ;
 
ARCHITECTURE preamble OF TB_pre_mom IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MoM_unit
    PORT(
		RX_port : IN std_logic;
		RX_active : IN std_logic; -- bandera que indica que el receptor esta activo
		RX_commandType: IN  std_logic_vector (1 downto 0); --  generada por el command processor
        RX_commandReady : IN std_logic;
		RX_addressOK : IN std_logic;
		
		uC_commandType: IN  std_logic; --  generada por el microcontroller (solo necesito un bit el msg 11 ACK solo lo envia la Wupu)
        uC_commandReady : IN std_logic; -- generada por el microcontroller
		ZB_active : IN std_logic; -- el ctrl de ZB esta activo
				
		TX_Active: in std_logic; -- el encoder esta enviando un mensaje
		
		commandType2ZB: OUT  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute o un R2SINK
        commandReady2ZB : OUT std_logic; 

		nextHopAddress : IN std_logic_vector(ADDRESSLENGTH-1 downto 0);
		 
		commandToEncoder : OUT  std_logic_vector (1 downto 0); -- dato que se le pasa a manchester encoder
		
		Enable_encoder : out std_logic; -- habilita en manchester encoder 
		RF_selector : out std_logic; --señal de seleccion para el RF switch 0 para RX_port y 1 para TX
		TX_load : out std_logic;	
		RX_processed : out std_logic;
		--ZB_ACK : in std_logic; -- señalq ue indica que el ZB ctrl ha leido el comando que la MoM le quiere enviar.
		

		MoMState: out std_logic_vector (2 downto 0);
		
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
    END COMPONENT;


   --Inputs
   signal RX_port : std_logic := '0';
   signal RX_active : std_logic := '0';
   signal RX_commandType : std_logic_vector(1 downto 0) := (others => '0');
   signal RX_commandReady : std_logic := '0';
   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal ZB_active : std_logic := '0';
   signal TX_messageEnd : std_logic := '0';
   signal NodeAddress : std_logic_vector(ADDRESSLENGTH-1 downto 0) 	:= "11110000";
   signal nextHopAddress : std_logic_vector(ADDRESSLENGTH-1 downto 0):= (others => '0'); --"0101010101010101";
  -- signal uc_ACK : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal activate_uC : std_logic;
   signal commandType2ZB : std_logic;
   signal commandReady2ZB : std_logic;
   signal RX_addressOK : std_logic := '0';
   signal commandToEncoder : std_logic_vector(1 downto 0);
   signal Enable_encoder : std_logic;
   signal RF_selector : std_logic;
   signal TX_load : std_logic;
   signal RX_processed : std_logic;
   signal MoMState : std_logic_vector(2 downto 0);
   signal d_hk : std_logic;
	
	signal microCommand : std_logic := '0';
   -- Clock period definitions
   	constant clk_period : time := 90.42ns;
	constant HALFBIT : time := 150us;
	constant HALFBIT_L : time := 180us;
	constant HALFBIT_S : time := 120us;
	
	constant R2SINK : std_logic_vector (1 downto 0) := "00";
	constant NWKRroute : std_logic_vector (1 downto 0) := "10";
	--constant R2SACK : std_logic_vector (1 downto 0) := "11";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	Mom_wupu: MoM_unit PORT MAP (
		RX_port => RX_port,
		RX_active => RX_active,
		RX_commandType => RX_commandType,
		RX_commandReady => RX_commandReady,
		RX_addressOK => RX_addressOK,
		uC_commandType => uC_commandType,
		uC_commandReady => uC_commandReady,
		ZB_active => ZB_active,
		--activate_uC => activate_uC,
		TX_Active => TX_messageEnd,
		commandType2ZB => commandType2ZB,
		commandReady2ZB => commandReady2ZB,
		--uCcommandinQueue => uCcommandinQueue,
		--NodeAddress => NodeAddress,
		nextHopAddress => nextHopAddress,
		commandToEncoder => commandToEncoder,
		Enable_encoder => Enable_encoder,
		RF_selector => RF_selector,
		TX_load => TX_load,
		RX_processed => RX_processed,
		---- uc_ACK => -- uc_ACK,
		MoMState => MoMState,
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
 
   ucCommand_ready_prco :process
   begin
	
	wait until microCommand = '1';
	uC_commandReady <= '1'; 
	uC_commandType  <= '1'; 
	--wait until uCcommandinQueue = '1';
	wait for 31us;
	uC_commandReady <= '0'; 
	wait;
   end process;
 
   -- Stimulus process
   
	ZB_signal_control : process
	begin
		wait until rising_edge( commandReady2ZB) or MomState = "001";
		wait for 6 us;
		ZB_active <= '1';
		if commandType2ZB = '1' then
			if commandReady2ZB = '1' then
				wait for 300 ns;
				-- uc_ACK <= '1';
				wait for 300 ns;
				-- uc_ACK <= '0';
				wait for 10 ms;
				ZB_active <= '0';
			
			elsif commandReady2ZB = '0' then
				wait for 300 ns;
				-- uc_ACK <= '1';
				wait for 300 ns;
				-- uc_ACK <= '0';
				wait for 3 ms;
				ZB_active <= '0';
			end if;
			
		elsif MomState = "100" then
			wait for 300 ns;
				-- uc_ACK <= '1';
				wait for 300 ns;
				-- uc_ACK <= '0';
				wait for 10 ms;
				ZB_active <= '0';
		else
			wait for 1 ms;
			ZB_active <= '0';
		end if;
	end process;

   stim_proc: process
   begin		
      -- hold reset state for 100ms.
	rst <= '0';
	wait for clk_period*3.2;	
	rst <= '1';
	wait for clk_period*11.3;
	
	wait for 10us;
	RX_commandReady <= '1';
	RX_commandType <= R2SINK; -- he recibido por la radio un NWKRroute
	RX_addressOK <= '1';
	wait for 65ns;
	
	--wait until clk'event;
	wait until MoMState = "010";
	wait for 1 ms;
	wait until rising_edge(clk);
	TX_messageEnd <= '1';
	wait until rising_edge(clk);
	TX_messageEnd <= '0';
	RX_commandReady <= '0';
	RX_addressOK <= '0';
	
	wait until MoMState = "111";
	wait for 20*clk_period;
	
	microCommand <= '0';
	wait for clk_period;
	
	if microCommand = '1' then
		wait until MoMState = "010";
		wait for 1 ms;
		wait until rising_edge(clk);
		TX_messageEnd <= '1';
		wait for clk_period;
		TX_messageEnd <= '0';
		microCommand <= '0';
	end if;
	
	wait for 768 us;
	RX_commandReady <= '1';
	RX_commandType <= R2SINK;
	RX_addressOK <= '0';	-- he recibido por la radio un NWKRroute

	if (MoMState = "101") then
		wait until (MoMState = "111");
		wait for clk_period;
		RX_commandReady <= '0';
	
	elsif (MoMState = "111") then
		wait until MoMState = "010";
		wait for 1 ms;
		wait until rising_edge(clk);
		TX_messageEnd <= '1';
		wait for clk_period;
		TX_messageEnd <= '0';
	else
		wait for clk_period;
		RX_commandReady <= '0';
	end if;

    wait;
   end process;

END;
