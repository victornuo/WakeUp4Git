----------------------------------------------------------------------
-- Created by SmartDesign Fri Apr 12 15:13:36 2013
-- Version: 10.1 SP3 10.1.3.1
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library igloo;
use igloo.all;
----------------------------------------------------------------------
-- TB_MOM_ENCODER_ZBCtrl entity declaration
----------------------------------------------------------------------
entity TB_MOM_ENCODER_ZBCtrl is
    -- Port list
    port(
        -- Inputs
        NWKrRouteTimeout : in  std_logic;
        R2SINKTimeout    : in  std_logic;
        RX_active        : in  std_logic;
        RX_addressOK     : in  std_logic;
        RX_commandReady  : in  std_logic;
        RX_commandType   : in  std_logic_vector(1 downto 0);
        RX_port          : in  std_logic;
        WD_IRQ           : in  std_logic;
        nextHopAddress   : in  std_logic_vector(7 downto 0);
        uC_commandReady  : in  std_logic;
        uC_commandType   : in  std_logic;
        -- Outputs
        dout             : out std_logic
        );
end TB_MOM_ENCODER_ZBCtrl;
----------------------------------------------------------------------
-- TB_MOM_ENCODER_ZBCtrl architecture body
----------------------------------------------------------------------
architecture RTL of TB_MOM_ENCODER_ZBCtrl is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CLK_GEN   -   Actel:Simulation:CLK_GEN:1.0.1
component CLK_GEN
    generic( 
        CLK_PERIOD : integer := 90422 ;
        DUTY_CYCLE : integer := 50 
        );
    -- Port list
    port(
        -- Outputs
        CLK : out std_logic
        );
end component;
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
component RESET_GEN
    generic( 
        DELAY       : integer := 1000 ;
        LOGIC_LEVEL : integer := 0 
        );
    -- Port list
    port(
        -- Outputs
        RESET : out std_logic
        );
end component;
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
signal CLK_GEN_0_CLK                         : std_logic;
signal dout_net_0                            : std_logic;
signal manchesterEncoderComplete_0_TX_Active : std_logic;
signal MoM_unit_0_commandReady2ZB            : std_logic;
signal MoM_unit_0_commandToEncoder           : std_logic_vector(1 downto 0);
signal MoM_unit_0_commandType2ZB             : std_logic;
signal MoM_unit_0_Enable_encoder             : std_logic;
signal MoM_unit_0_TX_load                    : std_logic;
signal RESET_GEN_0_RESET                     : std_logic;
signal ZBControl_0_ZB_active                 : std_logic;
signal dout_net_1                            : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 dout_net_1 <= dout_net_0;
 dout       <= dout_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CLK_GEN_0   -   Actel:Simulation:CLK_GEN:1.0.1
CLK_GEN_0 : CLK_GEN
    generic map( 
        CLK_PERIOD => ( 90422 ),
        DUTY_CYCLE => ( 50 )
        )
    port map( 
        -- Outputs
        CLK => CLK_GEN_0_CLK 
        );
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
        dout           => dout_net_0,
        d_hk           => OPEN,
        TX_Active      => manchesterEncoderComplete_0_TX_Active 
        );
-- MoM_unit_0
MoM_unit_0 : MoM_unit
    port map( 
        -- Inputs
        RX_port          => RX_port,
        RX_active        => RX_active,
        RX_commandReady  => RX_commandReady,
        RX_addressOK     => RX_addressOK,
        uC_commandType   => uC_commandType,
        uC_commandReady  => uC_commandReady,
        ZB_active        => ZBControl_0_ZB_active,
        TX_Active        => manchesterEncoderComplete_0_TX_Active,
        clk              => CLK_GEN_0_CLK,
        rst              => RESET_GEN_0_RESET,
        RX_commandType   => RX_commandType,
        nextHopAddress   => nextHopAddress,
        -- Outputs
        commandType2ZB   => MoM_unit_0_commandType2ZB,
        commandReady2ZB  => MoM_unit_0_commandReady2ZB,
        Enable_encoder   => MoM_unit_0_Enable_encoder,
        RF_selector      => OPEN,
        TX_load          => MoM_unit_0_TX_load,
        RX_processed     => OPEN,
        d_hk             => OPEN,
        commandToEncoder => MoM_unit_0_commandToEncoder,
        MoMState         => OPEN 
        );
-- RESET_GEN_0   -   Actel:Simulation:RESET_GEN:1.0.1
RESET_GEN_0 : RESET_GEN
    generic map( 
        DELAY       => ( 1000 ),
        LOGIC_LEVEL => ( 0 )
        )
    port map( 
        -- Outputs
        RESET => RESET_GEN_0_RESET 
        );
-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => MoM_unit_0_commandType2ZB,
        commandReady2uC  => MoM_unit_0_commandReady2ZB,
        WD_IRQ           => WD_IRQ,
        R2SINKTimeout    => R2SINKTimeout,
        NWKrRouteTimeout => NWKrRouteTimeout,
        clk              => CLK_GEN_0_CLK,
        rst              => RESET_GEN_0_RESET,
        -- Outputs
        ZB_active        => ZBControl_0_ZB_active,
        IRQ0             => OPEN,
        IRQ1             => OPEN,
        IRQ2             => OPEN,
        IRQ3             => OPEN,
        WD_CLR           => OPEN,
        d_hk             => OPEN 
        );

end RTL;
