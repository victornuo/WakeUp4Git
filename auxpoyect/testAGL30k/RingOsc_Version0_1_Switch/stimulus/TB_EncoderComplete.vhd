----------------------------------------------------------------------
-- Created by Actel SmartDesign Mon Jun 03 11:10:31 2013
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TB_encoderComplete is
end TB_encoderComplete;

architecture behavioral of TB_encoderComplete is

    constant SYSCLK_PERIOD : time := 833 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
	signal load : std_logic := '0';
	signal start : std_logic := '0';
	signal dout : std_logic := '0';
	signal d_hk : std_logic := '0';
	signal din : std_logic_vector (1 downto 0) := "00";
	signal nextHopAddress : std_logic_vector (7 downto 0):= "11000111";
	signal TX_Active : std_logic := '0';

	

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
		variable count : integer range 0 to 3 := 0;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
			vhdl_initial := FALSE;
		end if;
		
			case count is
				when 0 =>
					din <= "01";
				when 1 => 
					din <= "00";
				when others =>
					din <= "00";

			end case;
			
			wait for SYSCLK_PERIOD*5;
			load<= '1';
			wait for SYSCLK_PERIOD*5;
			load <= '0';
			start <= '1';
			wait for SYSCLK_PERIOD;
			start <= '0';

		-- insert stimulus here 

			wait until falling_edge (TX_Active);
			-- start <= '0';
			-- wait for 2000 us;
			count := count + 1;
			
			
			wait for SYSCLK_PERIOD*10;
			
			if  (count = 2) then
				
				wait;
			end if;	
		
    
		--end if;
    end process;
	


    -- 10MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  manchesterEncoderComplete
    manchesterEncoderComplete_0 : manchesterEncoderComplete
        -- port map
        port map( 
            -- Inputs
            load_din => load,
            start => start,
            clk => SYSCLK,
            rstn => NSYSRESET,
            din => din,
            nextHopAddress => nextHopAddress,

            -- Outputs
            dout =>  dout,
            d_hk =>  d_hk,
            TX_Active =>  TX_Active

            -- Inouts

        );

end behavioral;

