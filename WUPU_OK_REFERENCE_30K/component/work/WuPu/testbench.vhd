----------------------------------------------------------------------
-- Created by Actel SmartDesign Tue Aug 06 16:45:36 2013
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
            Wakeup : in std_logic;
            RX : in std_logic;
            uC_commandType : in std_logic;
            uC_commandReady : in std_logic;
            RST : in std_logic;
            NWKrRouteTimeout : in std_logic;
            R2SINKTimeout : in std_logic;
            Sel_address : in std_logic_vector(1 downto 0);

            -- Outputs
            TX : out std_logic;
            CommandType2ZB : out std_logic;
            CommandReady2ZB : out std_logic;
            RESETZB : out std_logic;
            RX_OUT : out std_logic;
            AddOKflag : out std_logic;
            bit_error : out std_logic;
            IRQ1 : out std_logic;
            IRQ2 : out std_logic;
            IRQ3 : out std_logic;
            CLK_GATED : out std_logic;
            Decoder_hk : out std_logic;
            CTRL1_Enab : out std_logic;
            f32 : out std_logic;
            f59 : out std_logic;
            IRQ0 : out std_logic;
            MoMstateLed : out std_logic_vector(2 downto 0);

            -- Inouts
            CTRL1 : inout std_logic

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
            Wakeup => '0',
            RX => '0',
            uC_commandType => '0',
            uC_commandReady => '0',
            RST => NSYSRESET,
            NWKrRouteTimeout => '0',
            R2SINKTimeout => NSYSRESET,
            Sel_address => (others=> '0'),

            -- Outputs
            TX =>  open,
            CommandType2ZB =>  open,
            CommandReady2ZB =>  open,
            RESETZB =>  open,
            RX_OUT =>  open,
            AddOKflag =>  open,
            bit_error =>  open,
            IRQ1 =>  open,
            IRQ2 =>  open,
            IRQ3 =>  open,
            CLK_GATED =>  open,
            Decoder_hk =>  open,
            CTRL1_Enab =>  open,
            f32 =>  open,
            f59 =>  open,
            IRQ0 =>  open,
            MoMstateLed => open,

            -- Inouts
            CTRL1 =>  open

        );

end behavioral;
