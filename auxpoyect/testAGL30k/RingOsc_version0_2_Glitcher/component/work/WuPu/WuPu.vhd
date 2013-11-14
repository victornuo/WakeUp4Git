----------------------------------------------------------------------
-- Created by SmartDesign Tue Aug 06 14:47:28 2013
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
        f31            : in  std_logic;
        -- Outputs
        CLK_GATED      : out std_logic;
        CLK_OUT        : out std_logic;
        F32            : out std_logic;
        F59            : out std_logic;
        RESETZB        : out std_logic;
        rstzb_W_pD     : out std_logic
        );
end WuPu;
----------------------------------------------------------------------
-- WuPu architecture body
----------------------------------------------------------------------
architecture RTL of WuPu is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- couter2
component couter2
    -- Port list
    port(
        -- Inputs
        Aclr  : in  std_logic;
        Clock : in  std_logic;
        -- Outputs
        Q     : out std_logic_vector(3 downto 0);
        Tcnt  : out std_logic
        );
end component;
-- fffffff
component fffffff
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
signal CLK_GATED_net_0   : std_logic;
signal CLK_GATED_0       : std_logic;
signal CLK_OUT_net_0     : std_logic;
signal RESETZB_1         : std_logic;
signal RESETZB_1_net_0   : std_logic;
signal rstzb_W_pD_net_0  : std_logic;
signal CLK_GATED_0_net_0 : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net           : std_logic;
signal VCC_net           : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
 VCC_net <= '1';
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 F32               <= '0';
 F59               <= '0';
 CLK_OUT           <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 RESETZB_1_net_0   <= RESETZB_1;
 RESETZB           <= RESETZB_1_net_0;
 rstzb_W_pD_net_0  <= f31;
 rstzb_W_pD        <= rstzb_W_pD_net_0;
 CLK_GATED_0_net_0 <= CLK_GATED_0;
 CLK_GATED         <= CLK_GATED_0_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- couter2_0
couter2_0 : couter2
    port map( 
        -- Inputs
        Aclr  => f31,
        Clock => CLK_GATED_net_0,
        -- Outputs
        Tcnt  => CLK_GATED_0,
        Q     => OPEN 
        );
-- fffffff_0
fffffff_0 : fffffff
    port map( 
        -- Inputs
        Flash_Freeze_N       => Flash_Freeze_N,
        RST_N                => RESETZB_1,
        CLK                  => CLK_OUT_net_0,
        Done_Housekeeping    => VCC_net,
        -- Outputs
        CLK_GATED            => CLK_GATED_net_0,
        Wait_Housekeeping    => OPEN,
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
        RESET_N  => RESETZB_1,
        CTRL_CLK => f31,
        -- Outputs
        CLK_OUT  => CLK_OUT_net_0 
        );

end RTL;
