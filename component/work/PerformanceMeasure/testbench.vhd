----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Nov 12 18:53:08 2013
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

    component PerformanceMeasure
        -- ports
        port( 
            -- Inputs
            rstn : in std_logic;
            ClearPerformData : in std_logic;
            CntTX : in std_logic;
            clk : in std_logic;
            RaisePMFlag : in std_logic;
            MsgType : in std_logic;
            NewMsg : in std_logic;

            -- Outputs
            PM_msgType : out std_logic;
            PM_DataReady : out std_logic;
            d_hk : out std_logic;
            PM_TXCounter : out std_logic_vector(2 downto 0)

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

    -- Instantiate Unit Under Test:  PerformanceMeasure
    PerformanceMeasure_0 : PerformanceMeasure
        -- port map
        port map( 
            -- Inputs
            rstn => NSYSRESET,
            ClearPerformData => '0',
            CntTX => '0',
            clk => SYSCLK,
            RaisePMFlag => '0',
            MsgType => '0',
            NewMsg => '0',

            -- Outputs
            PM_msgType =>  open,
            PM_DataReady =>  open,
            d_hk =>  open,
            PM_TXCounter => open

            -- Inouts

        );

end behavioral;

