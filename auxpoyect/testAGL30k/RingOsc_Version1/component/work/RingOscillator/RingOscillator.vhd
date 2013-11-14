----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 16:30:33 2013
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
-- AOI5
component AOI5
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
        Q     : out std_logic_vector(4 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AOI5_0_Y        : std_logic;
signal AOI5_1_Y        : std_logic;
signal AOI5_2_Y        : std_logic;
signal AOI5_3_Y        : std_logic;
signal AOI5_4_Y        : std_logic;
signal AOI5_5_Y        : std_logic;
signal AOI5_6_Y        : std_logic;
signal AOI5_7_Y        : std_logic;
signal AOI5_8_Y        : std_logic;
signal AOI5_9_Y        : std_logic;
signal AOI5_10_Y       : std_logic;
signal AOI5_11_Y       : std_logic;
signal CLK_OUT_0       : std_logic_vector(4 to 4);
signal NAND2_0_Y       : std_logic;
signal CLK_OUT_0_net_0 : std_logic;
signal Q_slice_0       : std_logic_vector(0 to 0);
signal Q_slice_1       : std_logic_vector(1 to 1);
signal Q_slice_2       : std_logic_vector(2 to 2);
signal Q_slice_3       : std_logic_vector(3 to 3);
signal Q_net_0         : std_logic_vector(4 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net         : std_logic;
signal VCC_net         : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLK_OUT_0_net_0 <= CLK_OUT_0(4);
 CLK_OUT         <= CLK_OUT_0_net_0;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 CLK_OUT_0(4) <= Q_net_0(4);
 Q_slice_0(0) <= Q_net_0(0);
 Q_slice_1(1) <= Q_net_0(1);
 Q_slice_2(2) <= Q_net_0(2);
 Q_slice_3(3) <= Q_net_0(3);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AOI5_0
AOI5_0 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => NAND2_0_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_0_Y 
        );
-- AOI5_1
AOI5_1 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_0_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_1_Y 
        );
-- AOI5_2
AOI5_2 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_1_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_2_Y 
        );
-- AOI5_3
AOI5_3 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_2_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_3_Y 
        );
-- AOI5_4
AOI5_4 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_3_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_4_Y 
        );
-- AOI5_5
AOI5_5 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_4_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_5_Y 
        );
-- AOI5_6
AOI5_6 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_5_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_6_Y 
        );
-- AOI5_7
AOI5_7 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_6_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_7_Y 
        );
-- AOI5_8
AOI5_8 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_7_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_8_Y 
        );
-- AOI5_9
AOI5_9 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_8_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_9_Y 
        );
-- AOI5_10
AOI5_10 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_9_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_10_Y 
        );
-- AOI5_11
AOI5_11 : AOI5
    port map( 
        -- Inputs
        A => GND_net,
        B => AOI5_10_Y,
        C => VCC_net,
        -- Outputs
        Y => AOI5_11_Y 
        );
-- NAND2_0
NAND2_0 : NAND2
    port map( 
        -- Inputs
        A => RESET_N,
        B => AOI5_11_Y,
        -- Outputs
        Y => NAND2_0_Y 
        );
-- ringO_cnt_0
ringO_cnt_0 : ringO_cnt
    port map( 
        -- Inputs
        Aclr  => RESET_N,
        Clock => AOI5_11_Y,
        -- Outputs
        Q     => Q_net_0 
        );

end RTL;
