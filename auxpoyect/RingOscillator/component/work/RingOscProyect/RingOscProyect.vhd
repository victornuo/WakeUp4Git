----------------------------------------------------------------------
-- Created by SmartDesign Tue May 07 16:42:50 2013
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
-- RingOscProyect entity declaration
----------------------------------------------------------------------
entity RingOscProyect is
    -- Port list
    port(
        -- Inputs
        RESET0  : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic;
        Q       : out std_logic_vector(9 downto 0)
        );
end RingOscProyect;
----------------------------------------------------------------------
-- RingOscProyect architecture body
----------------------------------------------------------------------
architecture RTL of RingOscProyect is
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
-- ledbarTimer
component ledbarTimer
    -- Port list
    port(
        -- Inputs
        Aclr  : in  std_logic;
        Clock : in  std_logic;
        -- Outputs
        Q     : out std_logic_vector(9 downto 0)
        );
end component;
-- RingOscillator
component RingOscillator
    -- Port list
    port(
        -- Inputs
        RESET   : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_OUT_net_0 : std_logic;
signal INBUF_0_Y     : std_logic;
signal Q_net_0       : std_logic_vector(9 downto 0);
signal CLK_OUT_net_1 : std_logic;
signal Q_net_1       : std_logic_vector(9 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLK_OUT_net_1 <= CLK_OUT_net_0;
 CLK_OUT       <= CLK_OUT_net_1;
 Q_net_1       <= Q_net_0;
 Q(9 downto 0) <= Q_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => RESET0,
        -- Outputs
        Y   => INBUF_0_Y 
        );
-- ledbarTimer_0
ledbarTimer_0 : ledbarTimer
    port map( 
        -- Inputs
        Clock => CLK_OUT_net_0,
        Aclr  => INBUF_0_Y,
        -- Outputs
        Q     => Q_net_0 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET   => INBUF_0_Y,
        -- Outputs
        CLK_OUT => CLK_OUT_net_0 
        );

end RTL;
