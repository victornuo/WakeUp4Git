----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 17:22:56 2013
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
        RESET_N : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
        );
end RingOscillator;
----------------------------------------------------------------------
-- RingOscillator architecture body
----------------------------------------------------------------------
architecture RTL of RingOscillator is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- DFI1C0
component DFI1C0
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        CLR : in  std_logic;
        D   : in  std_logic;
        -- Outputs
        QN  : out std_logic
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_OUT_net_0 : std_logic;
signal DFI1C0_0_QN   : std_logic;
signal DFI1C0_1_QN   : std_logic;
signal DFI1C0_2_QN   : std_logic;
signal DFI1C0_3_QN   : std_logic;
signal DFI1C0_4_QN   : std_logic;
signal NAND2_0_Y_1   : std_logic;
signal NAND2_1_Y     : std_logic;
signal NAND2_2_Y     : std_logic;
signal NAND2_3_Y     : std_logic;
signal NAND2_4_Y     : std_logic;
signal NAND2_5_Y     : std_logic;
signal NAND2_6_Y     : std_logic;
signal NAND2_7_Y     : std_logic;
signal NAND2_8_Y     : std_logic;
signal NAND2_9_Y     : std_logic;
signal NAND2_10_Y    : std_logic;
signal NAND2_11_Y    : std_logic;
signal NAND2_12_Y    : std_logic;
signal NAND2_13_Y    : std_logic;
signal NAND2_14_Y    : std_logic;
signal NAND2_15_Y    : std_logic;
signal NAND2_16_Y    : std_logic;
signal NAND2_17_Y    : std_logic;
signal NAND2_18_Y    : std_logic;
signal NAND2_19_Y    : std_logic;
signal NAND2_20_Y    : std_logic;
signal CLK_OUT_net_1 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLK_OUT_net_1 <= CLK_OUT_net_0;
 CLK_OUT       <= CLK_OUT_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- DFI1C0_0
DFI1C0_0 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_0_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => DFI1C0_0_QN 
        );
-- DFI1C0_1
DFI1C0_1 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_0_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => DFI1C0_1_QN 
        );
-- DFI1C0_2
DFI1C0_2 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_1_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => DFI1C0_2_QN 
        );
-- DFI1C0_3
DFI1C0_3 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_2_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => DFI1C0_3_QN 
        );
-- DFI1C0_4
DFI1C0_4 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_3_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => DFI1C0_4_QN 
        );
-- DFI1C0_5
DFI1C0_5 : DFI1C0
    port map( 
        -- Inputs
        D   => DFI1C0_4_QN,
        CLK => NAND2_5_Y,
        CLR => RESET_N,
        -- Outputs
        QN  => CLK_OUT_net_0 
        );
-- NAND2_0
NAND2_0 : NAND2
    port map( 
        -- Inputs
        A => NAND2_4_Y,
        B => NAND2_4_Y,
        -- Outputs
        Y => NAND2_0_Y_1 
        );
-- NAND2_1
NAND2_1 : NAND2
    port map( 
        -- Inputs
        A => NAND2_3_Y,
        B => NAND2_3_Y,
        -- Outputs
        Y => NAND2_1_Y 
        );
-- NAND2_2
NAND2_2 : NAND2
    port map( 
        -- Inputs
        A => NAND2_15_Y,
        B => NAND2_15_Y,
        -- Outputs
        Y => NAND2_2_Y 
        );
-- NAND2_3
NAND2_3 : NAND2
    port map( 
        -- Inputs
        A => NAND2_7_Y,
        B => NAND2_7_Y,
        -- Outputs
        Y => NAND2_3_Y 
        );
-- NAND2_4
NAND2_4 : NAND2
    port map( 
        -- Inputs
        A => RESET_N,
        B => NAND2_5_Y,
        -- Outputs
        Y => NAND2_4_Y 
        );
-- NAND2_5
NAND2_5 : NAND2
    port map( 
        -- Inputs
        A => NAND2_20_Y,
        B => NAND2_20_Y,
        -- Outputs
        Y => NAND2_5_Y 
        );
-- NAND2_6
NAND2_6 : NAND2
    port map( 
        -- Inputs
        A => NAND2_14_Y,
        B => NAND2_14_Y,
        -- Outputs
        Y => NAND2_6_Y 
        );
-- NAND2_7
NAND2_7 : NAND2
    port map( 
        -- Inputs
        A => NAND2_11_Y,
        B => NAND2_11_Y,
        -- Outputs
        Y => NAND2_7_Y 
        );
-- NAND2_8
NAND2_8 : NAND2
    port map( 
        -- Inputs
        A => NAND2_10_Y,
        B => NAND2_10_Y,
        -- Outputs
        Y => NAND2_8_Y 
        );
-- NAND2_9
NAND2_9 : NAND2
    port map( 
        -- Inputs
        A => NAND2_0_Y_1,
        B => NAND2_0_Y_1,
        -- Outputs
        Y => NAND2_9_Y 
        );
-- NAND2_10
NAND2_10 : NAND2
    port map( 
        -- Inputs
        A => NAND2_9_Y,
        B => NAND2_9_Y,
        -- Outputs
        Y => NAND2_10_Y 
        );
-- NAND2_11
NAND2_11 : NAND2
    port map( 
        -- Inputs
        A => NAND2_18_Y,
        B => NAND2_18_Y,
        -- Outputs
        Y => NAND2_11_Y 
        );
-- NAND2_12
NAND2_12 : NAND2
    port map( 
        -- Inputs
        A => NAND2_19_Y,
        B => NAND2_19_Y,
        -- Outputs
        Y => NAND2_12_Y 
        );
-- NAND2_13
NAND2_13 : NAND2
    port map( 
        -- Inputs
        A => NAND2_2_Y,
        B => NAND2_2_Y,
        -- Outputs
        Y => NAND2_13_Y 
        );
-- NAND2_14
NAND2_14 : NAND2
    port map( 
        -- Inputs
        A => NAND2_12_Y,
        B => NAND2_12_Y,
        -- Outputs
        Y => NAND2_14_Y 
        );
-- NAND2_15
NAND2_15 : NAND2
    port map( 
        -- Inputs
        A => NAND2_1_Y,
        B => NAND2_1_Y,
        -- Outputs
        Y => NAND2_15_Y 
        );
-- NAND2_16
NAND2_16 : NAND2
    port map( 
        -- Inputs
        A => NAND2_13_Y,
        B => NAND2_13_Y,
        -- Outputs
        Y => NAND2_16_Y 
        );
-- NAND2_17
NAND2_17 : NAND2
    port map( 
        -- Inputs
        A => NAND2_16_Y,
        B => NAND2_16_Y,
        -- Outputs
        Y => NAND2_17_Y 
        );
-- NAND2_18
NAND2_18 : NAND2
    port map( 
        -- Inputs
        A => NAND2_6_Y,
        B => NAND2_6_Y,
        -- Outputs
        Y => NAND2_18_Y 
        );
-- NAND2_19
NAND2_19 : NAND2
    port map( 
        -- Inputs
        A => NAND2_8_Y,
        B => NAND2_8_Y,
        -- Outputs
        Y => NAND2_19_Y 
        );
-- NAND2_20
NAND2_20 : NAND2
    port map( 
        -- Inputs
        A => NAND2_17_Y,
        B => NAND2_17_Y,
        -- Outputs
        Y => NAND2_20_Y 
        );

end RTL;
