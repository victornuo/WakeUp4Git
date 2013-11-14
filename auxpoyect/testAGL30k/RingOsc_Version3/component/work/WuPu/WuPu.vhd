----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 17:28:54 2013
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
        A              : in  std_logic;
        B              : in  std_logic;
        Flash_Freeze_N : in  std_logic;
        RST            : in  std_logic;
        -- Outputs
        CLK_GATED      : out std_logic;
        CLK_OUT        : out std_logic;
        F31            : out std_logic;
        F32            : out std_logic;
        F59            : out std_logic;
        RESETZB        : out std_logic;
        rstzb_W_pD     : out std_logic;
        rstzb_W_pu     : out std_logic
        );
end WuPu;
----------------------------------------------------------------------
-- WuPu architecture body
----------------------------------------------------------------------
architecture RTL of WuPu is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- FF
component FF
    -- Port list
    port(
        -- Inputs
        CLK                  : in  std_logic;
        Flash_Freeze_N       : in  std_logic;
        RST_N                : in  std_logic;
        -- Outputs
        CLK_GATED            : out std_logic;
        Flash_Freeze_Enabled : out std_logic
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
signal CLK_GATED_net_0  : std_logic;
signal CLK_OUT_net_0    : std_logic;
signal rstzb_W_pD_net_0 : std_logic;
signal CLK_GATED_net_1  : std_logic;
signal CLK_OUT_net_1    : std_logic;
signal rstzb_W_pD_net_1 : std_logic;
signal rstzb_W_pD_net_2 : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net          : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 F59              <= '0';
 F32              <= '0';
 F31              <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 rstzb_W_pD_net_0 <= RST;
 RESETZB          <= rstzb_W_pD_net_0;
 CLK_GATED_net_1  <= CLK_GATED_net_0;
 CLK_GATED        <= CLK_GATED_net_1;
 CLK_OUT_net_1    <= CLK_OUT_net_0;
 CLK_OUT          <= CLK_OUT_net_1;
 rstzb_W_pD_net_1 <= RST;
 rstzb_W_pu       <= rstzb_W_pD_net_1;
 rstzb_W_pD_net_2 <= RST;
 rstzb_W_pD       <= rstzb_W_pD_net_2;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- FF_0
FF_0 : FF
    port map( 
        -- Inputs
        Flash_Freeze_N       => Flash_Freeze_N,
        RST_N                => RST,
        CLK                  => CLK_OUT_net_0,
        -- Outputs
        CLK_GATED            => CLK_GATED_net_0,
        Flash_Freeze_Enabled => OPEN 
        );
-- NAND2_0
NAND2_0 : NAND2
    port map( 
        -- Inputs
        A => A,
        B => B,
        -- Outputs
        Y => CLK_OUT_net_0 
        );

end RTL;
