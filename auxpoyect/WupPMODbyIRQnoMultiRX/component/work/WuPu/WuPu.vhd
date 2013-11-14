----------------------------------------------------------------------
-- Created by SmartDesign Fri Apr 12 15:19:01 2013
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
-- WuPu entity declaration
----------------------------------------------------------------------
entity WuPu is
    -- Port list
    port(
        -- Inputs
        NWKrRouteTimeout : in  std_logic;
        R2SINKTimeout    : in  std_logic;
        RST              : in  std_logic;
        RX               : in  std_logic;
        Sel_address      : in  std_logic_vector(1 downto 0);
        Wakeup           : in  std_logic;
        clk              : in  std_logic;
        uC_commandReady  : in  std_logic;
        uC_commandType   : in  std_logic;
        -- Outputs
        AddOKflag        : out std_logic;
        CommandReady2uC  : out std_logic;
        CommandType2uC   : out std_logic;
        IRQ0             : out std_logic;
        IRQ1             : out std_logic;
        IRQ2             : out std_logic;
        IRQ3             : out std_logic;
        MoMstateLed      : out std_logic_vector(2 downto 0);
        RESETZB          : out std_logic;
        RFSwitch         : out std_logic;
        RX_OUT           : out std_logic;
        Status_flag      : out std_logic;
        TX               : out std_logic;
        TXMODE           : out std_logic;
        bit_error        : out std_logic
        );
end WuPu;
----------------------------------------------------------------------
-- WuPu architecture body
----------------------------------------------------------------------
architecture RTL of WuPu is
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
-- housekeepingCheck
component housekeepingCheck
    -- Port list
    port(
        -- Inputs
        Data1  : in  std_logic;
        Data2  : in  std_logic;
        Data3  : in  std_logic;
        Data4  : in  std_logic;
        Data5  : in  std_logic;
        -- Outputs
        Result : out std_logic
        );
end component;
-- INBUF
component INBUF
    -- Port list
    port(
        -- Inputs
        PAD : in  std_logic;
        -- Outputs
        Y   : out std_logic
        );
