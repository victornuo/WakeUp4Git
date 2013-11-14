----------------------------------------------------------------------
-- Created by Actel SmartDesign Fri Apr 12 15:19:01 2013
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
            clk : in std_logic;
            RX : in std_logic;
            uC_commandType : in std_logic;
            uC_commandReady : in std_logic;
            RST : in std_logic;
            NWKrRouteTimeout : in std_logic;
            R2SINKTimeout : in std_logic;
            Sel_address : in std_logic_vector(1 downto 0);

            -- Outputs
            TX : out std_logic;
            CommandType2uC : out std_logic;
            CommandReady2uC : out std_logic;
            RFSwitch : out std_logic;
            RESETZB : out std_logic;
            TXMODE : out std_logic;
            RX_OUT : out std_logic;
            AddOKflag : out std_logic;
            bit_error : out std_logic;
            IRQ1 : out std_logic;
            IRQ0 : out std_logic;
            IRQ2 : out std_logic;
            IRQ3 : out std_logic;
            Status_flag : out std_logic;
            MoMstateLed : out std_logic_vector(2 downto 0)

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
            Wakeup => '0',
            clk => SYSCLK,
            RX => '0',
            uC_commandType => '0',
            uC_commandReady => '0',
            RST => NSYSRESET,
            NWKrRouteTimeout => '0',
            R2SINKTimeout => NSYSRESET,
            Sel_address => (others=> '0'),

            -- Outputs
            TX =>  open,
            CommandType2uC =>  open,
            CommandReady2uC =>  open,
            RFSwitch =>  open,
            RESETZB =>  open,
            TXMODE =>  open,
            RX_OUT =>  open,
            AddOKflag =>  open,
            bit_error =>  open,
            IRQ1 =>  open,
            IRQ0 =>  open,
            IRQ2 =>  open,
            IRQ3 =>  open,
            Status_flag =>  open,
            MoMstateLed => open

            -- Inouts

        );

end behavioral;

