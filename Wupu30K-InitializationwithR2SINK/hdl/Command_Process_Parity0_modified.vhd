-- Command_Process.vhd
-- This is a sample state-machine using enumerated types.
-- This will allow the synthesis tool to select the appropriate
-- encoding style and will make the code more readable.
 
--Insert the following in the architecture before the begin keyword
   --Use descriptive names for the states, like st1_reset, st2_search
library ieee ;
use ieee.std_logic_1164.all ;

--library wupu_lib;
--use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;



entity command_process is

port (

	nodeAddress : in std_logic_vector (ADDRESSLENGTH-1 downto 0); -- network adress del SINK
	din : in std_logic ; -- din <=> dout Manchester decoder
	newData : in std_logic; -- newData <=> newData MancheterDecoder señal q dura un periodo de reloj cuando hay un dato nuevo
	dataClean : in std_logic;
	bitError : in std_logic;
	--endOfMessage : out std_logic; -- Fin de mensaje, sea o no el destinatario, endOfMessage <=> [] manchesterDecoder od frequency divider
	newMsg : out std_logic; -- nuevo mensaje recibido, newMsg <=> newMsg MoM unit 
	msgType : out std_logic_vector (1 downto 0);
	set_newMessage_flag : out std_logic; 
	clk: in std_logic;
	rstn: in std_logic;	--, enable : in std_logic; 
	AddOKflag : out std_logic; -- Candidata a ser eliminada
	Parity : out std_logic; -- Candidata a ser eliminada
    d_hk : out std_logic

);
end command_process ;

architecture RTL of command_process  is

type state_type is (NoData, first_header, second_header, third_header, last_header,
							first_command, second_command, third_command, full_command, addressing); 
							--first_shortcommand, second_shortCommand, third_shortCommand, full_shortCommand, first_R2SINK, second_R2SINK, third_R2,full_R2SINK );

signal state, next_state : state_type; 

signal data_In : std_logic;
-- 13
signal addOK : std_logic;
signal addOK_reg : std_logic;
-- signal header : std_logic_vector (3 downto 0);
signal commandRX : std_logic_vector (3 downto 0);
signal addressRX : std_logic_vector (ADDRESSLENGTH-1 downto 0);
--signal startSymbol : std_logic_vector (1 downto 0);

signal commProc_busy : std_logic;

-- signal shortMsgFlag : std_logic;
signal bitCounter : integer range 0 to ADDRESSLENGTH;
--signal EoM : std_logic;

signal command_complete : std_logic;
signal set_newMessage : std_logic;
signal reg_set_newMessage: std_logic;

signal short_command : std_logic;
signal long_command : std_logic;
signal command_error: std_logic;

signal reg_short_command : std_logic;
signal reg_long_command : std_logic;
signal reg_command_error: std_logic;

signal commandReg_enable : std_logic;
signal addresReg_enable : std_logic;
signal address_end : std_logic;

--signal dataEnable : std_logic;
signal newMessage : std_logic;


signal ParityRX : std_logic;
signal ParityOK : std_logic;
signal ParityEnabled : std_logic;
begin


--shortMsgFlag <= commandRx;     
data_In <= din;
--clean_busy <= (set_newComand and EoM) ; --or process_complete;
--busy <= commProc_busy;
set_newMessage_flag	<= reg_set_newMessage;
newMsg <= newMessage; -- and  ParityOK;

--dataEnable <= newData and ((not newMessage) and (not bitError)) ;

d_hk <= (commProc_busy nor newMessage) ;
--endOfMessage <= EoM;

