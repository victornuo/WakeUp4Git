----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Jun 26 17:35:21 2012
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TB_ZBHandler is
end TB_ZBHandler;

architecture behavioral of TB_ZBHandler is

    constant SYSCLK_PERIOD : time := 90.42 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
	
	
	signal ZBSleepsFake : std_logic := '0';
	signal activate_uC : std_logic := '0';
	signal commandType2uC : std_logic := '0';
	signal commandReady2uC : std_logic := '0';
	signal uCcommandinQueue : std_logic := '0';
	signal uc_ACK : std_logic := '0';
	signal ActivateZB : std_logic := '0';
	signal end_TX :  std_logic := '0';

    component ZBHandler
        -- ports
        port( 
            -- Inputs
            Clock : in std_logic;
            RX : in std_logic;
            rst : in std_logic;
            ZBSleepsFake : in std_logic;
            activate_uC : in std_logic;
            commandType2uC : in std_logic;
            commandReady2uC : in std_logic;
            uCcommandinQueue : in std_logic;

            -- Outputs
            d_hk : out std_logic;
            TX : out std_logic;
            uC_ACK : out std_logic;
            uC_active : out std_logic;
            ActivateZB : out std_logic;
			end_TX : out   std_logic

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
			
			wait for ( SYSCLK_PERIOD * 10 );
			
			activate_uC <= '1';
			commandType2uC <= '1';
			commandReady2uC <= '1'; -- NWKrRoute
			
			wait until uc_ACK = '1';
			wait for ( SYSCLK_PERIOD);
			commandReady2uC <= '0';
			activate_uC <= '0';
			
		
			
			wait until end_TX'event and end_TX = '1';
			
			ZBSleepsFake <= '1';
			
			wait for ( SYSCLK_PERIOD);
			
			ZBSleepsFake <= '0';
			
			
			wait for ( SYSCLK_PERIOD * 10 );
			
			activate_uC <= '1';
			commandType2uC <= '0';
			commandReady2uC <= '1'; -- NWKrRoute
			
			wait until uc_ACK = '1';
			wait for ( SYSCLK_PERIOD);
			
			commandReady2uC <= '0';
			activate_uC <= '0';
			
			--wait until ActivateZB = '1';
			
			wait until end_TX'event and end_TX = '1';
			
			ZBSleepsFake <= '1';
			
			wait for ( SYSCLK_PERIOD);
			
			ZBSleepsFake <= '0';
			
            wait;
        end if;
    end process;

    -- 10MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  ZBHandler
    ZBHandler_0 : ZBHandler
        -- port map
        port map( 
            -- Inputs
            Clock => SYSCLK,
            RX => '0',
            rst => NSYSRESET,
            ZBSleepsFake => ZBSleepsFake,
            activate_uC => activate_uC,
            commandType2uC => commandType2uC,
            commandReady2uC => commandReady2uC,
            uCcommandinQueue => uCcommandinQueue,

            -- Outputs
            d_hk =>  open,
            TX =>  open,
            uC_ACK =>  uc_ACK,
            uC_active =>  open,
            ActivateZB =>  ActivateZB,
			end_TX => end_TX

            -- Inouts

        );

end behavioral;

