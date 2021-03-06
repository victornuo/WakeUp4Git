----------------------------------------------------------------------
-- Created by SmartDesign Tue Aug 06 15:13:51 2013
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
-- RingOscillator entity declaration
----------------------------------------------------------------------
entity RingOscillator is
    -- Port list
    port(
        -- Inputs
        Enable_N : in  std_logic;
        RESET_N  : in  std_logic;
        -- Outputs
        CLK_OUT  : out std_logic
        );
end RingOscillator;
----------------------------------------------------------------------
-- RingOscillator architecture body
----------------------------------------------------------------------
architecture RTL of RingOscillator is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AO14
component AO14
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        C : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- muxSwitcthRing
component muxSwitcthRing
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic;
        Data1_port : in  std_logic;
        Sel0       : in  std_logic;
        -- Outputs
        Result     : out std_logic
        );
end component;
-- NAND2
component NAND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- ringO_cnt
component ringO_cnt
    -- Port list
    port(
        -- Inputs
        Aclr  : in  std_logic;
        Clock : in  std_logic;
        -- Outputs
        Q     : out std_logic_vector(3 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AO14_0_Y                : std_logic;
signal AO14_1_Y                : std_logic;
signal AO14_2_Y                : std_logic;
signal AO14_3_Y                : std_logic;
signal AO14_4_Y                : std_logic;
signal AO14_5_Y                : std_logic;
signal AO14_6_Y                : std_logic;
signal AO14_7_Y                : std_logic;
signal AO14_8_Y                : std_logic;
signal AO14_9_Y                : std_logic;
signal AO14_10_Y               : std_logic;
signal AO14_11_Y               : std_logic;
signal AO14_12_Y               : std_logic;
signal AO14_13_Y               : std_logic;
signal AO14_14_Y               : std_logic;
signal AO14_15_Y               : std_logic;
signal AO14_16_Y               : std_logic;
signal AO14_17_Y               : std_logic;
signal AO14_18_Y               : std_logic;
signal AO14_19_Y               : std_logic;
signal AO14_20_Y               : std_logic;
signal AO14_21_Y               : std_logic;
signal AO14_22_Y               : std_logic;
signal AO14_23_Y               : std_logic;
signal CLK_OUT_net_0           : std_logic_vector(3 to 3);
signal muxSwitcthRing_0_Result : std_logic;
signal NAND2_0_Y               : std_logic;
signal CLK_OUT_net_1           : std_logic;
signal Q_slice_0               : std_logic_vector(0 to 0);
signal Q_slice_1               : std_logic_vector(1 to 1);
signal Q_slice_2               : std_logic_vector(2 to 2);
signal Q_net_0                 : std_logic_vector(3 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                 : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLK_OUT_net_1 <= CLK_OUT_net_0(3);
 CLK_OUT       <= CLK_OUT_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 CLK_OUT_net_0(3) <= Q_net_0(3);
 Q_slice_0(0)     <= Q_net_0(0);
 Q_slice_1(1)     <= Q_net_0(1);
 Q_slice_2(2)     <= Q_net_0(2);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AO14_0
AO14_0 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => muxSwitcthRing_0_Result,
        -- Outputs
        Y => AO14_0_Y 
        );
-- AO14_1
AO14_1 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_0_Y,
        -- Outputs
        Y => AO14_1_Y 
        );
-- AO14_2
AO14_2 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_1_Y,
        -- Outputs
        Y => AO14_2_Y 
        );
-- AO14_3
AO14_3 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_16_Y,
        -- Outputs
        Y => AO14_3_Y 
        );
-- AO14_4
AO14_4 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_3_Y,
        -- Outputs
        Y => AO14_4_Y 
        );
-- AO14_5
AO14_5 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_4_Y,
        -- Outputs
        Y => AO14_5_Y 
        );
-- AO14_6
AO14_6 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_19_Y,
        -- Outputs
        Y => AO14_6_Y 
        );
-- AO14_7
AO14_7 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_6_Y,
        -- Outputs
        Y => AO14_7_Y 
        );
-- AO14_8
AO14_8 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_7_Y,
        -- Outputs
        Y => AO14_8_Y 
        );
-- AO14_9
AO14_9 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_22_Y,
        -- Outputs
        Y => AO14_9_Y 
        );
-- AO14_10
AO14_10 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_9_Y,
        -- Outputs
        Y => AO14_10_Y 
        );
-- AO14_11
AO14_11 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_10_Y,
        -- Outputs
        Y => AO14_11_Y 
        );
-- AO14_12
AO14_12 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_2_Y,
        -- Outputs
        Y => AO14_12_Y 
        );
-- AO14_13
AO14_13 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_12_Y,
        -- Outputs
        Y => AO14_13_Y 
        );
-- AO14_14
AO14_14 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_23_Y,
        -- Outputs
        Y => AO14_14_Y 
        );
-- AO14_15
AO14_15 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_14_Y,
        -- Outputs
        Y => AO14_15_Y 
        );
-- AO14_16
AO14_16 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_13_Y,
        -- Outputs
        Y => AO14_16_Y 
        );
-- AO14_17
AO14_17 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_5_Y,
        -- Outputs
        Y => AO14_17_Y 
        );
-- AO14_18
AO14_18 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_17_Y,
        -- Outputs
        Y => AO14_18_Y 
        );
-- AO14_19
AO14_19 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_18_Y,
        -- Outputs
        Y => AO14_19_Y 
        );
-- AO14_20
AO14_20 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_8_Y,
        -- Outputs
        Y => AO14_20_Y 
        );
-- AO14_21
AO14_21 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_20_Y,
        -- Outputs
        Y => AO14_21_Y 
        );
-- AO14_22
AO14_22 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_21_Y,
        -- Outputs
        Y => AO14_22_Y 
        );
-- AO14_23
AO14_23 : AO14
    port map( 
        -- Inputs
        A => GND_net,
        B => GND_net,
        C => AO14_11_Y,
        -- Outputs
        Y => AO14_23_Y 
        );
-- muxSwitcthRing_0
muxSwitcthRing_0 : muxSwitcthRing
    port map( 
        -- Inputs
        Data0_port => NAND2_0_Y,
        Data1_port => GND_net,
        Sel0       => Enable_N,
        -- Outputs
        Result     => muxSwitcthRing_0_Result 
        );
-- NAND2_0
NAND2_0 : NAND2
    port map( 
        -- Inputs
        A => RESET_N,
        B => AO14_15_Y,
        -- Outputs
        Y => NAND2_0_Y 
        );
-- ringO_cnt_0
ringO_cnt_0 : ringO_cnt
    port map( 
        -- Inputs
        Aclr  => RESET_N,
        Clock => AO14_15_Y,
        -- Outputs
        Q     => Q_net_0 
        );

end RTL;