--AddOKflag <= addOK_reg;
Parity <= (parityRX);
ParityOK <= (parityRX);-- xnor data_In;
--set_newCommand <= short_command or addOK_reg;
	
	short_command <= '1' when commandRX = "1001" else
					 --'1' when commandRX = "1100" else
					 '0';
	
	long_command <= '1' when commandRX = "1100" else
					'0';
	
	command_error <= (not short_command) and (not long_command);
	
	command_flags_gen: process (clk,rstn)
	begin
	if rstn = '0' then
		reg_short_command <= '0';
		reg_long_command <= '0';
		reg_command_error <= '0';
	elsif clk'event and clk = '1' then
		if command_complete = '1' then
			reg_short_command <= short_command;
			reg_long_command <= long_command;
			reg_command_error <= command_error;
		elsif dataClean = '1' then
			reg_short_command <= '0';
			reg_long_command <= '0';
			reg_command_error <= '0';
		end if;
	end if;
    end process;
	
	
	Delay_set_newMessage: process (clk, rstn)
	begin
		if rstn = '0' then
			reg_set_newMessage <= '0';
		elsif clk'event and clk = '1' then
			reg_set_newMessage <= set_newMessage;
		end if;
	end process;
	
	new_msg_generator: process (clk,rstn)
	begin
	if rstn = '0' then
		newMessage <= '0';
		msgType<= (others => '0');
		AddOKflag <= '0';
	elsif clk'event and clk = '1' then
		if dataClean = '1' then
			newMessage <= '0';
			msgType<= (others => '0');
			AddOKflag <= '0';
		elsif reg_set_newMessage = '1' and ParityOK = '1' and newMessage = '0' then
			newMessage <= '1';
			msgType<=commandRX (1 downto 0);
			AddOKflag <= AddOK_reg;
		end if;
	end if;
    end process;
	
	
	
 
	PARITY_BIT_COUNTER: process (clk, rstn)
	begin
		if rstn = '0' then
			ParityRX<= '1'; 
		elsif clk'event and clk = '1' then
			if dataClean = '1' or commProc_busy = '0' then --  bitError = '1' or
				ParityRX <= '1';
			elsif ParityEnabled = '1' and newData = '1' and  din = '0' then
				ParityRX <= not ParityRX;
			end if;
		end if;
	end process;
	
	
	
	
	
	
	SYNC_PROC: process (rstn, clk)
	begin
		if (rstn = '0') then
			state <= NoData;
		elsif (clk'event and clk = '1') then
			state <= next_state; 
		end if;
	end process;
	
	NEXT_STATE_DECODE: process (state, din, newData, bitError, address_End, reg_long_command)
	begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
		case (state) is
			when NoData =>
				--if newMessage = '1' or bitError = '1'then
				if bitError = '1' then
					next_state <= NoData;
				elsif  din = HEADERBIT and newData = '1' then
					next_state <= first_header;
				elsif  din = not HEADERBIT and newData = '1' then
					next_state <= noData;
				end if;
			when first_header =>
				if bitError = '1' then
					next_state <= NoData;
				elsif  din = HEADERBIT and newData = '1' then
					next_state <= second_header;
				elsif  din = not HEADERBIT and newData = '1' then
					next_state <= noData;
				end if;
			when second_header =>
				if bitError = '1' then
					next_state <= noData;
				elsif  din = HEADERBIT and newData = '1' then
					next_state <= third_header;
				elsif  din = not HEADERBIT and newData = '1' then
					next_state <= noData;
				end if;

			when third_header =>
				if bitError = '1' then
					next_state <= noData;
				elsif  din = HEADERBIT and newData = '1' then
					next_state <= last_header;
				elsif  din = not HEADERBIT and newData = '1' then
					next_state <= noData;
				end if;				
				
			
			when last_header =>
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1' and din = not HEADERBIT then -- hasta que no hay una transicion de 0 a 1 (si header es "0000") no salgo del header intento recuperar la sincronizacion
					next_state <= first_command;
				end if;
				
			when first_command => 
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1'  then
					next_state <= second_command;
				end if;
			
			when second_command => 
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1'  then
					next_state <= third_command;
				end if;
			
			when third_command => 
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1'  then
					next_state <= full_command;
				end if;
			
			when full_command => 
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1' and reg_long_command = '0' then
					next_state <= NoData;
				elsif newData = '1' and  reg_long_command = '1' then
					next_state <= addressing;
				end if;
			
			when addressing => 
				if bitError = '1' then
					next_state <= NoData;
				elsif newData = '1' and  address_End = '1' then
					next_state <= NoData;
				end if;
			

		end case;      
	end process;
   
   --MEALY State-Machine - Outputs based on state and inputs
   
	OUTPUT_DECODE: process (state, newData, din, biterror, reg_short_command, reg_long_command, reg_command_error, address_End)
	begin
		if state =  NoData then
			if newData = '1' and  din = HEADERBIT then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0';
				 
			elsif bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0';
			else 
				commProc_busy <= '0';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			end if;
		
		elsif state = first_header then
			if newData = '1' and  din = not HEADERBIT then
				commProc_busy <= '0';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0';
				
			elsif bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			else
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0';
				set_newMessage <= '0';				
				ParityEnabled <= '0'; 
			end if;
			
		elsif state = second_header then
			if newData = '1' and  din = not HEADERBIT then
				commProc_busy <= '0';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
				
			elsif bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			else
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0';
				set_newMessage <= '0';				
				ParityEnabled <= '0'; 
			end if;
		
		elsif state = third_header then
			if newData = '1' and  din = not HEADERBIT then
				commProc_busy <= '0';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
				
			elsif bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			else
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			end if;
		
		elsif state = last_header then
			if newData = '1' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '1';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
			
			elsif bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			else
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
			end if;
			
		elsif state = first_command then
			if bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			
			elsif newData = '1' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '1';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 

			else 
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
			end if;
			
		elsif state = second_command then
			if bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			
			elsif newData = '1' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '1';
				addresReg_enable <= '0';
				command_complete <= '0';
				set_newMessage <= '0';				
				ParityEnabled <= '1'; 

			else 
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
			end if;
			
		elsif state = third_command then
			if bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
			
			elsif newData = '1' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '1';
				addresReg_enable <= '0';
				command_complete <= '1'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 

			else 
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
			end if;
		
		elsif state = full_command then
			if bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0'; 
				
			elsif newData = '1' and reg_short_command = '1' then
				commProc_busy <= '1';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '1';
				ParityEnabled <= '1';
			
			elsif newData = '1' and reg_long_command = '1' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '1';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1';
			
			elsif newData = '1' and reg_command_error = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1';
				
			else 
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1'; 
				
			end if;
		
		elsif state = addressing then
			if bitError = '1' then
				commProc_busy <= '0';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '0';
				
			elsif newData = '1' and  address_End = '1' then
				commProc_busy <= '1';
				 -- EoM <= '1';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '1';
				ParityEnabled <= '1';
			
			elsif newData = '1' and  address_End = '0' then
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '1';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1';
				
			else 
				commProc_busy <= '1';
				 -- EoM <= '0';
				commandReg_enable <= '0';
				addresReg_enable <= '0';
				command_complete <= '0'; 
				set_newMessage <= '0';
				ParityEnabled <= '1';
				
			end if;
		
		-- else 
				-- commProc_busy <= '1';
				-- EoM <= '0';
				-- commandReg_enable <= '0';
				-- addresReg_enable <= '0';
				-- command_complete <= '0'; 
				 
			-- end if;
		end if;
	
	end process;

	address_end <= '1' when bitCounter = ADDRESSLENGTH else '0';
	
	bit_accu: process (clk,rstn)
	begin
	 if rstn = '0' then
		bitCounter <= 0;
	elsif clk'event and clk = '1' then
		if commProc_busy= '0' then --dataClean = '1' or bitError = '1' or long_newCommand = '1'then
			bitCounter <= 0;
		elsif addresReg_enable = '1' then
			if bitCounter = ADDRESSLENGTH then
				bitCounter <= 0;
			else
				bitCounter <= bitCounter + 1;
			end if;
		end if;
	end if;
    end process;
	
	Store_command: process (clk,rstn)
	begin
	if rstn = '0' then
		commandRX <= "0000";
	elsif clk'event and clk = '0' then
		if dataClean = '1' or bitError = '1' then
			commandRX <= "0000";
		elsif commandReg_enable = '1' then
			commandRX <= commandRX (2 downto 0) & data_In;
		end if;
	end if;
    end process;
	
	Store_address: process (clk,rstn)
	begin
	if rstn = '0' then
		addressRX <= (others => '0');
	elsif clk'event and clk = '0' then
		if dataClean = '1' or bitError = '1'then
			addressRX <= (others => '0');
		elsif addresReg_enable = '1' then
			addressRX <= addressRX(ADDRESSLENGTH-2 downto 0) & data_In;
		end if;
	end if;
    end process;
	
	addOK <= '1' when addressRX = nodeAddress else '0';
	Check_address: process(clk, rstn) 
	begin
	if rstn = '0' then
		addOK_reg <= '0';
	elsif clk'event and clk = '1' then
		if address_end = '1' then
			addOK_reg <= addOK;
		end if;
	end if;
	end process;
	
	
end;