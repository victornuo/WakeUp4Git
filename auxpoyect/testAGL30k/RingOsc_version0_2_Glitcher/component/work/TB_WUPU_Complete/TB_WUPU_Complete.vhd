----------------------------------------------------------------------
-- Created by SmartDesign Mon Jun 03 14:39:30 2013
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
-- TB_WUPU_Complete entity declaration
----------------------------------------------------------------------
entity TB_WUPU_Complete is
end TB_WUPU_Complete;
----------------------------------------------------------------------
-- TB_WUPU_Complete architecture body
----------------------------------------------------------------------
architecture RTL of TB_WUPU_Complete is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- addressingData
component addressingData
    -- Port list
    port(
        -- Inputs
        clk            : in  std_logic;
        rst            : in  std_logic;
        sel            : in  std_logic_vector(1 downto 0);
        -- Outputs
        NextHopAddress : out std_logic_vector(7 downto 0);
        NodeAddress    : out std_logic_vector(7 downto 0);
        addressload    : out std_logic
        );
end component;
-- command_process
component command_process
    -- Port list
    port(
        -- Inputs
        bitError    : in  std_logic;
        clk         : in  std_logic;
        dataClean   : in  std_logic;
        din         : in  std_logic;
        newData     : in  std_logic;
        nodeAddress : in  std_logic_vector(7 downto 0);
        rst         : in  std_logic;
        -- Outputs
        AddOKflag   : out std_logic;
        Busy        : out std_logic;
        d_hk        : out std_logic;
        msgType     : out std_logic_vector(1 downto 0);
        newMsg      : out std_logic
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
-- md_v4
component md_v4
    -- Port list
    port(
        -- Inputs
        clk           : in  std_logic;
        dataProccesed : in  std_logic;
        mdi           : in  std_logic;
        rst           : in  std_logic;
        -- Outputs
        bit_error     : out std_logic;
        dout          : out std_logic;
        new_data      : out std_logic
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
        MoMState         : out std_logic_vector(2 downto 0);
        RF_selector      : out std_logic;
        RX_processed     : out std_logic;
        TX_load          : out std_logic;
        TX_start         : out std_logic;
        commandReady2ZB  : out std_logic;
        commandToEncoder : out std_logic_vector(1 downto 0);
        commandType2ZB   : out std_logic;
        d_hk             : out std_logic
        );
end component;
-- PULSE_GEN   -   Actel:Simulation:PULSE_GEN:1.0.1
component PULSE_GEN
    generic( 
        PULSE_START_TIME : integer := 100000 ;
        PULSE_TYPE       : integer := 0 ;
        PULSE_WIDTH      : integer := 91 
        );
    -- Port list
    port(
        -- Outputs
        PULSE : out std_logic
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
signal addressingData_0_NextHopAddress       : std_logic_vector(7 downto 0);
signal addressingData_0_NodeAddress          : std_logic_vector(7 downto 0);
signal command_process_0_AddOKflag           : std_logic;
signal command_process_0_Busy                : std_logic;
signal command_process_0_msgType             : std_logic_vector(1 downto 0);
signal command_process_0_newMsg              : std_logic;
signal manchesterEncoderComplete_0_dout      : std_logic;
signal manchesterEncoderComplete_1_TX_Active : std_logic;
signal md_v4_0_bit_error                     : std_logic;
signal md_v4_0_dout                          : std_logic;
signal md_v4_0_new_data                      : std_logic;
signal MoM_unit_0_commandReady2ZB            : std_logic;
signal MoM_unit_0_commandToEncoder           : std_logic_vector(1 downto 0);
signal MoM_unit_0_commandType2ZB             : std_logic;
signal MoM_unit_0_RX_processed               : std_logic;
signal MoM_unit_0_TX_load                    : std_logic;
signal MoM_unit_0_TX_start                   : std_logic;
signal PULSE_GEN_0_PULSE_0                   : std_logic;
signal PULSE_GEN_1_PULSE                     : std_logic;
signal PULSE_GEN_2_PULSE_1                   : std_logic;
signal PULSE_GEN_3_PULSE                     : std_logic;
signal ZBControl_0_ZB_active                 : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal sel_const_net_0                       : std_logic_vector(1 downto 0);
signal din_const_net_0                       : std_logic_vector(1 downto 0);
signal GND_net                               : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal PULSE_OUT_PRE_INV0_0                  : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 sel_const_net_0 <= B"00";
 din_const_net_0 <= B"00";
 GND_net         <= '0';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 PULSE_GEN_3_PULSE <= NOT PULSE_OUT_PRE_INV0_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- addressingData_0
addressingData_0 : addressingData
    port map( 
        -- Inputs
        clk            => PULSE_GEN_2_PULSE_1,
        rst            => PULSE_GEN_3_PULSE,
        sel            => sel_const_net_0,
        -- Outputs
        addressload    => OPEN,
        NodeAddress    => addressingData_0_NodeAddress,
        NextHopAddress => addressingData_0_NextHopAddress 
        );
-- command_process_0
command_process_0 : command_process
    port map( 
        -- Inputs
        din         => md_v4_0_dout,
        newData     => md_v4_0_new_data,
        dataClean   => MoM_unit_0_RX_processed,
        bitError    => md_v4_0_bit_error,
        clk         => PULSE_GEN_2_PULSE_1,
        rst         => PULSE_GEN_3_PULSE,
        nodeAddress => addressingData_0_NodeAddress,
        -- Outputs
        newMsg      => command_process_0_newMsg,
        Busy        => command_process_0_Busy,
        AddOKflag   => command_process_0_AddOKflag,
        d_hk        => OPEN,
        msgType     => command_process_0_msgType 
        );
-- manchesterEncoderComplete_0
manchesterEncoderComplete_0 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => PULSE_GEN_0_PULSE_0,
        start          => PULSE_GEN_1_PULSE,
        clk            => PULSE_GEN_2_PULSE_1,
        rstn           => PULSE_GEN_3_PULSE,
        din            => din_const_net_0,
        nextHopAddress => addressingData_0_NodeAddress,
        -- Outputs
        dout           => manchesterEncoderComplete_0_dout,
        d_hk           => OPEN,
        TX_Active      => OPEN 
        );
-- manchesterEncoderComplete_1
manchesterEncoderComplete_1 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => MoM_unit_0_TX_load,
        start          => MoM_unit_0_TX_start,
        clk            => PULSE_GEN_2_PULSE_1,
        rstn           => PULSE_GEN_3_PULSE,
        din            => MoM_unit_0_commandToEncoder,
        nextHopAddress => addressingData_0_NextHopAddress,
        -- Outputs
        dout           => OPEN,
        d_hk           => OPEN,
        TX_Active      => manchesterEncoderComplete_1_TX_Active 
        );
