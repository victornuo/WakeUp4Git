----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Apr 04 16:54:14 2013
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: TB_ZBControl.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO> <Die::AGL250V5> <Package::100 VQFP>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity TB_ZBControl is
end TB_ZBControl;

architecture behavioral of TB_ZBControl is

    constant SYSCLK_PERIOD : time := 100 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component ASCII_Char
        -- ports
        port( 
            -- Inputs

            -- Outputs

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

    -- Instantiate Unit Under Test:  ASCII_Char
    ASCII_Char_0 : ASCII_Char
        -- port map
        port map( 
            -- Inputs

            -- Outputs

            -- Inouts

        );

end behavioral;

