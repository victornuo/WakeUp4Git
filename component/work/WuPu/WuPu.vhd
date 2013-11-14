----------------------------------------------------------------------
-- Created by SmartDesign Fri Jul 26 12:49:01 2013
-- Version: v11.1 11.1.0.14
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
        NWKrRouteTimeout : in    std_logic;
        R2SINKTimeout    : in    std_logic;
        RST              : in    std_logic;
        RX               : in    std_logic;
        Sel_address      : in    std_logic_vector(1 downto 0);
        Wakeup           : in    std_logic;
        uC_commandReady  : in    std_logic;
        uC_commandType   : in    std_logic;
        -- Outputs
        AddOKflag        : out   std_logic;
        CLK_GATED        : out   std_logic;
        CTRL1_Enab       : out   std_logic;
        CommandReady2ZB  : out   std_logic;
        CommandType2ZB   : out   std_logic;
        Decoder_hk       : out   std_logic;
        IRQ0             : out   std_logic;
        IRQ1             : out   std_logic;
        IRQ2             : out   std_logic;
        IRQ3             : out   std_logic;
        MoMstateLed      : out   std_logic_vector(2 downto 0);
        RESETZB          : out   std_logic;
        RX_OUT           : out   std_logic;
        TX               : out   std_logic;
        bit_error        : out   std_logic;
        -- Inouts
        CTRL1            : inout std_logic
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
        rstn           : in  std_logic;
        sel            : in  std_logic_vector(1 downto 0);
        -- Outputs
        NextHopAddress : out std_logic_vector(7 downto 0);
        NodeAddress    : out std_logic_vector(7 downto 0);
        addressload    : out std_logic
        );
end component;
-- BIBUF
component BIBUF
    -- Port list
    port(
        -- Inputs
        D   : in    std_logic;
        E   : in    std_logic;
        -- Outputs
        Y   : out   std_logic;
        -- Inouts
        PAD : inout std_logic
        );
