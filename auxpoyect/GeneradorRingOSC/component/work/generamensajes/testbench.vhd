----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Oct 11 13:32:50 2013
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

    component generamensajes
        -- ports
        port( 
            -- Inputs
            EN : in std_logic;
            adress1 : in std_logic;
            Reset : in std_logic;
            adress3 : in std_logic;
            adress4 : in std_logic;
            adress2 : in std_logic;
            b_msg : in std_logic;
            extern_msg : in std_logic;
            Sel0 : in std_logic;
            Sel1 : in std_logic;
            din : in std_logic;
            MSB_A_B : in std_logic;
            TXI : in std_logic;
            RXI : in std_logic;

            -- Outputs
            dout : out std_logic;
            leddin1 : out std_logic;
            leddin0 : out std_logic;
            TX_Active : out std_logic;
            sel0o : out std_logic;
            sel1o : out std_logic;
            CLK_OUT : out std_logic;
            NewMsgTrigger : out std_logic;
            led6 : out std_logic;
            led7 : out std_logic;
            led5 : out std_logic;
            led8 : out std_logic;
            led9 : out std_logic;
            TXO : out std_logic;
            RXO : out std_logic

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

    -- Instantiate Unit Under Test:  generamensajes
    generamensajes_0 : generamensajes
        -- port map
        port map( 
            -- Inputs
            EN => '0',
            adress1 => '0',
            Reset => NSYSRESET,
            adress3 => '0',
            adress4 => '0',
            adress2 => '0',
            b_msg => '0',
            extern_msg => '0',
            Sel0 => '0',
            Sel1 => '0',
            din => '0',
            MSB_A_B => '0',
            TXI => '0',
            RXI => '0',

            -- Outputs
            dout =>  open,
            leddin1 =>  open,
            leddin0 =>  open,
            TX_Active =>  open,
            sel0o =>  open,
            sel1o =>  open,
            CLK_OUT =>  open,
            NewMsgTrigger =>  open,
            led6 =>  open,
            led7 =>  open,
            led5 =>  open,
            led8 =>  open,
            led9 =>  open,
            TXO =>  open,
            RXO =>  open

            -- Inouts

        );

end behavioral;

