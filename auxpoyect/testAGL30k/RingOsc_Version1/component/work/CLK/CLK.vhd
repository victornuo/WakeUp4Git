----------------------------------------------------------------------
-- Created by SmartDesign Tue Apr 09 19:19:53 2013
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
-- CLK entity declaration
----------------------------------------------------------------------
entity CLK is
    -- Port list
    port(
        -- Outputs
        PULSE : out std_logic
        );
end CLK;
----------------------------------------------------------------------
-- CLK architecture body
----------------------------------------------------------------------
architecture RTL of CLK is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- PULSE_GEN   -   Actel:Simulation:PULSE_GEN:1.0.1
component PULSE_GEN
    generic( 
        PULSE_START_TIME : integer := 455 ;
        PULSE_TYPE       : integer := 1 ;
        PULSE_WIDTH      : integer := 455 
        );
    -- Port list
    port(
        -- Outputs
        PULSE : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal PULSE_net_0 : std_logic;
signal PULSE_net_1 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 PULSE_net_1 <= PULSE_net_0;
 PULSE       <= PULSE_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CLK_0   -   Actel:Simulation:PULSE_GEN:1.0.1
CLK_0 : PULSE_GEN
    generic map( 
        PULSE_START_TIME => ( 455 ),
        PULSE_TYPE       => ( 1 ),
        PULSE_WIDTH      => ( 455 )
        )
    port map( 
        -- Outputs
        PULSE => PULSE_net_0 
        );

end RTL;
