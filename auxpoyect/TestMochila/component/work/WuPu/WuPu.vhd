----------------------------------------------------------------------
-- Created by SmartDesign Wed Oct 02 12:33:24 2013
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
        RST       : in  std_logic;
        wakeup    : in  std_logic;
        -- Outputs
        CLK_GATED : out std_logic;
        RESETZB   : out std_logic;
        f31       : out std_logic;
        f32       : out std_logic;
        f59       : out std_logic;
        ledstatus : out std_logic
        );
end WuPu;
----------------------------------------------------------------------
-- WuPu architecture body
----------------------------------------------------------------------
architecture RTL of WuPu is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
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
-- newCore
component newCore
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
        Enable_N : in  std_logic;
        RESET_N  : in  std_logic;
        -- Outputs
        CLK_OUT  : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_GATED_net_0                     : std_logic;
signal ledstatus_0                         : std_logic;
signal RESETZB_0                           : std_logic;
signal RingOscillator_0_CLK_OUT            : std_logic;
signal RESETZB_0_net_0                     : std_logic;
signal CLK_GATED_net_1                     : std_logic;
signal ledstatus_0_net_0                   : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                             : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal Flash_Freeze_Enabled_OUT_PRE_INV0_0 : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 ledstatus_0 <= NOT Flash_Freeze_Enabled_OUT_PRE_INV0_0;
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 f31               <= '0';
 f32               <= '0';
 f59               <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 RESETZB_0_net_0   <= RESETZB_0;
 RESETZB           <= RESETZB_0_net_0;
 CLK_GATED_net_1   <= CLK_GATED_net_0;
 CLK_GATED         <= CLK_GATED_net_1;
 ledstatus_0_net_0 <= ledstatus_0;
 ledstatus         <= ledstatus_0_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RST,
        -- Outputs
        Y   => RESETZB_0 
        );
-- newCore_0
newCore_0 : newCore
    port map( 
        -- Inputs
        Flash_Freeze_N       => wakeup,
        RST_N                => RESETZB_0,
        CLK                  => RingOscillator_0_CLK_OUT,
        -- Outputs
        CLK_GATED            => CLK_GATED_net_0,
        Flash_Freeze_Enabled => Flash_Freeze_Enabled_OUT_PRE_INV0_0 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET_N  => RESETZB_0,
        Enable_N => GND_net,
        -- Outputs
        CLK_OUT  => RingOscillator_0_CLK_OUT 
        );

end RTL;
