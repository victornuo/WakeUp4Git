----------------------------------------------------------------------
-- Created by SmartDesign Fri Jun 14 16:50:51 2013
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
-- ZBCONTROLER_IRQs entity declaration
----------------------------------------------------------------------
entity ZBCONTROLER_IRQs is
    -- Port list
    port(
        -- Inputs
        Command_Ready    : in  std_logic;
        Command_Type     : in  std_logic;
        Flash_Freeze_N   : in  std_logic;
        NWKrRouteTimeout : in  std_logic;
        R2SINKTimeout    : in  std_logic;
        Rstn             : in  std_logic;
        -- Outputs
        CLK_GATED        : out std_logic;
        IRQ0             : out std_logic;
        IRQ1             : out std_logic;
        IRQ2             : out std_logic;
        IRQ3             : out std_logic;
        ZB_RST           : out std_logic
        );
end ZBCONTROLER_IRQs;
----------------------------------------------------------------------
-- ZBCONTROLER_IRQs architecture body
----------------------------------------------------------------------
architecture RTL of ZBCONTROLER_IRQs is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AND2
component AND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- DFN1
component DFN1
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        D   : in  std_logic;
        -- Outputs
        Q   : out std_logic
        );
end component;
-- FFCtrl
component FFCtrl
    -- Port list
    port(
        -- Inputs
        CLK                  : in  std_logic;
        Done_Housekeeping    : in  std_logic;
        Flash_Freeze_N       : in  std_logic;
        RST_N                : in  std_logic;
        -- Outputs
        CLK_GATED            : out std_logic;
        Flash_Freeze_Enabled : out std_logic;
        Wait_Housekeeping    : out std_logic
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
signal AND2_0_Y                   : std_logic;
signal AND2_2_Y                   : std_logic;
signal CLK_GATED_0                : std_logic;
signal DFN1_0_Q                   : std_logic;
signal FFCtrl_0_Wait_Housekeeping : std_logic;
signal IRQ0_net_0                 : std_logic;
signal IRQ1_net_0                 : std_logic;
signal IRQ2_net_0                 : std_logic;
signal IRQ3_net_0                 : std_logic;
signal RingOscillator_0_CLK_OUT   : std_logic;
signal ZBControl_0_d_hk           : std_logic;
signal ZBControl_0_ZB_active      : std_logic;
signal IRQ3_net_1                 : std_logic;
signal IRQ1_net_1                 : std_logic;
signal IRQ0_net_1                 : std_logic;
signal IRQ2_net_1                 : std_logic;
signal ZB_RST_net_0               : std_logic;
signal CLK_GATED_0_net_0          : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                    : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal A_IN_POST_INV0_0           : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 A_IN_POST_INV0_0 <= NOT ZBControl_0_ZB_active;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 IRQ3_net_1        <= IRQ3_net_0;
 IRQ3              <= IRQ3_net_1;
 IRQ1_net_1        <= IRQ1_net_0;
 IRQ1              <= IRQ1_net_1;
 IRQ0_net_1        <= IRQ0_net_0;
 IRQ0              <= IRQ0_net_1;
 IRQ2_net_1        <= IRQ2_net_0;
 IRQ2              <= IRQ2_net_1;
 ZB_RST_net_0      <= Rstn;
 ZB_RST            <= ZB_RST_net_0;
 CLK_GATED_0_net_0 <= CLK_GATED_0;
 CLK_GATED         <= CLK_GATED_0_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => A_IN_POST_INV0_0,
        B => Command_Ready,
        -- Outputs
        Y => AND2_0_Y 
        );
-- AND2_2
AND2_2 : AND2
    port map( 
        -- Inputs
        A => ZBControl_0_d_hk,
        B => FFCtrl_0_Wait_Housekeeping,
        -- Outputs
        Y => AND2_2_Y 
        );
-- DFN1_0
DFN1_0 : DFN1
    port map( 
        -- Inputs
        D   => AND2_0_Y,
        CLK => CLK_GATED_0,
        -- Outputs
        Q   => DFN1_0_Q 
        );
-- FFCtrl_0
FFCtrl_0 : FFCtrl
    port map( 
        -- Inputs
        Flash_Freeze_N       => Flash_Freeze_N,
        RST_N                => Rstn,
        CLK                  => RingOscillator_0_CLK_OUT,
        Done_Housekeeping    => AND2_2_Y,
        -- Outputs
        CLK_GATED            => CLK_GATED_0,
        Wait_Housekeeping    => FFCtrl_0_Wait_Housekeeping,
        Flash_Freeze_Enabled => OPEN 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N => Rstn,
        -- Outputs
        CLK_OUT => RingOscillator_0_CLK_OUT 
        );
-- ZBControl_0
ZBControl_0 : ZBControl
    port map( 
        -- Inputs
        commandType2uC   => Command_Type,
        commandReady2uC  => DFN1_0_Q,
        WD_IRQ           => GND_net,
        R2SINKTimeout    => R2SINKTimeout,
        NWKrRouteTimeout => NWKrRouteTimeout,
        clk              => CLK_GATED_0,
        rstn             => Rstn,
        -- Outputs
        ZB_active        => ZBControl_0_ZB_active,
        IRQ0             => IRQ0_net_0,
        IRQ1             => IRQ1_net_0,
        IRQ2             => IRQ2_net_0,
        IRQ3             => IRQ3_net_0,
        WD_CLR           => OPEN,
        d_hk             => ZBControl_0_d_hk 
        );

end RTL;
