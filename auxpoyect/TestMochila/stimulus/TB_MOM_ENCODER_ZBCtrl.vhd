----------------------------------------------------------------------
-- Created by SmartDesign Thu Apr 04 17:10:08 2013
-- Version: 10.1 SP3 10.1.3.1
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use work.wupu_pck.all;


library igloo;
use igloo.all;
----------------------------------------------------------------------
-- TB_MOM_ENCODER_ZBCtrl entity declaration
----------------------------------------------------------------------
entity TB_MOM_ENCODER_ZBCtrl is
    -- Port list
end TB_MOM_ENCODER_ZBCtrl;
----------------------------------------------------------------------
-- TB_MOM_ENCODER_ZBCtrl architecture body
----------------------------------------------------------------------
architecture RTL_TB of TB_MOM_ENCODER_ZBCtrl is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CLK_GEN   -   Actel:Simulation:CLK_GEN:1.0.1

-- manchesterEncoderComplete
component manchesterEncoderComplete
    -- Port list
    port(
        -- Inputs
        clk            : in  std_logic;
        din            : in  std_logic_vector(1 downto 0);
        load_din       : in  std_logic;
        nextHopAddress : in  std_logic_vector(7 downto 0);
        rstn           : in  std_logic;
        start          : in  std_logic;
        -- Outputs
        TX_Active      : out std_logic;
        d_hk           : out std_logic;
        dout           : out std_logic
        );
end component;
-- MoM_unit
component MoM_unit
    -- Port list
    port(
        -- Inputs
        RX_active        : in  std_logic;
        RX_addressOK     : in  std_logic;
        RX_commandReady  : in  std_logic;
        RX_commandType   : in  std_logic_vector(1 downto 0);
        RX_port          : in  std_logic;
        TX_Active        : in  std_logic;
        ZB_active        : in  std_logic;
        clk              : in  std_logic;
        nextHopAddress   : in  std_logic_vector(7 downto 0);
        rst              : in  std_logic;
        uC_commandReady  : in  std_logic;
        uC_commandType   : in  std_logic;
        -- Outputs
        Enable_encoder   : out std_logic;
        MoMState         : out std_logic_vector(2 downto 0);
        RF_selector      : out std_logic;
        RX_processed     : out std_logic;
        TX_load          : out std_logic;
        commandReady2ZB  : out std_logic;
        commandToEncoder : out std_logic_vector(1 downto 0);
        commandType2ZB   : out std_logic;
        d_hk             : out std_logic
        );
end component;
-- RESET_GEN   -   Actel:Simulation:RESET_GEN:1.0.1

