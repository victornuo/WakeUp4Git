----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Jun 14 16:50:51 2013
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

    component ZBCONTROLER_IRQs
        -- ports
        port( 
            -- Inputs
            NWKrRouteTimeout : in std_logic;
            R2SINKTimeout : in std_logic;
            Rstn : in std_logic;
            Command_Type : in std_logic;
            Command_Ready : in std_logic;
            Flash_Freeze_N : in std_logic;

            -- Outputs
            IRQ3 : out std_logic;
            IRQ1 : out std_logic;
            IRQ0 : out std_logic;
            IRQ2 : out std_logic;
            ZB_RST : out std_logic;
            CLK_GATED : out std_logic

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

    -- Instantiate Unit Under Test:  ZBCONTROLER_IRQs
    ZBCONTROLER_IRQs_0 : ZBCONTROLER_IRQs
        -- port map
        port map( 
            -- Inputs
            NWKrRouteTimeout => '0',
            R2SINKTimeout => NSYSRESET,
            Rstn => NSYSRESET,
            Command_Type => '0',
            Command_Ready => '0',
            Flash_Freeze_N => '0',

            -- Outputs
            IRQ3 =>  open,
            IRQ1 =>  open,
            IRQ0 =>  open,
            IRQ2 =>  open,
            ZB_RST =>  open,
            CLK_GATED =>  open

            -- Inouts

        );

end behavioral;

