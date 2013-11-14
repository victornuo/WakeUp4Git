----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 11:49:13 2013
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
signal RESETZB_1       : std_logic;
signal RESETZB_1_net_0 : std_logic;
signal CLK_GATED_net_1 : std_logic;
signal CLK_OUT_net_1   : std_logic;
signal RESETZB_1_net_1 : std_logic;
signal RESETZB_1_net_2 : std_logic;
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
 RESETZB_1_net_0 <= RESETZB_1;
 RESETZB         <= RESETZB_1_net_0;
 CLK_GATED_net_1 <= CLK_GATED_net_0;
 CLK_GATED       <= CLK_GATED_net_1;
 CLK_OUT_net_1   <= CLK_OUT_net_0;
 CLK_OUT         <= CLK_OUT_net_1;
 RESETZB_1_net_1 <= RESETZB_1;
 rstzb_W_pu      <= RESETZB_1_net_1;
 RESETZB_1_net_2 <= RESETZB_1;
 rstzb_W_pD      <= RESETZB_1_net_2;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- FF_0
FF_0 : FF
    port map( 
        -- Inputs
        Flash_Freeze_N       => Flash_Freeze_N,
        RST_N                => RESETZB_1,
        CLK                  => CLK_OUT_net_0,
        -- Outputs
        CLK_GATED            => CLK_GATED_net_0,
        Flash_Freeze_Enabled => OPEN 
        );
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RST,
        -- Outputs
        Y   => RESETZB_1 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N => RESETZB_1,
        -- Outputs
        CLK_OUT => CLK_OUT_net_0 
        );

end RTL;