-- md_v4_0
md_v4_0 : md_v4
    port map( 
        -- Inputs
        mdi           => manchesterEncoderComplete_0_dout,
        dataProccesed => MoM_unit_0_RX_processed,
        rst           => PULSE_GEN_3_PULSE,
        clk           => PULSE_GEN_2_PULSE_1,
        -- Outputs
        bit_error     => md_v4_0_bit_error,
        dout          => md_v4_0_dout,
        new_data      => md_v4_0_new_data 
        );
-- MoM_unit_0
MoM_unit_0 : MoM_unit
    port map( 
        -- Inputs
        RX_port          => manchesterEncoderComplete_0_dout,
        RX_active        => command_process_0_Busy,
        RX_commandReady  => command_process_0_newMsg,
        RX_addressOK     => command_process_0_AddOKflag,
        uC_commandType   => GND_net,
        uC_commandReady  => GND_net,
        ZB_active        => ZBControl_0_ZB_active,
        TX_Active        => manchesterEncoderComplete_1_TX_Active,
        clk              => PULSE_GEN_2_PULSE_1,
        rst              => PULSE_GEN_3_PULSE,
        RX_commandType   => command_process_0_msgType,
        nextHopAddress   => addressingData_0_NextHopAddress,
        -- Outputs
        commandType2ZB   => MoM_unit_0_commandType2ZB,
        commandReady2ZB  => MoM_unit_0_commandReady2ZB,
        TX_start         => MoM_unit_0_TX_start,
        RF_selector      => OPEN,
        TX_load          => MoM_unit_0_TX_load,
        RX_processed     => MoM_unit_0_RX_processed,
        d_hk             => OPEN,
        commandToEncoder => MoM_unit_0_commandToEncoder,
        MoMState         => OPEN 
        );
-- PULSE_GEN_0   -   Actel:Simulation:PULSE_GEN:1.0.1
PULSE_GEN_0 : PULSE_GEN
    generic map( 
        PULSE_START_TIME => ( 100000 ),
        PULSE_TYPE       => ( 0 ),
        PULSE_WIDTH      => ( 91 )
        )
    port map( 
        -- Outputs
        PULSE => PULSE_GEN_0_PULSE_0 
        );
-- PULSE_GEN_1   -   Actel:Simulation:PULSE_GEN:1.0.1
PULSE_GEN_1 : PULSE_GEN
    generic map( 
        PULSE_START_TIME => ( 110000 ),
        PULSE_TYPE       => ( 0 ),
        PULSE_WIDTH      => ( 91 )
        )
    port map( 
        -- Outputs
        PULSE => PULSE_GEN_1_PULSE 
        );
-- PULSE_GEN_2   -   Actel:Simulation:PULSE_GEN:1.0.1
PULSE_GEN_2 : PULSE_GEN
    generic map( 
        PULSE_START_TIME => ( 46 ),
        PULSE_TYPE       => ( 1 ),
        PULSE_WIDTH      => ( 45 )
        )
    port map( 
        -- Outputs
        PULSE => PULSE_GEN_2_PULSE_1 
        );
-- PULSE_GEN_3   -   Actel:Simulation:PULSE_GEN:1.0.1
PULSE_GEN_3 : PULSE_GEN
    generic map( 
        PULSE_START_TIME => ( 0 ),
        PULSE_TYPE       => ( 0 ),
        PULSE_WIDTH      => ( 10000 )
        )
    port map( 
        -- Outputs
        PULSE => PULSE_OUT_PRE_INV0_0 
        );
-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => MoM_unit_0_commandType2ZB,
        commandReady2uC  => MoM_unit_0_commandReady2ZB,
        WD_IRQ           => PULSE_GEN_0_PULSE_0,
        R2SINKTimeout    => PULSE_GEN_0_PULSE_0,
        NWKrRouteTimeout => PULSE_GEN_0_PULSE_0,
        clk              => PULSE_GEN_2_PULSE_1,
        rst              => PULSE_GEN_3_PULSE,
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
