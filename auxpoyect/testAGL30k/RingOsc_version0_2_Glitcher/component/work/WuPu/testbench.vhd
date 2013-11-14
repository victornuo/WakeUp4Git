----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Aug 06 14:47:28 2013
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

    component WuPu
        -- ports
        port( 
            -- Inputs
            RST : in std_logic;
            f31 : in std_logic;
            Flash_Freeze_N : in std_logic;

            -- Outputs
            RESETZB : out std_logic;
            rstzb_W_pD : out std_logic;
            F32 : out std_logic;
            F59 : out std_logic;
            CLK_GATED : out std_logic;
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

    -- Instantiate Unit Under Test:  WuPu
    WuPu_0 : WuPu
        -- port map
        port map( 
            -- Inputs
            RST => NSYSRESET,
            f31 => '0',
            Flash_Freeze_N => '0',

            -- Outputs
            RESETZB =>  open,
            rstzb_W_pD =>  open,
            F32 =>  open,
            F59 =>  open,
            CLK_GATED =>  open,
            CLK_OUT =>  open

            -- Inouts

        );

end behavioral;

