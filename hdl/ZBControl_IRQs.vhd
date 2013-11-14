-- ZBControl.vhd
library ieee ;
use ieee.std_logic_1164.all ;

--use work.ASCII_Char.all;

entity ZBControl is

port (
  
	commandType2uC: IN  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute (1) o un R2SINK_ACK (0)
    commandReady2uC : IN std_logic; 
	ZB_active : OUT std_logic; -- el microcontrolador esta despierto

	IRQ0 : OUT std_logic; -- Señal q va a IRQ 0 a actival el modulo ZB
	IRQ1 : OUT std_logic; -- Señal q va a IRQ 1 a desactiva el modulo ZB
	IRQ2 : OUT std_logic; -- Señal q va a IRQ 2 a pone las señales R2SINKTimeout and R2SINKTimeout a '0'
	IRQ3 : OUT std_logic; -- Señal q va a IRQ 3 a StartTimers
	WD_IRQ : IN std_logic;
	WD_CLR : OUT std_logic;
 	
	R2SINKTimeout : IN std_logic;
	NWKrRouteTimeout : IN std_logic;
	clk			: in std_logic;
	rstn			: in std_logic;
	d_hk		: out std_logic
);
end ZBControl;

architecture symplified of ZBControl is
-- constant ats_command_size : integer := 12;
-- constant atMSG : integer := 16;
-- type my_msg_string is array (NATURAL  range <>) of my_char_type;
	-- subtype my_atjpan is my_msg_string (16 downto 0);
	-- subtype my_atdassl is my_msg_string (9 downto 0);
	-- subtype my_ats_command is my_msg_string (ats_command_size-1 downto 0);
	
-- constant ats39_msg : my_ats_command := (a,t,s,c_3,c_9,c_eq,c_0,c_0,c_0,c_3,c_CR,c_NULL);
-- constant atdassl_msg : my_atdassl := (a,t,c_adds,d,a,s,s,l,C_CR,c_NULL);
-- constant atjpan_msg : my_atjpan := (a,t,c_adds,j,p,a,n,c_colon,c_1,c_5,c_coma,c_6,c_6,c_6,c_6,c_CR,c_NULL);

--signal ZB_Activate :  std_logic; -- Señal q va a IRQ 0 a actival el modulo ZB --> PWMOD = 3
--signal	ZB_Sleep :  std_logic; -- Señal q va a IRQ 1 --> PWMOD = 3
signal	IOtoLow :  std_logic; -- Señal q va a IRQ 2 a bja los flagas de los timers de timeout
signal	StartTimers : std_logic; -- Señal q va a IRQ 3 inicia los timers de Msgtimeout
signal commandTypeIN : std_logic;
signal commandReadyIN : std_logic;

signal ZBcontrolActive : std_logic;
signal LoadNWKmsg : std_logic; 
signal SleepZB: std_logic;
signal ActivateZB : std_logic;
signal ZBTimeout : std_logic;

type state_type is (RadioOff, RadioOn, ResetFlags, Inic0); --, ZB_Booted); --WaitingPMODChange);--, R2SACK, NWKreRoute);
signal state, next_state : state_type;