end component;
-- LowPowerManagement
component LowPowerManagement
    -- Port list
    port(
        -- Inputs
        CLK               : in  std_logic;
        Done_Housekeeping : in  std_logic;
        Flash_Freeze_N    : in  std_logic;
        RST_N             : in  std_logic;
        -- Outputs
        CLK_GATED         : out std_logic;
        SleepActive       : out std_logic;
        Wait_Housekeeping : out std_logic
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
-- ZBWatchDog
component ZBWatchDog
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(26 downto 0);
        Tcnt   : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AddOKflag_0                           : std_logic;
signal addressingData_0_NextHopAddress_0     : std_logic_vector(7 downto 0);
signal addressingData_0_NodeAddress_0        : std_logic_vector(7 downto 0);
signal bit_error_net_0                       : std_logic;
signal command_process_0_Busy                : std_logic;
signal command_process_0_msgType_0           : std_logic_vector(1 downto 0);
signal command_process_0_newMsg              : std_logic;
signal CommandReady2uC_net_0                 : std_logic;
signal CommandType2uC_net_0                  : std_logic;
signal d_hk                                  : std_logic;
signal d_hk_3                                : std_logic;
signal housekeepingCheck_0_Result            : std_logic;
signal IRQ0_net_0                            : std_logic;
signal IRQ1_net_0                            : std_logic;
signal IRQ2_net_0                            : std_logic;
signal IRQ3_net_0                            : std_logic;
signal LowPowerManagement_0_CLK_GATED        : std_logic;
signal manchesterEncoderComplete_0_d_hk      : std_logic;
signal manchesterEncoderComplete_0_TX_Active : std_logic;
signal md_v4_0_dout                          : std_logic;
signal md_v4_0_new_data                      : std_logic;
signal MoM_unit_0_commandToEncoder           : std_logic_vector(1 downto 0);
signal MoM_unit_0_Enable_encoder             : std_logic;
signal MoM_unit_0_RX_processed               : std_logic;
signal MoM_unit_0_TX_load                    : std_logic;
signal RESETZB_net_0                         : std_logic;
signal RFSwitch_net_0                        : std_logic;
signal Status_flag_net_0                     : std_logic;
signal statusLed                             : std_logic_vector(2 downto 0);
signal TX_net_0                              : std_logic;
signal Wait_Housekeeping                     : std_logic;
signal ZBControl_0_d_hk                      : std_logic;
signal ZBControl_0_WD_CLR                    : std_logic;
signal ZBControl_0_ZB_active                 : std_logic;
signal ZBWatchDog_0_Tcnt                     : std_logic;
signal TX_net_1                              : std_logic;
signal CommandType2uC_net_1                  : std_logic;
signal CommandReady2uC_net_1                 : std_logic;
signal RESETZB_net_1                         : std_logic;
signal RFSwitch_net_2                        : std_logic;
signal RX_0_net_0                            : std_logic;
signal AddOKflag_0_net_0                     : std_logic;
signal bit_error_net_1                       : std_logic;
signal IRQ1_net_1                            : std_logic;
signal IRQ0_net_1                            : std_logic;
signal IRQ2_net_1                            : std_logic;
signal IRQ3_net_1                            : std_logic;
signal Status_flag_net_1                     : std_logic;
signal statusLed_net_0                       : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal RFSwitch_net_1                        : std_logic;
signal RFSwitch_OUT_PRE_INV0_0               : std_logic;

begin
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 RFSwitch_net_1 <= NOT RFSwitch_OUT_PRE_INV0_0;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 TX_net_1                <= TX_net_0;
 TX                      <= TX_net_1;
 CommandType2uC_net_1    <= CommandType2uC_net_0;
 CommandType2uC          <= CommandType2uC_net_1;
 CommandReady2uC_net_1   <= CommandReady2uC_net_0;
 CommandReady2uC         <= CommandReady2uC_net_1;
 RFSwitch_OUT_PRE_INV0_0 <= RFSwitch_net_0;
 RFSwitch                <= RFSwitch_net_1;
 RESETZB_net_1           <= RESETZB_net_0;
 RESETZB                 <= RESETZB_net_1;
 RFSwitch_net_2          <= RFSwitch_net_0;
 TXMODE                  <= RFSwitch_net_2;
 RX_0_net_0              <= RX;
 RX_OUT                  <= RX_0_net_0;
 AddOKflag_0_net_0       <= AddOKflag_0;
 AddOKflag               <= AddOKflag_0_net_0;
 bit_error_net_1         <= bit_error_net_0;
 bit_error               <= bit_error_net_1;
 IRQ1_net_1              <= IRQ1_net_0;
 IRQ1                    <= IRQ1_net_1;
 IRQ0_net_1              <= IRQ0_net_0;
 IRQ0                    <= IRQ0_net_1;
 IRQ2_net_1              <= IRQ2_net_0;
 IRQ2                    <= IRQ2_net_1;
 IRQ3_net_1              <= IRQ3_net_0;
 IRQ3                    <= IRQ3_net_1;
 Status_flag_net_1       <= Status_flag_net_0;
 Status_flag             <= Status_flag_net_1;
 statusLed_net_0         <= statusLed;
 MoMstateLed(2 downto 0) <= statusLed_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- addressingData_0
addressingData_0 : addressingData
    port map( 
        -- Inputs
        clk            => LowPowerManagement_0_CLK_GATED,
        rst            => RESETZB_net_0,
        sel            => Sel_address,
        -- Outputs
        addressload    => OPEN,
        NodeAddress    => addressingData_0_NodeAddress_0,
        NextHopAddress => addressingData_0_NextHopAddress_0 
        );
-- command_process_0
command_process_0 : command_process
    port map( 
        -- Inputs
        din         => md_v4_0_dout,
        newData     => md_v4_0_new_data,
        dataClean   => MoM_unit_0_RX_processed,
        bitError    => bit_error_net_0,
        clk         => LowPowerManagement_0_CLK_GATED,
        rst         => RESETZB_net_0,
        nodeAddress => addressingData_0_NodeAddress_0,
        -- Outputs
        newMsg      => command_process_0_newMsg,
        Busy        => command_process_0_Busy,
        AddOKflag   => AddOKflag_0,
        d_hk        => d_hk,
        msgType     => command_process_0_msgType_0 
        );
-- housekeepingCheck_0
housekeepingCheck_0 : housekeepingCheck
    port map( 
        -- Inputs
        Data1  => d_hk,
        Data2  => Wait_Housekeeping,
        Data3  => manchesterEncoderComplete_0_d_hk,
        Data4  => d_hk_3,
        Data5  => ZBControl_0_d_hk,
        -- Outputs
        Result => housekeepingCheck_0_Result 
        );
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RST,
        -- Outputs
        Y   => RESETZB_net_0 
        );
