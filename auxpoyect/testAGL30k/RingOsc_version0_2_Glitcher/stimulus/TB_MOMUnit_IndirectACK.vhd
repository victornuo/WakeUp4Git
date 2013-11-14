----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Mar 26 10:42:47 2013
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: TB_MOMUnit_IndirectACK.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO> <Die::AGL250V5> <Package::100 VQFP>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

use work.wupu_pck.all;

entity TB_MOMUnit_IndirectACK is
end TB_MOMUnit_IndirectACK;

architecture behavioral of TB_MOMUnit_IndirectACK is

    constant SYSCLK_PERIOD : time := 90.42 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
	
	signal newRX: std_logic := '0';
	
	signal        RX_port :   std_logic := '0';
    signal        RX_active :   std_logic := '0';
    signal        RX_commandType :   std_logic_vector(1 downto 0):= "00";
    signal        RX_commandReady :   std_logic:= '0';
    signal        RX_addressOK :   std_logic := '0';
    signal        uC_commandType :   std_logic := '0';
    signal        uC_commandReady :   std_logic := '0';
    signal        ZB_active :   std_logic := '0';
    signal        TX_Active :   std_logic := '0';
    signal        nextHopAddress :   std_logic_vector(7 downto 0) := "00001111";
    signal        clk :   std_logic := '0';
    signal        rst :   std_logic := '0';

            -- Outputs
    signal        commandType2ZB :   std_logic := '0';
    signal        commandReady2ZB :   std_logic := '0';
    signal        commandToEncoder :   std_logic_vector(1 downto 0) := "00";
    signal        Enable_encoder :   std_logic := '0';
    signal        RF_selector :   std_logic := '0';
    signal        TX_load :   std_logic := '0';
    signal        RX_processed :   std_logic := '0';
    signal        MoMState :   std_logic_vector(2 downto 0) := "000";
    signal        d_hk :   std_logic := '0'; 

    component MoM_unit
        -- ports
        port( 
            -- Inputs
            RX_port : in std_logic;
            RX_active : in std_logic;
            RX_commandType : in std_logic_vector(1 downto 0);
            RX_commandReady : in std_logic;
            RX_addressOK : in std_logic;
            uC_commandType : in std_logic;
            uC_commandReady : in std_logic;
            ZB_active : in std_logic;
            TX_Active : in std_logic;
            nextHopAddress : in std_logic_vector(7 downto 0);
            clk : in std_logic;
            rst : in std_logic;

            -- Outputs
            commandType2ZB : out std_logic;
            commandReady2ZB : out std_logic;
            commandToEncoder : out std_logic_vector(1 downto 0);
            Enable_encoder : out std_logic;
            RF_selector : out std_logic;
            TX_load : out std_logic;
            RX_processed : out std_logic;
            MoMState : out std_logic_vector(2 downto 0);
            d_hk : out std_logic

            -- Inouts

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
			
			wait for ( SYSCLK_PERIOD * 2 );
			uc_commandReady <= '1';
			
			wait until (MoMState = "010");
			uc_commandReady <= '0';
			TX_Active <= '0';
			
			wait for 6 ms;
			
			newRX <= '1';
			RX_commandType <= NWKrRoute;
			RX_addressOK <= '0';
			
			wait until MomState = "111" or commandReady2ZB = '1';
			newRX <= '0';
			wait for ( SYSCLK_PERIOD);
			
			newRX <= '1';
			RX_commandType <= NWKrRoute;
			--RX_addressOK <= '1';
			
			
			wait for (SYSCLK_PERIOD);
			
			ZB_active <= '1';
			
			wait for 532 us;
			
			ZB_active <= '0';
			
			
            wait;
        end if;
    end process;
	
	process
	begin
		wait until newRX = '1';  
		RX_commandReady <= '1';
		
		wait until RX_processed = '1';
		RX_commandReady <= '0';
		
		
	end process;

    -- 10MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  MoM_unit
    MoM_unit_0 : MoM_unit
        -- port map
        port map( 
            -- Inputs
            RX_port => RX_port,
            RX_active => RX_active,
            RX_commandType => RX_commandType,
            RX_commandReady => RX_commandReady,
            RX_addressOK => RX_addressOK,
            uC_commandType => uC_commandType,
            uC_commandReady => uC_commandReady,
            ZB_active => ZB_active,
            TX_Active => TX_Active,
            nextHopAddress => nextHopAddress,
            clk => SYSCLK,
            rst => NSYSRESET,

            -- Outputs
            commandType2ZB =>  open,
            commandReady2ZB =>  commandReady2ZB,
            commandToEncoder => open,
            Enable_encoder =>  open,
            RF_selector =>  open,
            TX_load =>  open,
            RX_processed =>  RX_processed,
            MoMState => MoMState,
            d_hk =>  open

            -- Inouts

        );

end behavioral;

