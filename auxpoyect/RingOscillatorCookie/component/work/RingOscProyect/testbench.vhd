----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Feb 28 13:05:10 2013
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

    component RingOscProyect
        -- ports
        port( 
            -- Inputs
            RESET0 : in std_logic;

            -- Outputs
            Q : out std_logic_vector(9 downto 0);
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

    -- Instantiate Unit Under Test:  RingOscProyect
    RingOscProyect_0 : RingOscProyect
        -- port map
        port map( 
            -- Inputs
            RESET0 => NSYSRESET,

            -- Outputs
            Q => open,
            CLK_OUT =>  open

            -- Inouts

        );

end behavioral;

