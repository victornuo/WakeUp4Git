----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 29 12:34:10 2013
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
        f59            : in  std_logic;
        -- Outputs
        CLK_GATED      : out std_logic;
        CLK_OUT        : out std_logic;
        F31            : out std_logic;
        F32            : out std_logic;
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
-- fff
component fff
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
        CTRL_CLK : in  std_logic;
        RESET_N  : in  std_logic;
        -- Outputs
        CLK_OUT  : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_GATED_net_0            : std_logic;
signal CLK_OUT_net_0              : std_logic;
signal fff_0_Flash_Freeze_Enabled : std_logic;
signal rstzb_W_pu_net_0           : std_logic;
signal rstzb_W_pu_net_1           : std_logic;
signal CLK_GATED_net_1            : std_logic;
signal CLK_OUT_net_1              : std_logic;
signal rstzb_W_pu_net_2           : std_logic;
signal rstzb_W_pu_net_3           : std_logic;
signal f59_net_0                  : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                    : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 F31              <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 rstzb_W_pu_net_1 <= rstzb_W_pu_net_0;
 RESETZB          <= rstzb_W_pu_net_1;
 CLK_GATED_net_1  <= CLK_GATED_net_0;
 CLK_GATED        <= CLK_GATED_net_1;
 CLK_OUT_net_1    <= CLK_OUT_net_0;
 CLK_OUT          <= CLK_OUT_net_1;
 rstzb_W_pu_net_2 <= rstzb_W_pu_net_0;
 rstzb_W_pu       <= rstzb_W_pu_net_2;
 rstzb_W_pu_net_3 <= rstzb_W_pu_net_0;
 rstzb_W_pD       <= rstzb_W_pu_net_3;
 f59_net_0        <= f59;
 F32              <= f59_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- fff_0
fff_0 : fff
    port map( 
        -- Inputs
        Flash_Freeze_N       => Flash_Freeze_N,
        RST_N                => rstzb_W_pu_net_0,
        CLK                  => CLK_OUT_net_0,
        -- Outputs
        CLK_GATED            => CLK_GATED_net_0,
        Flash_Freeze_Enabled => fff_0_Flash_Freeze_Enabled 
        );
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RST,
        -- Outputs
        Y   => rstzb_W_pu_net_0 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N  => rstzb_W_pu_net_0,
        CTRL_CLK => fff_0_Flash_Freeze_Enabled,
        -- Outputs
        CLK_OUT  => CLK_OUT_net_0 
        );

end RTL;
