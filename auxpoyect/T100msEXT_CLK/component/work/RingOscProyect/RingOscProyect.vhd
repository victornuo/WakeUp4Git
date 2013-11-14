----------------------------------------------------------------------
-- Created by SmartDesign Thu Feb 28 17:56:15 2013
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
        extCLK  : in  std_logic;
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal INBUF_0_Y     : std_logic;
signal Q_net_0       : std_logic_vector(9 downto 0);
signal CLK_OUT_net_0 : std_logic;
signal Q_net_1       : std_logic_vector(9 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CLK_OUT_net_0 <= extCLK;
 CLK_OUT       <= CLK_OUT_net_0;
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
        Clock => extCLK,
        Aclr  => INBUF_0_Y,
        -- Outputs
        Q     => Q_net_0 
        );

end RTL;