end component;
-- command_process
component command_process
    -- Port list
    port(
        -- Inputs
        bitError            : in  std_logic;
        clk                 : in  std_logic;
        dataClean           : in  std_logic;
        din                 : in  std_logic;
        newData             : in  std_logic;
        nodeAddress         : in  std_logic_vector(7 downto 0);
        rstn                : in  std_logic;
        -- Outputs
        AddOKflag           : out std_logic;
        Parity              : out std_logic;
        d_hk                : out std_logic;
        msgType             : out std_logic_vector(1 downto 0);
        newMsg              : out std_logic;
        set_newMessage_flag : out std_logic
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
        Data6  : in  std_logic;
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
-- md_v5
component md_v5
    -- Port list
    port(
        -- Inputs
        clk       : in  std_logic;
        mdi       : in  std_logic;
        rstn      : in  std_logic;
        -- Outputs
        RX_end    : out std_logic;
        bit_error : out std_logic;
        d_hk      : out std_logic;
        dout      : out std_logic;
        new_data  : out std_logic
        );
end component;
-- MoM_unit
component MoM_unit
    -- Port list
    port(
        -- Inputs
        RX_addressOK     : in  std_logic;
        RX_commandReady  : in  std_logic;
        RX_commandType   : in  std_logic_vector(1 downto 0);
        RX_end           : in  std_logic;
        RX_port          : in  std_logic;
        TX_Active        : in  std_logic;
        ZB_active        : in  std_logic;
        clk              : in  std_logic;
        nextHopAddress   : in  std_logic_vector(7 downto 0);
        rstn             : in  std_logic;
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
-- RingOscillator
component RingOscillator
    -- Port list
    port(
        -- Inputs
        RESET_N : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
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
        rstn             : in  std_logic;
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
signal AddOKflag_0                           : std_logic;
signal AddOKflag_1                           : std_logic;
signal addressingData_0_NextHopAddress_0     : std_logic_vector(7 downto 0);
signal addressingData_0_NodeAddress_0        : std_logic_vector(7 downto 0);
signal bit_error_0                           : std_logic;
signal bit_error_1                           : std_logic;
signal bit_error_2                           : std_logic;
signal CLK_GATED_net_0                       : std_logic;
signal command_process_0_msgType_0           : std_logic_vector(1 downto 0);
signal commandP_hk                           : std_logic;
signal commandP_hk_1                         : std_logic;
signal CommandReady2ZB_net_0                 : std_logic;
signal CommandType2ZB_net_0                  : std_logic;
signal CTRL1_Enab_net_0                      : std_logic;
signal Decoder_hk_net_0                      : std_logic;
signal Decoder_hk_0                          : std_logic;
signal Decoder_hk_2                          : std_logic;
signal Encoder_hk                            : std_logic;
signal housekeepingCheck_0_Result            : std_logic;
signal IRQ0_net_0                            : std_logic;
signal IRQ1_net_0                            : std_logic;
signal IRQ2_net_0                            : std_logic;
signal IRQ3_net_0                            : std_logic;
signal LowpoerM_hk                           : std_logic;
signal manchesterEncoderComplete_0_TX_Active : std_logic;
signal md_v4_0_RX_end                        : std_logic;
signal MoM_hk                                : std_logic;
signal MoM_unit_0_commandToEncoder           : std_logic_vector(1 downto 0);
signal MoM_unit_0_RX_processed               : std_logic;
signal MoM_unit_0_TX_load                    : std_logic;
signal MoM_unit_0_TX_start                   : std_logic;
signal RESETZB_1                             : std_logic;
signal RingOscillator_0_CLK_OUT              : std_logic;
signal statusLed                             : std_logic_vector(2 downto 0);
signal TX_net_0                              : std_logic;
signal ZBControl_0_WD_CLR                    : std_logic;
signal TX_net_1                              : std_logic;
signal CommandType2ZB_net_1                  : std_logic;
signal CommandReady2ZB_net_1                 : std_logic;
signal RESETZB_1_net_0                       : std_logic;
signal RX_0_net_0                            : std_logic;
signal AddOKflag_1_net_0                     : std_logic;
signal bit_error_2_net_0                     : std_logic;
signal IRQ1_net_1                            : std_logic;
signal IRQ0_net_1                            : std_logic;
signal IRQ2_net_1                            : std_logic;
signal IRQ3_net_1                            : std_logic;
signal CLK_GATED_net_1                       : std_logic;
signal Decoder_hk_2_net_0                    : std_logic;
signal CTRL1_Enab_net_1                      : std_logic;
signal statusLed_net_0                       : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                               : std_logic;
signal VCC_net                               : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 TX_net_1                <= TX_net_0;
 TX                      <= TX_net_1;
 CommandType2ZB_net_1    <= CommandType2ZB_net_0;
 CommandType2ZB          <= CommandType2ZB_net_1;
 CommandReady2ZB_net_1   <= CommandReady2ZB_net_0;
 CommandReady2ZB         <= CommandReady2ZB_net_1;
 RESETZB_1_net_0         <= RESETZB_1;
 RESETZB                 <= RESETZB_1_net_0;
 RX_0_net_0              <= RX;
 RX_OUT                  <= RX_0_net_0;
 AddOKflag_1_net_0       <= AddOKflag_1;
 AddOKflag               <= AddOKflag_1_net_0;
 bit_error_2_net_0       <= bit_error_2;
 bit_error               <= bit_error_2_net_0;
 IRQ1_net_1              <= IRQ1_net_0;
 IRQ1                    <= IRQ1_net_1;
 IRQ0_net_1              <= IRQ0_net_0;
 IRQ0                    <= IRQ0_net_1;
 IRQ2_net_1              <= IRQ2_net_0;
 IRQ2                    <= IRQ2_net_1;
 IRQ3_net_1              <= IRQ3_net_0;
 IRQ3                    <= IRQ3_net_1;
 CLK_GATED_net_1         <= CLK_GATED_net_0;
 CLK_GATED               <= CLK_GATED_net_1;
 Decoder_hk_2_net_0      <= Decoder_hk_2;
 Decoder_hk              <= Decoder_hk_2_net_0;
 CTRL1_Enab_net_1        <= CTRL1_Enab_net_0;
 CTRL1_Enab              <= CTRL1_Enab_net_1;
 statusLed_net_0         <= statusLed;
 MoMstateLed(2 downto 0) <= statusLed_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- addressingData_0
addressingData_0 : addressingData
    port map( 
        -- Inputs
        clk            => CLK_GATED_net_0,
        rstn           => RESETZB_1,
        sel            => Sel_address,
        -- Outputs
        addressload    => OPEN,
        NodeAddress    => addressingData_0_NodeAddress_0,
        NextHopAddress => addressingData_0_NextHopAddress_0 
        );
-- BIBUF_0
BIBUF_0 : BIBUF
    port map( 
        -- Inputs
        D   => GND_net,
        E   => CTRL1_Enab_net_0,
        -- Outputs
        Y   => OPEN,
        -- Inouts
        PAD => CTRL1 
        );
-- command_process_0
command_process_0 : command_process
    port map( 
        -- Inputs
        din                 => AddOKflag_1,
        newData             => bit_error_2,
        dataClean           => MoM_unit_0_RX_processed,
        bitError            => bit_error_1,
        clk                 => CLK_GATED_net_0,
        rstn                => RESETZB_1,
        nodeAddress         => addressingData_0_NodeAddress_0,
        -- Outputs
        newMsg              => Decoder_hk_0,
        set_newMessage_flag => commandP_hk_1,
        AddOKflag           => AddOKflag_0,
        Parity              => Decoder_hk_2,
        d_hk                => commandP_hk,
        msgType             => command_process_0_msgType_0 
        );
-- housekeepingCheck_0
housekeepingCheck_0 : housekeepingCheck
    port map( 
        -- Inputs
        Data1  => commandP_hk,
        Data2  => LowpoerM_hk,
        Data3  => Encoder_hk,
        Data4  => MoM_hk,
        Data5  => Decoder_hk_net_0,
        Data6  => VCC_net,
        -- Outputs
        Result => housekeepingCheck_0_Result 
        );
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RST,
        -- Outputs
        Y   => RESETZB_1 
        );
-- LowPowerManagement_0
LowPowerManagement_0 : LowPowerManagement
    port map( 
        -- Inputs
        Flash_Freeze_N    => Wakeup,
        RST_N             => RESETZB_1,
        CLK               => RingOscillator_0_CLK_OUT,
        Done_Housekeeping => housekeepingCheck_0_Result,
        -- Outputs
        CLK_GATED         => CLK_GATED_net_0,
        Wait_Housekeeping => LowpoerM_hk,
        SleepActive       => OPEN 
        );
-- manchesterEncoderComplete_0
manchesterEncoderComplete_0 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => MoM_unit_0_TX_load,
        start          => MoM_unit_0_TX_start,
        clk            => CLK_GATED_net_0,
        rstn           => RESETZB_1,
        din            => MoM_unit_0_commandToEncoder,
        nextHopAddress => addressingData_0_NextHopAddress_0,
        -- Outputs
        dout           => TX_net_0,
        d_hk           => Encoder_hk,
        TX_Active      => manchesterEncoderComplete_0_TX_Active 
        );
-- md_v4_0
md_v4_0 : md_v5
    port map( 
        -- Inputs
        mdi       => RX,
        rstn      => RESETZB_1,
        clk       => CLK_GATED_net_0,
        -- Outputs
        bit_error => bit_error_1,
        RX_end    => md_v4_0_RX_end,
        dout      => AddOKflag_1,
        new_data  => bit_error_2,
        d_hk      => Decoder_hk_net_0 
        );
-- MoM_unit_0
MoM_unit_0 : MoM_unit
    port map( 
        -- Inputs
        RX_port          => RX,
        RX_end           => md_v4_0_RX_end,
        RX_commandReady  => Decoder_hk_0,
        RX_addressOK     => AddOKflag_0,
        uC_commandType   => uC_commandType,
        uC_commandReady  => uC_commandReady,
        ZB_active        => bit_error_0,
        TX_Active        => manchesterEncoderComplete_0_TX_Active,
        clk              => CLK_GATED_net_0,
        rstn             => RESETZB_1,
        RX_commandType   => command_process_0_msgType_0,
        nextHopAddress   => addressingData_0_NextHopAddress_0,
        -- Outputs
        commandType2ZB   => CommandType2ZB_net_0,
        commandReady2ZB  => CommandReady2ZB_net_0,
        TX_start         => MoM_unit_0_TX_start,
        RF_selector      => CTRL1_Enab_net_0,
        TX_load          => MoM_unit_0_TX_load,
        RX_processed     => MoM_unit_0_RX_processed,
        d_hk             => MoM_hk,
        commandToEncoder => MoM_unit_0_commandToEncoder,
        MoMState         => statusLed 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N => RESETZB_1,
        -- Outputs
        CLK_OUT => RingOscillator_0_CLK_OUT 
        );
-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => CommandType2ZB_net_0,
        commandReady2uC  => CommandReady2ZB_net_0,
        WD_IRQ           => GND_net,
        R2SINKTimeout    => R2SINKTimeout,
        NWKrRouteTimeout => NWKrRouteTimeout,
        clk              => CLK_GATED_net_0,
        rstn             => RESETZB_1,
        -- Outputs
        ZB_active        => bit_error_0,
        IRQ0             => IRQ0_net_0,
        IRQ1             => IRQ1_net_0,
        IRQ2             => IRQ2_net_0,
        IRQ3             => IRQ3_net_0,
        WD_CLR           => ZBControl_0_WD_CLR,
        d_hk             => OPEN 
        );

end RTL;
