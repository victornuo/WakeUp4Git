----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Aug 06 15:13:51 2013
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture behavioral of testbench is

    constant SYSCLK_PERIOD : time := 100 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component RingOscillator
        -- ports
        port( 
            -- Inputs
            RESET_N : in std_logic;
            Enable_N : in std_logic;

            -- Outputs
            CLK_OUT : out std_logic

            -- Inouts

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- 10MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  RingOscillator
    RingOscillator_0 : RingOscillator
        -- port map
        port map( 
            -- Inputs
            RESET_N => NSYSRESET,
            Enable_N => '0',

            -- Outputs
            CLK_OUT =>  open

            -- Inouts

        );

end behavioral;

