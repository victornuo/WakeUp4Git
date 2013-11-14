----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 14:29:37 2013
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_GATED_net_0 : std_logic;
signal CLK_OUT_net_0   : std_logic;
signal RST_net_0       : std_logic;
signal CLK_GATED_net_1 : std_logic;
signal CLK_OUT_net_1   : std_logic;
signal RST_net_1       : std_logic;
signal RST_net_2       : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net         : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 F59             <= '0';
 F32             <= '0';
 F31             <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 RST_net_0       <= RST;
 RESETZB         <= RST_net_0;
 CLK_GATED_net_1 <= CLK_GATED_net_0;
 CLK_GATED       <= CLK_GATED_net_1;
 CLK_OUT_net_1   <= CLK_OUT_net_0;
 CLK_OUT         <= CLK_OUT_net_1;
 RST_net_1       <= RST;
 rstzb_W_pu      <= RST_net_1;
 RST_net_2       <= RST;
 rstzb_W_pD      <= RST_net_2;
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
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N => RST,
        -- Outputs
        CLK_OUT => CLK_OUT_net_0 
        );

end RTL;
