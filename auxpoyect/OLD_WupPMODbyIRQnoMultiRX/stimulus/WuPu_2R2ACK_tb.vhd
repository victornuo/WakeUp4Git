----------------------------------------------------------------------
-- Created by Actel SmartDesign Thu Sep 08 16:04:00 2011
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library igloo;
use igloo.all;

entity wupu_testbench is
end wupu_testbench;

architecture behavioral of wupu_testbench is

    constant R2SINKADDRESS_1 : std_logic_vector (15 downto 0) := "0000001100001111";
	constant R2SINKADDRESS_0 : std_logic_vector (15 downto 0) := "1110001010001111";
	
		
	constant SYSCLK_PERIOD : time :=  90.42ns;--20.83ns;--90.42ns; 11.0592 MHz
	
	constant HALFBIT : time := 300us; 
	constant HALFBIT_L : time := 340us; 
	constant HALFBIT_S : time := 265us; 
	
	constant R2SINK : std_logic := '0';
    constant rRouteNWK : std_logic := '1';
	constant errorRX : std_logic := '0';
	
	signal R2SINKADDRESS : std_logic_vector (15 downto 0) := "0000000000000000";
    signal TestMsgTypeBit : std_logic := R2SINK ;
	signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
	
	signal RXstart : std_logic := '1';
	signal ucSetNewCommand : std_logic := '0';
	
	signal wakeup : std_logic := '0';
	signal RX_wakeup : std_logic := '0';
	signal uC_wakeup : std_logic := '0';
	signal uC_status : std_logic := '0';
	signal RX : std_logic := '0';
	signal TX : std_logic := '0';
	
	signal ActivateuC : std_logic := '0' ;
    signal CommandType2uC : std_logic := '0';
    signal CommandReady2uC : std_logic := '0';
    signal RFSwitch : std_logic := '0';
    signal WupuFull : std_logic := '0';
    signal Status_flag : std_logic := '0';
   

   signal uC_commandType : std_logic := '0';
   signal uC_commandReady : std_logic := '0';
   signal uC_addressingData : std_logic := '0';
   signal uC_ACK : std_logic := '0';
   signal rst : std_logic := '0';
   
   signal addOk : std_logic := '0';
   signal eos : integer := 4;
   signal shortMsg : integer := 0;
	
   signal microCommand:std_logic := '0';
   
   signal secondR2SACK :std_logic := '0';
   
   
   SIGNAL	MoMstateLed :  std_logic_vector (2 downto 0) := "000";
   SIGNAL	command :  std_logic_vector (1 downto 0) := "00";

    component WuPu
        -- ports
        port( 

            Wakeup : in std_logic;
            clk : in std_logic;
            RX : in std_logic;
            --MoM_enable : in std_logic;
            uC_commandType : in std_logic;
            uCstatus : in std_logic;
            ACK : in std_logic;
            uC_commandReady : in std_logic;
            RST : in std_logic;
            Sel_address : in std_logic_vector(1 downto 0);
            TX : out std_logic;
            ActivateuC : out std_logic;
            CommandType2uC : out std_logic;
            CommandReady2uC : out std_logic;
            RFSwitch : out std_logic;
            WupuFull : out std_logic;
            Status_flag : out std_logic;
            MoMstateLed : out std_logic_vector(2 downto 0);
            addOK : out std_logic


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
	RX_wakeup <= RX;
	wakeup <= (RX_wakeup and not RFSwitch) or uC_wakeup;
   
   -- Instantiate Unit Under Test:  WuPu
    R2SACK: WuPu port map( 
		-- Inputs
		Wakeup => wakeup,
		rst => NSYSRESET,
		clk => SYSCLK,
		RX => RX,
		uC_commandType => uC_commandType,
		uC_commandReady => uC_commandReady,
		uCstatus => uC_status,
		ACK => uC_ACK,
		Sel_address => "01",
		--MoM_enable => '1',
		
		-- Outputs
		TX =>  TX,
		ActivateuC =>  ActivateuC,
		CommandType2uC =>  CommandType2uC,
		CommandReady2uC =>  CommandReady2uC,
		RFSwitch =>  RFSwitch,
		WupuFull =>  WupuFull,
		Status_flag =>  Status_flag,
		MoMstateLed => MoMstateLed
	);
	

   ucCommand_ready_prco :process
   begin
	
	wait until microCommand = '1';
	uC_commandReady <= '1'; 
	uC_commandType  <= '0'; 
	wait until WupuFull = '1';
	wait for 31us;
	uC_commandReady <= '0'; 
	wait;
   end process;
 
   -- Stimulus process
   
	uC_signal_control : process
	begin
		wait until rising_edge( ActivateuC) or MoMstateLed = "100" or microcommand = '1';
		wait for 6 us;
		uC_status <= '1';
		if commandReady2uC = '1' then
			if commandType2uc = '1' then
				wait for 300 ns;
				uc_ACK <= '1';
				wait for 300 ns;
				uc_ACK <= '0';
				wait for 10 ms;
				--uC_status <= '0';
			
			elsif commandType2uc = '0' then
				uC_status <= '1';
				wait until secondR2SACK = '1';
				wait for 1.8 ms;
				uc_ACK <= '1';
				wait for 300 ns;
				uc_ACK <= '0';
				wait for 3 ms;
				uC_wakeup <= '1'; 
				wait until Status_flag = '1';
				uC_wakeup <= '0'; 
				uC_status <= '0';
			end if;
			
		elsif MoMstateLed = "100" then
			
			wait for 300 ns;
				uc_ACK <= '1';
				wait for 300 ns;
				uc_ACK <= '0';
				wait for 10 ms;
				uC_wakeup <= '1'; 
				wait until Status_flag = '1';
				--uC_status <= '0';
				uC_wakeup <= '0'; 
		
		elsif microcommand = '1' then
			uC_status <= '1';
			uC_wakeup <= '1';
			assert uC_status = '1'
			report " Activomicrocontroller par R2SINK1st "
			severity NOTE;
			wait until MoMstateLed = "010" ;
			uC_wakeup <= '0';
			--uC_status <= '0';
			wait until MoMstateLed = "011";
		
		else
			wait for 1 ms;
			--uC_status <= '0';
		end if;
	end process;
	

	msgRX : PROCESS
	BEGIN

		if (eos = 0) then
			RXstart <= '0';
			RX <= '1';
			wait for ( SYSCLK_PERIOD * 10 );
			RX <= '0';
			RXstart <= '1';
			uC_addressingData <= '0';
			wait for 113us;
			assert eos = 0
			report "Mensaje recibido parcialmente"
			severity NOTE;
			RX <= '0';
			wait for HALFBIT;
			RX <= '1';
			wait for HALFBIT;
			
			RX <= '0';
			wait for HALFBIT;
			RX <= '1';
			wait for HALFBIT;
			
			--1-
			RX <= '1';
			wait for HALFBIT;
			RX <= '0';
			wait for HALFBIT;

			RX <= '1';
			wait for HALFBIT;
			RX <= '0';
			wait for HALFBIT;

			RX <= '0';
			wait for HALFBIT;
			RX <= '1';
			wait for HALFBIT;
			RX <= '0';
			eos <= 1;
			assert eos = 1
			report "fin recepcion parcial"
			severity NOTE;
			wait for 1500us;
			
			
		end if;
		
		if (uC_addressingData = '0' and RXstart = '1' and eos < 5)  then

			if (eos = 1) then
				R2SINKADDRESS <=  R2SINKADDRESS_0; 
				assert eos = 1
				report " R2SINK con direccion incorrecta "
				severity NOTE;
			elsif (eos = 2) then
				R2SINKADDRESS <=  R2SINKADDRESS_1;
				assert eos = 2
				report " R2SINK con direccion correcta "
				severity NOTE;
			elsif (eos = 3) then
				wait until MoMStateLed = "000";
				wait for 2354 us;
				shortMsg <= 1;
				command <= "11";
				assert shortMsg = 1
				report " R2SACK "
				severity NOTE;
			elsif (eos = 4) then
				shortMsg <= 1;
				command <= "11";
				wait until MoMStateLed = "111";
				microcommand <= '1';
				wait until MoMStateLed = "011";
				microcommand <= '0';
			end if;
			
			
			wait for 113us;
			  --1- Wu-bit
			RX <= '1';
			wait for HALFBIT/2;
			RX <= '0';
			wait for HALFBIT;
			RX <= '1';
			wait for HALFBIT/2;
		 
			--command- Command Bit (r2SINK--> 00 rRouteNWK --> 10)
			RX <= command(1);
			wait for HALFBIT;
			RX <= not command(1);
			wait for HALFBIT_L;
			RX <= command(0);
			wait for HALFBIT;
			RX <= not command(0);
			wait for HALFBIT_L;
			
			RX <= '0';
			wait for 113us;
			  --1- Wu-bit
			RX <= '1';
			wait for HALFBIT/2;
			RX <= '0';
			wait for HALFBIT;
			RX <= '1';
			wait for HALFBIT/2;
		 
			--command- Command Bit (r2SINK--> 00 rRouteNWK --> 10)
			RX <= command(1);
			wait for HALFBIT;
			RX <= not command(1);
			wait for HALFBIT_L;
			RX <= command(0);
			wait for HALFBIT;
			RX <= not command(0);
			wait for HALFBIT_L;
			
			secondR2SACK <= '1';
			
			wait;
			 
			if shortMSG = 0 then
			--1 (Address = R2SINKADDRESS)
			
			RX <= R2SINKADDRESS(15);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(15);
			wait for HALFBIT;
			
			--0-
			RX <= R2SINKADDRESS(14);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(14);
			wait for HALFBIT;
			
			--1-
			RX <= R2SINKADDRESS(13);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(13);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(12);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(12);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(11);
			wait for HALFBIT_L;
			RX <= not R2SINKADDRESS(11);
			wait for HALFBIT_S;

			RX <= R2SINKADDRESS(10);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(10);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(9);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(9);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(8);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(8);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(7);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(7);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(6);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(6);
			wait for HALFBIT;

			RX <= R2SINKADDRESS(5);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(5);
			wait for HALFBIT_S;

			RX <= R2SINKADDRESS(4);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(4);
			wait for HALFBIT;
			
			RX <= R2SINKADDRESS(3);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(3);
			wait for HALFBIT;
			
			RX <= R2SINKADDRESS(2);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(2);
			wait for HALFBIT;
			
			RX <= R2SINKADDRESS(1);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(1);
			wait for HALFBIT;
			
			--addressLastBit-
			RX <= R2SINKADDRESS(0);
			wait for HALFBIT;
			RX <= not R2SINKADDRESS(0);
			wait for HALFBIT;
			
			end if;
			
			RX <= '0';
			if eos = 2 then 
				wait for 100 us;
				RX <= '1';
				assert RX = '1'
				report " CSMA Busy"
				severity NOTE;
				wait for 500 us;
				RX <= '0';
			end if;
			eos <= eos + 1;
			
			wait for 1500us;
			

			end if;
		
		wait for 50us;
	end process;
	
end behavioral;

