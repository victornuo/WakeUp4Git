----------------------------------------------------------------------
-- Created by Actel SmartDesign Mon Sep 19 13:15:58 2011
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity preSynth_Wupu is
end preSynth_Wupu;

architecture preSynth of preSynth_Wupu is

   
    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
	
	constant R2SINKADDRESS : std_logic_vector (15 downto 0) := "0000111100001111";
	constant SYSCLK_PERIOD : time :=  90.42ns;--20.83ns;--90.42ns;
	constant R2SINK : std_logic := '0';
    constant rRouteNWK : std_logic := '1';
	constant errorRX : std_logic := '0';
	
    signal Command2Send : std_logic := R2SINK ;
	
	signal RXstart : std_logic := '0';
	signal ucSetNewCommand : std_logic := '0';
	
	signal wakeup : std_logic := '0';
	signal RX_wakeup : std_logic := '1';
	signal uC_wakeup : std_logic := '1';
	signal uC_status : std_logic := '0';
	signal RX : std_logic := '0';
	signal TX : std_logic := '0';
	
	signal ActivateuC : std_logic := '0' ;
    signal CommandType2uC : std_logic := '0';
    signal CommandReady2uC : std_logic := '0';
    signal RFSwitch : std_logic := '0';
    signal DataProcessed : std_logic := '0';
    signal Status_flag : std_logic := '0';
   

   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '1';
   signal uC_ACK : std_logic := '0';
   signal rst : std_logic := '0';
   signal addok : std_logic := '0';
   signal MomStateLed : std_logic_vector (2 downto 0) := "000";

    component WuPu
        -- ports
        port( 
            -- Inputs
            Wakeup : in std_logic;
            rst : in std_logic;
            clk : in std_logic;
            RX : in std_logic;
            MoM_enable : in std_logic;
            uC_commandType : in std_logic;
            uCstatus : in std_logic;
            ACK : in std_logic;
            uC_commandReady : in std_logic;
            Sel_address : in std_logic;

            -- Outputs
            TX : out std_logic;
            ActivateuC : out std_logic;
            CommandType2uC : out std_logic;
            CommandReady2uC : out std_logic;
            RFSwitch : out std_logic;
            DataProcessed : out std_logic;
            Status_flag : out std_logic;
            MoMstateLed : out std_logic_vector(2 downto 0);
            addOKLED        : out   std_logic
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

    -- 48MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

   	RX_wakeup <= RX;
--	wakeup <= (RX_wakeup and not RFSwitch) or uC_wakeup;
  wakeup <= '1'; 
	-- Instantiate Unit Under Test:  WuPu
    WuPu_PreSynth : WuPu
        -- port map
        port map( 
            -- Inputs
            Wakeup => wakeup,
            rst => NSYSRESET,
            clk => SYSCLK,
    		RX => RX,
            MoM_enable => uC_addressingData,
			uC_commandType => uC_commandType,
			uC_commandReady => uC_commandReady,
			uCstatus => uC_status,
			ACK => uC_ACK,
            Sel_address => '0',

            -- Outputs
            MoMstateLed => MoMStateLed,
			TX =>  TX,
			ActivateuC =>  ActivateuC,
			CommandType2uC =>  CommandType2uC,
			CommandReady2uC =>  CommandReady2uC,
			RFSwitch =>  RFSwitch,
			DataProcessed =>  DataProcessed,
			Status_flag =>  Status_flag,
			addOKLED => addok

        );
	
	addresses_load_process :process
	begin
		RXstart <= '0';
		wait until rising_edge (NSYSRESET);
		uC_addressingData<= '1';
		uC_wakeup <= '1';
		wait for 31.5us;
		wait until (uC_commandReady = '0') and (uC_commandType = '0');
		wait for sysclk_period;
		uC_addressingData <= '0';
		-- uC_wakeup <= '0';
		
		-- wait until 	rising_edge (ActivateuC);
		-- uC_status <= '1' after 6 us; 
		-- uc_wakeup <= '1' after 19 ns;
		-- wait until 	rising_edge (CommandReady2uC);
		-- uc_ACK <= '1' after 96 ns;
		-- wait for 252ns;
		-- uc_ACK <= '0'; -- after 126 ns;
		
		-- uc_wakeup <= '0' after 6 ns;
			
		-- wait for 2000 us;
		
		-- uc_wakeup <= '1';
		-- wait until falling_edge(Status_flag);
		
		-- uc_wakeup <= '0';
		-- uC_status <= '0';
		
		
		wait for 7 us;
		
		uc_status <= '1';
		uc_wakeup <= '1' after 16 ns;
		--wait until falling_edge(Status_flag);
		wait for 40ns;
		ucSetNewCommand <= '1';
		

		
		wait until rising_edge(DataProcessed);
		wait for 1 us;
		ucSetNewCommand <= '0' ;
		
		uc_wakeup <= '0' after 6 us;
		uC_status <= '0' after 13 ns; 

			
		wait for 3000us;
		RXstart <= '1';
		
		wait until 	rising_edge (ActivateuC);
		uC_status <= '1' after 6 us; 
		uc_wakeup <= '1' after 19 ns;
		wait until 	rising_edge (CommandReady2uC);
		uc_ACK <= '1' after 96 ns;
		wait for 252ns;
		uc_ACK <= '0'; -- after 126 ns;
		
		uc_wakeup <= '0' after 6 ns;
			
		wait for 2000 us;
		
		uc_wakeup <= '1';
		wait until falling_edge(Status_flag);
		
		uc_wakeup <= '0';
		uC_status <= '0';
		
		wait;
	end process;
	newData_process :process
	begin
		
		if (uC_addressingData = '1') then
			uC_commandReady <= '1';
			wait for sysclk_period*4;
			uC_commandReady <= '0';
			wait for sysclk_period*4;
		else
			uC_commandReady <= '0';
			wait until rising_edge(ucSetNewCommand);
			uC_commandReady <= '1' after 6ns; 
			wait until falling_edge(ucSetNewCommand);
			uC_commandReady <= '0' after 8ns;
			wait;
		end if;
		
	end process;
	
	din_process :process
	begin
		--wait for 7us;
		if (uC_addressingData = '1') then
			uC_commandType <= '0';
			wait for sysclk_period*3;
			uC_commandType <= '1';
			wait for sysclk_period*3;
		else
			uC_commandType <= '0';
			wait until rising_edge(ucSetNewCommand);
			uC_commandType <= R2SINK;
			wait;
		end if;
	end process;
	msgRX : PROCESS
	BEGIN
		if (uC_addressingData = '0' and RXstart = '1')  then

			wait for 113us;
			--1- Wu-bit
			RX <= '1';
			wait for 45us;
			RX <= '0';
			wait for 50us;
		 
			--command- Command Bit (r2SINK--> 0 rRouteNWK --> 1)
			RX <= Command2Send;
			wait for 50us;
			RX <= not Command2Send;
			wait for 55us;
			 
			--1 (Address = R2SINKADDRESS)
			RX <= R2SINKADDRESS(15);
			wait for 50us;
			RX <= not R2SINKADDRESS(15);
			wait for 50us;
			
			--0-
			RX <= R2SINKADDRESS(14);
			wait for 50us;
			RX <= not R2SINKADDRESS(14);
			wait for 50us;
			
			--1-
			RX <= R2SINKADDRESS(13);
			wait for 50us;
			RX <= not R2SINKADDRESS(13);
			wait for 50us;

			RX <= R2SINKADDRESS(12);
			wait for 50us;
			RX <= not R2SINKADDRESS(12);
			wait for 50us;

			RX <= R2SINKADDRESS(11);
			wait for 50.5us;
			RX <= not R2SINKADDRESS(11);
			wait for 46.5us;

			RX <= R2SINKADDRESS(10);
			wait for 50us;
			RX <= not R2SINKADDRESS(10);
			wait for 50us;

			RX <= R2SINKADDRESS(9);
			wait for 50us;
			RX <= not R2SINKADDRESS(9);
			wait for 50us;

			RX <= R2SINKADDRESS(8);
			wait for 50us;
			RX <= not R2SINKADDRESS(8);
			wait for 50us;

			RX <= R2SINKADDRESS(7);
			wait for 50us;
			RX <= not R2SINKADDRESS(7);
			wait for 50us;

			RX <= R2SINKADDRESS(6);
			wait for 50us;
			RX <= not R2SINKADDRESS(6);
			wait for 50us;

			RX <= R2SINKADDRESS(5);
			wait for 50us;
			RX <= not R2SINKADDRESS(5);
			wait for 45us;

			RX <= R2SINKADDRESS(4);
			wait for 50us;
			RX <= not R2SINKADDRESS(4);
			wait for 50us;
			
			RX <= R2SINKADDRESS(3);
			wait for 50us;
			RX <= not R2SINKADDRESS(3);
			wait for 50us;
			
			RX <= R2SINKADDRESS(2);
			wait for 50us;
			RX <= not R2SINKADDRESS(2);
			wait for 50us;
			
			RX <= R2SINKADDRESS(1);
			wait for 50us;
			RX <= not R2SINKADDRESS(1);
			wait for 50us;
			
			--addressLastBit-
			RX <= R2SINKADDRESS(0);
			wait for 50us;
			RX <= not R2SINKADDRESS(0);
			wait for 50us;
			
			RX <= '0';
			
			wait;
		end if;
		
		wait for SYSCLK_PERIOD*3;
	end process;
	
end preSynth;