-- ZBControl
component ZBControl
    -- Port list
    port(
        -- Inputs
        NWKrRouteTimeout : in  std_logic;
        R2SINKTimeout    : in  std_logic;
        WD_IRQ           : in  std_logic;
        clk              : in  std_logic;
        commandReady2uC  : in  std_logic;
        commandType2uC   : in  std_logic;
        rst              : in  std_logic;
        -- Outputs
        IRQ0             : out std_logic;
        IRQ1             : out std_logic;
        IRQ2             : out std_logic;
        IRQ3             : out std_logic;
        WD_CLR           : out std_logic;
        ZB_active        : out std_logic;
        d_hk             : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
 constant SYSCLK_PERIOD : time := 90.42 ns;

    signal SYSCLK                         : std_logic :='0';
    signal NSYSRESET : std_logic := '0';
    signal        newRX:   std_logic := '0';
	

signal        IRQ0 :   std_logic := '0';
signal        IRQ1 :   std_logic := '0';
signal        IRQ2 :   std_logic := '0';
signal        IRQ3 :   std_logic := '0';

signal        RX_port :   std_logic := '0';
signal        RX_active :   std_logic := '0';
signal        RX_commandType :   std_logic_vector(1 downto 0):= "00";
signal        RX_commandReady :   std_logic:= '0';
signal        RX_processed :   std_logic:= '0';
signal        RX_addressOK :   std_logic := '0';
signal        uC_commandType :   std_logic := '0';
signal        uC_commandReady :   std_logic := '0';
signal        nextHopAddress :   std_logic_vector(7 downto 0) := "00001111";
signal        RF_Selector:   std_logic := '0';
signal        clk :   std_logic := '0';
signal        rst :   std_logic := '0';

signal R2SINKTimeout 	:  std_logic := '0';	
signal NWKrRouteTimeout	:   std_logic := '0';

signal        MoMState :   std_logic_vector (2 downto 0) := "000";
	
signal CLK_GEN_0_CLK                         : std_logic;
signal manchesterEncoderComplete_0_TX_Active : std_logic;
signal MoM_unit_0_commandReady2ZB            : std_logic;
signal MoM_unit_0_commandToEncoder           : std_logic_vector(1 downto 0);
signal MoM_unit_0_commandType2ZB             : std_logic;
signal MoM_unit_0_Enable_encoder             : std_logic;
signal MoM_unit_0_TX_load                    : std_logic;
signal RESET_GEN_0_RESET                     : std_logic;
signal ZBControl_0_ZB_active                 : std_logic;
signal dout                           : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------;
-- dout;       
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

RESET_GEN_0_RESET <= NSYSRESET;
CLK_GEN_0_CLK <= SYSCLK;

    process
	
	variable inic : bit := '0';
	variable iter : integer range 0 to 4 := 0;

    begin
		
		if  (inic = '0' )  then
			NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
			
			wait for ( SYSCLK_PERIOD * 2 );
			
			NWKrRouteTimeout <= '1';
			R2SINKTimeout <= '1';
			
			wait for ( SYSCLK_PERIOD * 2 );
			
			NWKrRouteTimeout <= '0';
			R2SINKTimeout <= '0';
			inic := '1' ;
		
		end if;	
			
			case (iter) is
				when 0 =>  -- R2Sink desde el micro con indirect ACK tras un reenvio
					assert false report "uc-->(R2SINK)--> WuP" severity note;
					wait for ( SYSCLK_PERIOD * 10);
					uc_commandReady <= '1';
					wait until (MoMState = "010");
					uc_commandReady <= '0';
					--TX_Active <= '0';
					
					wait until MoM_unit_0_Enable_encoder= '1';
					wait until RF_selector= '0';
					wait for 1.3 ms;
					
					assert false report "WuR-->(R2SINK)--> WuP (indACK)" severity note;
					RX_commandReady <= '1';
					
					RX_commandType <= R2SINK;
					RX_addressOK <= '0';
					wait until RX_processed = '1';
					RX_commandReady <= '0';
					
					wait until ZBControl_0_ZB_active = '1';
				
					wait for ( 11.7 ms);
					NWKrRouteTimeout <= '1';
					
					wait for ( 2.7 ms);
					R2SINKTimeout <= '1';
					
					wait until (IRQ2='1');
					wait for (SYSCLK_PERIOD*4);
							
					R2SINKTimeout <= '0';	
					NWKrRouteTimeout <= '0';
					iter := iter + 1;
					
				
				when 1 =>  -- llega un NWKrROute
					assert false report "WuR-->(NWKrRoute)--> WuP" severity note;
					wait for ( SYSCLK_PERIOD * 10);
					RX_commandReady <= '1';
					RX_commandType <= NWKrRoute;
					RX_addressOK <= '0';
					wait until RX_processed = '1';
					RX_commandReady <= '0';
					wait until ZBControl_0_ZB_active = '1';
					wait for ( 11.7 ms);
					NWKrRouteTimeout <= '1';
					wait until (IRQ2='1');
					wait for (SYSCLK_PERIOD*4);
							
					R2SINKTimeout <= '0';	
					NWKrRouteTimeout <= '0';
					iter := iter + 1;
					
				when others => 
					wait;
					
			end case;
       
    end process;
	
	-- process
	-- begin
		-- wait until newRX = '1';  
		-- RX_commandReady <= '1';
		
		-- wait until RX_processed = '1';
		-- RX_commandReady <= '0';
		
		
	-- end process;

-- manchesterEncoderComplete_0
manchesterEncoderComplete_0 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => MoM_unit_0_TX_load,
        start          => MoM_unit_0_Enable_encoder,
        clk            => CLK_GEN_0_CLK,
        rstn           => RESET_GEN_0_RESET,
        din            => MoM_unit_0_commandToEncoder,
        nextHopAddress => nextHopAddress,
        -- Outputs
        dout           => dout,
        d_hk           => OPEN,
        TX_Active      => manchesterEncoderComplete_0_TX_Active 
        );
-- MoM_unit_0
MoM_unit_0 : MoM_unit
    port map( 
        -- Inputs
        RX_port          => RX_port,
        RX_active        => RX_active,
        RX_commandType   => RX_commandType,
        RX_commandReady  => RX_commandReady,
        RX_addressOK     => RX_addressOK,
        uC_commandType   => uC_commandType,
        uC_commandReady  => uC_commandReady,
        ZB_active        => ZBControl_0_ZB_active,
        TX_Active        => manchesterEncoderComplete_0_TX_Active,
        nextHopAddress   => nextHopAddress,
        clk              => CLK_GEN_0_CLK,
        rst              => RESET_GEN_0_RESET,
        -- Outputs
        commandType2ZB   => MoM_unit_0_commandType2ZB,
        commandReady2ZB  => MoM_unit_0_commandReady2ZB,
        commandToEncoder => MoM_unit_0_commandToEncoder,
        Enable_encoder   => MoM_unit_0_Enable_encoder,
        RF_selector      => RF_selector,
        TX_load          => MoM_unit_0_TX_load,
        RX_processed     => RX_processed,
        MoMState         => MoMState,
        d_hk             => OPEN 
        );

-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => MoM_unit_0_commandType2ZB,
        commandReady2uC  => MoM_unit_0_commandReady2ZB,
        WD_IRQ           => '0',
        R2SINKTimeout    => R2SINKTimeout,
        NWKrRouteTimeout => NWKrRouteTimeout,
        clk              => CLK_GEN_0_CLK,
        rst              => RESET_GEN_0_RESET,
        -- Outputs
        ZB_active        => ZBControl_0_ZB_active,
        IRQ0             => IRQ0,-- Señal q va a IRQ 0 a actival el modulo ZB
        IRQ1             => IRQ1,-- Señal q va a IRQ 1 a desactiva el modulo ZB
        IRQ2             => IRQ2,-- Señal q va a IRQ 2 a pone las señales R2SINKTimeout and R2SINKTimeout a '0'
        IRQ3             => IRQ3,-- Señal q va a IRQ 3 a StartTimers
        WD_CLR           => OPEN,
        d_hk             => OPEN 
        );

end RTL_TB;