-- LowPowerManagement_0
LowPowerManagement_0 : LowPowerManagement
    port map( 
        -- Inputs
        Flash_Freeze_N    => Wakeup,
        RST_N             => RESETZB_net_0,
        CLK               => clk,
        Done_Housekeeping => housekeepingCheck_0_Result,
        -- Outputs
        CLK_GATED         => LowPowerManagement_0_CLK_GATED,
        Wait_Housekeeping => Wait_Housekeeping,
        SleepActive       => Status_flag_net_0 
        );
-- manchesterEncoderComplete_0
manchesterEncoderComplete_0 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => MoM_unit_0_TX_load,
        start          => MoM_unit_0_Enable_encoder,
        clk            => LowPowerManagement_0_CLK_GATED,
        rstn           => RESETZB_net_0,
        din            => MoM_unit_0_commandToEncoder,
        nextHopAddress => addressingData_0_NextHopAddress_0,
        -- Outputs
        dout           => TX_net_0,
        d_hk           => manchesterEncoderComplete_0_d_hk,
        TX_Active      => manchesterEncoderComplete_0_TX_Active 
        );
-- md_v4_0
md_v4_0 : md_v4
    port map( 
        -- Inputs
        mdi           => RX,
        dataProccesed => MoM_unit_0_RX_processed,
        rst           => RESETZB_net_0,
        clk           => LowPowerManagement_0_CLK_GATED,
        -- Outputs
        bit_error     => bit_error_net_0,
        dout          => md_v4_0_dout,
        new_data      => md_v4_0_new_data 
        );
-- MoM_unit_0
MoM_unit_0 : MoM_unit
    port map( 
        -- Inputs
        RX_port          => RX,
        RX_active        => command_process_0_Busy,
        RX_commandReady  => command_process_0_newMsg,
        RX_addressOK     => AddOKflag_0,
        uC_commandType   => uC_commandType,
        uC_commandReady  => uC_commandReady,
        ZB_active        => ZBControl_0_ZB_active,
        TX_Active        => manchesterEncoderComplete_0_TX_Active,
        clk              => LowPowerManagement_0_CLK_GATED,
        rst              => RESETZB_net_0,
        RX_commandType   => command_process_0_msgType_0,
        nextHopAddress   => addressingData_0_NextHopAddress_0,
        -- Outputs
        commandType2ZB   => CommandType2uC_net_0,
        commandReady2ZB  => CommandReady2uC_net_0,
        Enable_encoder   => MoM_unit_0_Enable_encoder,
        RF_selector      => RFSwitch_net_0,
        TX_load          => MoM_unit_0_TX_load,
        RX_processed     => MoM_unit_0_RX_processed,
        d_hk             => d_hk_3,
        commandToEncoder => MoM_unit_0_commandToEncoder,
        MoMState         => statusLed 
        );
-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => CommandType2uC_net_0,
        commandReady2uC  => CommandReady2uC_net_0,
        WD_IRQ           => ZBWatchDog_0_Tcnt,
        R2SINKTimeout    => R2SINKTimeout,
        NWKrRouteTimeout => NWKrRouteTimeout,
        clk              => LowPowerManagement_0_CLK_GATED,
        rst              => RESETZB_net_0,
        -- Outputs
        ZB_active        => ZBControl_0_ZB_active,
        IRQ0             => IRQ0_net_0,
        IRQ1             => IRQ1_net_0,
        IRQ2             => IRQ2_net_0,
        IRQ3             => IRQ3_net_0,
        WD_CLR           => ZBControl_0_WD_CLR,
        d_hk             => ZBControl_0_d_hk 
        );
-- ZBWatchDog_0
ZBWatchDog_0 : ZBWatchDog
    port map( 
        -- Inputs
        Aclr   => ZBControl_0_WD_CLR,
        Clock  => LowPowerManagement_0_CLK_GATED,
        Enable => IRQ3_net_0,
        -- Outputs
        Tcnt   => ZBWatchDog_0_Tcnt,
        Q      => OPEN 
        );

end RTL;