begin


	IRQ0 <= ActivateZB ; -- Señal q va a IRQ 0 
	IRQ1 <=SleepZB ; -- Señal q va a IRQ 1 
	IRQ2 <=IOtoLow ; -- Señal q va a IRQ 2 
	IRQ3 <=StartTimers;
	
	
	-- ZB_Activate <= ActivateZB;
	-- ZB_Sleep <= SleepZB;
	
	ZBTimeout <= NWKrRouteTimeout when commandTypeIN = '1' else R2SINKTimeout; 
	
	ZB_active <= ZBcontrolActive; -- el microcontrolador esta despierto	
	
	--ActivateZBControl <= activate_uC;
	
	commandReadyIN <= commandReady2uC; --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute (1) o un R2SINK_ACK (0)
	
	--uC_ACK <= -- ZBcontrolACK;
	
	
	Comand_Reg: process (rstn, clk)
	begin
		if (rstn = '0') then
			commandTypeIN <= '1'; -- lo inicializo a 1 para que al principio est 10 segundos encendido
		elsif (clk'event and clk = '1') then
			if commandReadyIN = '1' then
				commandTypeIN  <= commandType2uC;
			end if;	
		
		end if;
	end process;
	
	SYNC_PROC: process (rstn, clk)
	begin
		if (rstn = '0') then
			--state <= Inic0;
			state <= RadioOff;
		elsif (clk'event and clk = '1') then
			
			state <= next_state;
		end if;
	end process;
	
	
	d_HK <= not ZBcontrolActive;
	
	NEXT_STATE_DECODE: process (state, ZBTimeout, commandReadyIN, R2SINKTimeout, NWKrRouteTimeout, WD_IRQ )
	begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
		case (state) is
		
			when RadioOff =>
				
				if commandReadyIN = '1' then
					next_state <= RadioOn;
				end if;
			
			when RadioOn =>
				
				if ZBTimeout = '1' then 
					next_state <= ResetFlags;
				elsif WD_IRQ = '1' then
					next_state <= ResetFlags;
				end if;
			
			when ResetFlags =>
				
				if R2SINKTimeout = '0' and NWKrRouteTimeout = '0' then -- cuando recivo PMOD = 3 por el pto serie es q esta durmiendo 
					next_state <= RadioOff;
				end if;
						
			when Inic0 =>
				
				if ZBTimeout = '1' then -- cuando recivo PMOD = 3 por el pto serie es q esta durmiendo 
					next_state <= ResetFlags;
				end if;
				

		end case;      
	end process;
	
	
	OUTPUT_DECODE: process (state, rstn, ZBTimeout, commandReadyIN, commandType2uC, R2SINKTimeout, NWKrRouteTimeout )
	begin
      --declare default state for next_state to avoid latches
       --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
		if state = RadioOff then
			if commandReadyIN = '1'  then
				  
				WD_CLR <= '1';
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '1';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '1';
			
			else
				WD_CLR <= '0'; 
				ActivateZB <= '0'; 
				SleepZB <= '1';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '0';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
				 
			
			end if;
		
		elsif state = RadioOn then
			
			if ZBTimeout = '1'  then
				WD_CLR <= '0';  
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
				 
			
			elsif commandReadyIN = '1' and commandType2uC = '1' then			 
				WD_CLR <= '0';  
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '1';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '1';
			
				
			else
				WD_CLR <= '0';  
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '1';
			 
			end if;
		
		elsif state = ResetFlags then
						
			if R2SINKTimeout = '0' and NWKrRouteTimeout = '0' then
				WD_CLR <= '1';  
				ActivateZB <= '0'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '0';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
				
			else
				WD_CLR <= '1';  
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '1';
				IOtoLow <= '1'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
			 
			end if;

		elsif state = Inic0 then  
			
			if  rstn = '0' then
		 		WD_CLR <= '0';  
				ActivateZB <= '0'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
			
			else
				WD_CLR <= '0';  
				ActivateZB <= '1'; 
				SleepZB <= '0';
				LoadNWKmsg <= '0';
				-- ZBcontrolACK <= '0';
				ZBcontrolActive <= '1';
				IOtoLow <= '0'; -- Señal q va a IRQ 2 
				StartTimers <= '0';
			end if;
		
			
		else
			WD_CLR <= '0';  
			ActivateZB <= '1'; 
			SleepZB <= '0';
			LoadNWKmsg <= '0';
			-- ZBcontrolACK <= '0';
			ZBcontrolActive <= '1';
			IOtoLow <= '0'; -- Señal q va a IRQ 2 
			StartTimers <= '0';
		 
		end if;
		  
	end process;
	
end ;