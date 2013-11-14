----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Oct 10 18:46:40 2013
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

    component manchesterEncoderComplete
        -- ports
        port( 
            -- Inputs
            load_din : in std_logic;
            start : in std_logic;
            clk : in std_logic;
            rstn : in std_logic;
            din : in std_logic_vector(1 downto 0);
            nextHopAddress : in std_logic_vector(7 downto 0);

            -- Outputs
            dout : out std_logic;
            d_hk : out std_logic;
            TX_Active : out std_logic

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

    -- Instantiate Unit Under Test:  manchesterEncoderComplete
    manchesterEncoderComplete_0 : manchesterEncoderComplete
        -- port map
        port map( 
            -- Inputs
            load_din => '0',
            start => '0',
            clk => SYSCLK,
            rstn => NSYSRESET,
            din => (others=> '0'),
            nextHopAddress => (others=> '0'),

            -- Outputs
            dout =>  open,
            d_hk =>  open,
            TX_Active =>  open

            -- Inouts

        );

end behavioral;

