----------------------------------------------------------------------
-- Created by Actel SmartDesign Wed Jun 20 11:49:56 2012
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TB_global is
end TB_global;

architecture global of TB_global is


	constant R2SINKADDRESS_1_PAR : std_logic_vector (16 downto 0) := "00000011000000000";
	constant R2SINKADDRESS_0_PAR : std_logic_vector (16 downto 0) := "11100010100011111";
		
	constant HALFBIT : time := 26 us; 
	constant HALFBIT_L : time := 35 us; 
	constant HALFBIT_S : time := 20 us; 
	
	constant R2SINK : std_logic_vector := "00";
    constant rRouteNWK : std_logic_vector := "10";
	constant R2SACK : std_logic_vector := "11";
	constant Header : std_logic_vector := "1111";
	constant Preamble : std_logic_vector := "1010101010101010";
	
	constant errorRX : std_logic := '0';
	constant ShortMessage : std_logic := '0';
	constant LongMessage : std_logic := '1';
	constant SYSCLK_PERIOD : time :=  90.42 ns;--20.83ns;--90.42ns; 11.0592 MHz
	
	signal R2SINKandParity : std_logic_vector (16 downto 0) := "00000000000000000";
    
	signal TestMsgTypeBit : std_logic := ShortMessage;
	

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

	signal MSG : std_logic_vector (38 downto 0) := (others => '0');    

	signal uC_commandType : std_logic := '0';
	signal uC_commandReady : std_logic := '0';
	signal uC_ACK : std_logic := '0';
	signal rst : std_logic := '0';

	signal addOk : std_logic := '0';
	signal eos : integer := 0;
	signal shortMsg : integer := 0;

	signal microCommand:std_logic := '0';

	SIGNAL	MoMstateLed :  std_logic_vector (2 downto 0) := "000";
	SIGNAL	command :  std_logic_vector (1 downto 0) := "00";

    component WuPu
        -- ports
        port( 
            -- Inputs
            Wakeup : in std_logic;
            clk : in std_logic;
            RX : in std_logic;
            uC_commandType : in std_logic;
            uCstatus : in std_logic;
            ACK : in std_logic;
            uC_commandReady : in std_logic;
            RST : in std_logic;
            Sel_address : in std_logic_vector(1 downto 0);

            -- Outputs
            TX : out std_logic;
            ActivateuC : out std_logic;
            CommandType2uC : out std_logic;
            CommandReady2uC : out std_logic;
            RFSwitch : out std_logic;
            WupuFull : out std_logic;
            Status_flag : out std_logic;
            addOK : out std_logic;
            TXMODE : out std_logic;
            MoMstateLed : out std_logic_vector(2 downto 0)
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

    -- 11.0592 MHz Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  WuPu
	
	wakeup <= (RX_wakeup and RFSwitch) or uC_wakeup;
    RX_wakeup <= RX;
	
	WuPu_0 : WuPu
        -- port map
        port map( 
            -- Inputs
            Wakeup => wakeup,
            clk => SYSCLK,
            RX => RX,
            uC_commandType => uC_commandType,
            uCstatus => uC_status,
            ACK => uC_ACK,
            uC_commandReady => uC_commandReady,
            RST => NSYSRESET,
            Sel_address => "01",

            -- Outputs
            TX =>  TX,
            ActivateuC =>  ActivateuC,
            CommandType2uC =>  CommandType2uC,
            CommandReady2uC =>  CommandReady2uC,
            RFSwitch =>  RFSwitch,
            WupuFull =>  WupuFull,
            Status_flag =>  Status_flag,
            addOK =>  open,
            TXMODE =>  open,
            MoMstateLed => MoMstateLed

            -- Inouts

        );
	
	ucCommand_ready_proc :process
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
				uC_status <= '0';
			
			elsif commandType2uc = '0' then
				wait for 300 ns;
				uc_ACK <= '1';
				wait for 300 ns;
				uc_ACK <= '0';
				wait for 3 ms;
				uC_wakeup <= '1'; 
				wait until Status_flag = '1';
				uC_wakeup <= '0'; 
				uC_status <= '0';
			end if;
			
		elsif MoMstateLed = "100" then -- rRoutingNWK
			
			wait for 300 ns;
				uc_ACK <= '1';
				wait for 300 ns;
				uc_ACK <= '0';
				wait for 10 ms;
				uC_wakeup <= '1'; 
				wait until Status_flag = '1';
				uC_status <= '0';
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
			uC_status <= '0';
		end if;
	end process;
	

	msgRX : PROCESS
	BEGIN

		if (eos = 0) then
						
			wait for ( SYSCLK_PERIOD * 10 );
			RX <= '0';
			RXstart <= '1';
			--uC_addressingData <= '0';
			
			wait for 113us;
			assert eos = 0
			report "Mensaje recibido parcialmente"
			severity NOTE;
			
			RX <= '1';
			wait for HALFBIT;
			RX <= '0';
			wait for HALFBIT;
			Partial_MSG: for i in 0 to 6 loop
			
				RX <= '0';
				wait for HALFBIT;
				RX <= '1';
				wait for HALFBIT;
			
			end loop;
			RX <= '0';
			
			eos <= 1;
			
			assert eos = 1
			report "fin recepcion parcial"
			severity NOTE;
			wait for 1500us;
				
		elsif (RXstart = '1' and eos < 5)  then

			if (eos = 1) then
				R2SINKandParity <=  R2SINKADDRESS_0_PAR;
				command <= "00";
				MSG <= PREAMBLE & HEADER & command & R2SINKADDRESS_0_PAR ;				
				assert eos = 1
				report " R2SINK con direccion incorrecta "
				severity NOTE;
			
			elsif (eos = 2) then
				R2SINKandParity <=  R2SINKADDRESS_1_PAR;
				command <= "00";
				MSG <= PREAMBLE & HEADER & command & R2SINKADDRESS_1_PAR ;
				assert eos = 2
				report " R2SINK con direccion correcta "
				severity NOTE;
			
			elsif (eos = 3) then
				wait until MoMStateLed = "000";
				wait for 2354 us;
				shortMsg <= 1;
				command <= "11";
				MSG <= PREAMBLE & HEADER & "11" & R2SINKandParity ;
				assert shortMsg = 1
				report " R2SACK "
				severity NOTE;
			
			elsif (eos = 4) then
				wait until MoMStateLed = "111"; -- MoM_AWAKE
				microcommand <= '1';
				wait until MoMStateLed = "011"; -- R2SINK 11st
				microcommand <= '0';
			end if;
			
			  
			
			wait for 113us;
			RX <= '0';
			
			wait for 113us;
			
			Preamble_Header_command : for i in  0 to 21 loop
				RX <= MSG (38-i);
				wait for HALFBIT;
				RX <= not MSG (38-i);	
				wait for HALFBIT;			
			end loop;
						
			if shortMSG = 0 then
			--1 (Address = R2SINKADDRESS)
				Address_loop : for i in  22 to 38 loop
					RX <= MSG (38-i);
					wait for HALFBIT;
					RX <= not MSG (38-i);	
					wait for HALFBIT;			
				end loop;
			
			else --si en vio short message en bit de paridad es el not (LSB command)  
				RX <= not command(0);
				wait for HALFBIT;
				RX <= command (0);	
				wait for HALFBIT;
			
			end if;
			
			RX <= '0';
			
			eos <= eos + 1;
			
			wait for 1500us;
		end if;
		
		wait for 50us;
	end process;
	
end global;

