-- Mom_unit.vhd
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
USE ieee.numeric_std.ALL;

-- library wupu_lib;
-- use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;
 
ENTITY MoM_unit is
    -- generic(DELAY : integer := 1023; -- 150us delay del receptor de Infrarrojos
			-- CCA : integer := 829*4;		); -- 300 us 
	PORT(
        RX_port : IN std_logic;
		RX_active : IN std_logic; -- bandera que indica que el receptor esta activo
		RX_commandType: IN  std_logic_vector (1 downto 0); --  generada por el command processor
        RX_commandReady : IN std_logic;
		
		uC_commandType: IN  std_logic; --  generada por el microcontroller (solo necesito un bit el msg 11 ACK solo lo envia la Wupu)
        uC_commandInput : IN std_logic; -- generada por el microcontroller
		uC_active : IN std_logic; -- el microcontrolador esta despierto
		activate_uC : OUT std_logic; -- despierto al uC
		
		TX_messageEnd: in std_logic; -- el encoder ha terminado el envio
		
		commandType2uC: OUT  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute o un R2SINK_ACK
        commandReady2uC : OUT std_logic; 
		uCcommandinQueue : OUT std_logic;  
		
		NodeAddress : IN std_logic_vector (ADDRESSLENGTH-1 downto 0);
		nextHopAddress : IN std_logic_vector(ADDRESSLENGTH-1 downto 0);
		 
		commandToEncoder : OUT  std_logic_vector (1 downto 0); -- dato que se le pasa a manchester encoder
		
		Enable_encoder : out std_logic; -- habilita en manchester encoder 
		RF_selector : out std_logic; --señal de seleccion para el RF switch 0 para RX_port y 1 para TX
		TX_load : out std_logic;	
		RX_processed : out std_logic;
		uC_ACK : in std_logic; -- señalq ue indica que el micro ha leido el comando que la MoM le quiere enviar.
		

		MoMState: out std_logic_vector (2 downto 0);
		
		-- UART Ctrl Signal
		-- DATA_TX : out std_logic_vector (7 downto 0);
		-- DATA_RX : in std_logic_vector (7 downto 0);
		-- WEN : BUFFER STD_LOGIC;
		-- OEN : OUT STD_LOGIC;
		-- TX_RDY : IN STD_LOGIC;
		-- RX_RDY : IN STD_LOGIC;
         
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
END MoM_unit;

ARCHITECTURE RTL of MoM_unit is

type state_type is (MoM_AWAKE, Sending_MSG, R2SINK_1st, R2SINK_received, R2SINK_ack, rRoutingNWK, Comm2uC, Contention);
signal state, next_state : state_type; 

signal TX_enable : std_logic;
signal iamtheSINK : std_logic;
signal SINKNeighbor : std_logic;
signal commandSource : std_logic;
signal uC_commandReady : std_logic;
signal clean_command : std_logic;
signal commandToSend : std_logic_vector (1 downto 0);
signal commandType : std_logic_vector (1 downto 0);
signal commandQueue : std_logic_vector (1 downto 0);
signal commandtoEncoder_int : std_logic_vector (1 downto 0);
signal command_In_Queue : std_logic;
signal command_Type_uC : std_logic;
signal commandQueue_flag : std_logic;



signal emptyRandom : std_logic;

signal uC_toInactive : std_logic;
signal uC_active_D0 : std_logic;
signal uC_active_D1 : std_logic;

signal reg_command_enab : std_logic;

signal msgtosendbitChange : std_logic;

signal ContentionEnab: std_logic;

signal awake_uC : std_logic;
signal delayed_TX : std_logic_vector (1 downto 0);
signal uC_ACK_reg : std_logic;

signal ContentionTimeExpired : std_logic; 
signal Contention_int : integer range 0 to 775; 
signal	ChannelFreeTime : std_logic; 
signal	ChannelFree : std_logic;
signal ContentionExpired :  std_logic;
-- constant R2SINK : std_logic_vector (1 downto 0) := "00";
-- constant NWKRroute : std_logic_vector (1 downto 0) := "10";
-- constant R2SACK : std_logic_vector (1 downto 0) := "11";

constant RX : std_logic := '1';
constant uC : std_logic := '0';

signal Mom_Free : std_logic;

signal backoff_Flag : std_logic;

begin



activate_uC <= awake_uC; 


process (clk, rst)
	begin
		if rst = '0' then
			uC_ACK_reg <= '0';
		elsif clk'event and clk = '1' then
			uC_ACK_reg <= uC_ACK; 
		end if;
	end process;

process (iamtheSINK, NodeAddress)
begin
	if NodeAddress = "0000000000000000" then
		iamtheSINK <= '1';
	else
		iamtheSINK <= '0';
	end if;
end process;

process (nextHopAddress, SINKNeighbor)
begin
	if nextHopAddress = "0000000000000000" then
		SINKNeighbor <= '1';
	else
		SINKNeighbor <= '0';
	end if;
end process;


commandtoEncoder <= commandtoEncoder_int;
Enable_encoder <= TX_enable;
commandType <= commandToSend;-- leo el comando de respuesta

RX_processed <= clean_command and  RX_commandReady;



d_hk <= Mom_Free;

--Detector de flanco de ucActive para saber que ya ha terminado y se va a dormir

uC_toInactive <=  ( uC_active_D1) and  (not uC_active_D0); 	
	process (clk, rst)
	begin
		if rst = '0' then
			uC_active_D0 <= '0';
			uC_active_D1 <= '0';
		elsif clk'event and clk = '0' then
			uC_active_D0 <= uC_active; 
			uC_active_D1 <= uC_active_D0;
		end if;
	end process;

	SYNC_PROC: process (rst, clk)
   begin
      if (rst = '0') then
         state <= MoM_AWAKE;
      elsif (clk'event and clk = '1') then
           state <= next_state;
      end if;
   end process;
 
  uC_commandReady <= uC_commandInput; --  and  (not uC_addressingData); -- solo se procesa el msg del micro si no estan llegando mensajes por la radio y los datos no son de direcciones
 -- shortMsgFlag <= not reg_comandToSend; 

	NEXT_STATE_DECODE: process (state, SINKNeighbor, uC_ACK_reg, commandSource, TX_enable , RX_port, TX_messageEnd, commandType, uC_toInactive, command_In_Queue, iamtheSink, command_Type_uC, ChannelFree)
	begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
        when MoM_AWAKE =>
			MoMState <= "111"; --esta en el proceso de asignacion de las salidas
			if command_In_Queue = '1' and iamtheSink = '0' then
				if commandSource = uC and  commandType = R2SINK and SINKNeighbor = '1' then 
					next_state <= comm2uC;
				elsif RX_port = '0' and (commandType = R2SINK or commandType = NWKRroute) then -- voy a Contention 
					next_state <= Contention; -- esto esta mal tiene que ser a com2uc
				end if;
			end if; 
        when Contention => -- de aqui salgo cuando puedo enviar
			MoMState <= "110";
			if ChannelFree = '1' then
				next_state <= Sending_MSG;
			end if;
		when Sending_MSG =>
			MoMState <= "010"; --esta en el proceso de asignacion de las salidas
            if TX_messageEnd = '1' then
				if commandSource = uC and  commandType = R2SINK then -- si el R2Sink viene del micro es que se trata del primer nodo
					next_state <= R2SINK_1st; -- en estos casos hago data clean y a funcionar no necesito decirle nada al micro
				elsif commandSource = uC and  commandType = NWKRroute then -- si el R2Sink viene del micro es que se trata del primer nodo
					next_state <= rRoutingNWK;
				elsif commandSource = RX then -- si viene de la radio no es el primer nodo
					if commandType = R2SINK then 	
						if SINKNeighbor = '0' then
							next_state <= R2SINK_received; 
						else
							next_state <= comm2uC; 
							--next_state <= R2SINK_ack; 
						end if;
					else -- commandType = NWKRroute or commandType = R2SACK then
						next_state <= Comm2uC; 
					end if;
				end if;
			elsif uC_toInactive = '1' then  -- par apoder resetear desde el micro encasao de que no llegue msg end...
				next_state <= MoM_AWAKE;
			end if;        
		when Comm2uC =>
			MoMState <= "101";
			if uC_ACK_reg = '1' and SINKNeighbor = '0'  and command_Type_uC = '0'then
				next_state <= R2SINK_ack; --if command_Type_uC = '0' then -- R2SACK then -- se recibe el ACK del uc a la notificacionde de R2SINK recibido
			
			elsif uC_ACK_reg = '1' and SINKNeighbor = '0'  and command_Type_uC = '1' then --NWKRroute then -- se recibe el ACK del uc a la notificacionde de rRouteNWK recibido
					next_state <= rRoutingNWK;
			
			elsif uC_ACK_reg = '1' and SINKNeighbor = '1' then
					next_state <= MoM_AWAKE;
			
			elsif  uC_toInactive = '1' then 
				next_state <= MoM_AWAKE;
			end if;
			
		when rRoutingNWK => -- de aqui salgo cuando dice el microcontroller
			MoMState <= "100";
			if  uC_toInactive = '1' then 
				next_state <= MoM_AWAKE;
			end if;
			
		when R2SINK_1st => -- de aqui salgo cuando recibo un R2SACK
			MoMState <= "011";
			--if command_In_Queue = '1' and commandType = R2SINK then	-- generada por el command processor
			if command_In_Queue = '1' then
				if commandType = R2SACK and commandSource = RX and uC_ACK_reg = '1'then	
					next_state <= MoM_AWAKE;
				elsif commandType = R2SINK and commandSource = uC then -- si el micro pone un nuevo comando en la cola de envio se envia incluso aunque sea un R2SINK asi en caso de fallo salimos de este estado
					next_state <= Contention;
				-- elsif commandType = NWKRroute  then	-- generada por el command processor
					-- next_state <= Sending_MSG;
				end if;
			end if;
			
		when R2SINK_received => -- de aqui salgo cuando dice el micro o cuando recibo un rRouteNWK
            MoMState <= "000";
			if command_In_Queue = '1' then
				if commandType = NWKRroute  or commandType = R2SACK then -- se recibe un rRouteNWK antes de quie se resuleva el R2SINK, 
					next_state <= Contention;								-- se envia el nuevo comando al considerarse de mas importancia
				end if;
			end if;
		
		when R2SINK_ack => -- de aqui salgo cuando dice el micro
            MoMState <= "001";
			if  uC_toInactive = '1' then 
				next_state <= MoM_AWAKE;
			end if;

      end case;      
   end process;
   
   --MEALY State-Machine - Outputs based on state and inputs
	OUTPUT_DECODE: process (state, command_In_Queue, commandType, commandSource, TX_messageEnd, uC_ACK_reg, uC_toInactive, RX_port,SinkNeighbor, ContentionExpired)
	begin
		--insert statements to decode internal output signals
      --below is simple example
		if (state = MoM_AWAKE) then
			--MoMState <= "111";
			if command_In_Queue = '1'and SinkNeighbor = '1' and commandSource = uC and commandType = R2SINK then -- en este caso no tengo q enviar el mensaje directamente puedo hablar con el SINK 
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '0';
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '0';
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '1';
					Mom_Free <= '0';
				
			elsif command_In_Queue = '1'and RX_port = '0' and (commandType = R2SINK or commandType = NWKRroute) then -- tengo q cambiar el mensaje a enviar a tipo 11 
					-- rndDelay_shift <= '1';
					ContentionEnab <= '0';
					RF_selector <= '0';
					TX_load <= '1'; -- puedo cargar ya el dato en el codifcador manchester
					TX_enable <= '0';
					clean_command <= '0';
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '0';
					Mom_Free <= '0';
			-- CAMBIO REALIZADO EL DIA 9 para intertar resolver el problema de r2SACK que causa q al vovler a despertar a la FPGA esta envia erroneamente in R2SINK
			elsif command_In_Queue = '1' and (commandType = R2SACK) then -- tengo q cambiar el mensaje a enviar a tipo 11 
					-- rndDelay_shift <= '1';
					ContentionEnab <= '0';
					RF_selector <= '0';
					TX_load <= '1'; -- puedo cargar ya el dato en el codifcador manchester
					TX_enable <= '0';
					clean_command <= '1';
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '0';
					Mom_Free <= '0';
			else
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';		
				awake_uC <= '0';
				reg_command_enab <= '1';
				commandReady2uC <= '0';
				Mom_Free <= '1';
			end if;
		
		elsif (state = Contention) then
			--MoMState <= "110";
			if RX_Port = '1' and ContentionExpired = '0' then 
				ContentionEnab <= '0';
				RF_selector <= '0';
				TX_load <= '1';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '0';
				reg_command_enab <= '0';
				commandReady2uC <= '0';
				Mom_Free <= '0';
			else
				ContentionEnab <= '1';
				RF_selector <= '0';
				TX_load <= '1';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '0';
				reg_command_enab <= '0';
				commandReady2uC <= '0';
				Mom_Free <= '0';
			end if;
			
		elsif state = Sending_MSG then
			--MoMState <= "010";
            if TX_messageEnd = '1' then
				if commandSource = uC  or (commandSource = RX and commandType = R2SINK and SinkNeighbor = '0') then
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '1';
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '1';
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '0';
					Mom_Free <= '0';
				else
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '1';
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '0';
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '0';
					Mom_Free <= '0';
				end if;
			else --if TX_active = '1' then -- el encoder esta en funcionamiento
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '1';
				TX_load <= '0';
				TX_enable <= '1';
				clean_command <= '0';
				awake_uC <= '0';	
				reg_command_enab <= '0';				
				commandReady2uC <= '0';
				Mom_Free <= '0';
			end if;	
			
		elsif state = Comm2uC then
			--MoMState <= "101";
			if  uC_ACK_reg = '1' then
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le microcontroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '1';
				awake_uC <= '0';
				reg_command_enab <= '0';
				commandReady2uC <= '0';	
				Mom_Free <= '0';
		
			else
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '1';
				reg_command_enab <= '0';
				commandReady2uC <= '1';
				Mom_Free <= '0';
			end if;
			
		elsif state = rRoutingNWK then
			--MoMState <= "100";
			-- rndDelay_shift <= '0';
			ContentionEnab <= '0';
			RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le microcontroller me diga que ha terminado
			TX_load <= '0';
			TX_enable <= '0';
			clean_command <= '1'; -- cambiado para que en las pruebas con fpgas por cable el rRouting no rebotara, en la implementacion con radio no era necesario dado que el switch se queda en posicion TX para que no lleguen mensajes nuevos.
			awake_uC <= '0';
			reg_command_enab <= '1';
			commandReady2uC <= '0';
			Mom_Free <= '1';
			
			
		elsif state=R2SINK_1st then
			--MoMState <= "011";
			if command_In_Queue = '1' then
				if commandType = R2SACK and commandSource = RX and uC_ACK_reg = '0' then
					---- rndDelay_shift <= '1';
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '0'; 
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '0'; -- cambiado para que en las pruebas con fpgas por cable el rRouting no rebotara, en la implementacion con radio no era necesario dado que el switch se queda en posicion TX para que no lleguen mensajes nuevos.
					awake_uC <= '1';
					reg_command_enab <= '1';
					commandReady2uC <= '1';
					Mom_Free <= '0';
				elsif commandType = R2SACK and commandSource = RX and uC_ACK_reg = '1' then
					---- rndDelay_shift <= '1';
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '0'; 
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '1'; -- cambiado para que en las pruebas con fpgas por cable el rRouting no rebotara, en la implementacion con radio no era necesario dado que el switch se queda en posicion TX para que no lleguen mensajes nuevos.
					awake_uC <= '0';
					reg_command_enab <= '0';
					commandReady2uC <= '0';
					Mom_Free <= '0';
				elsif commandType = NWKRroute  then
					-- rndDelay_shift <= '1';
					ContentionEnab <= '0';
					RF_selector <= '0'; -- 
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '0';
					awake_uC <= '0';
					reg_command_enab <= '1';
					commandReady2uC <= '0';
					Mom_Free <= '0';
				else
					-- rndDelay_shift <= '0';
					ContentionEnab <= '0';
					RF_selector <= '0'; 
					TX_load <= '0';
					TX_enable <= '0';
					clean_command <= '0'; 
					awake_uC <= '0';
					reg_command_enab <= '1';
					commandReady2uC <= '0';
					Mom_Free <= '1';
				end if;
			else
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0'; 
				awake_uC <= '0';
				reg_command_enab <= '1';
				commandReady2uC <= '0';
				Mom_Free <= '1';
			end if;
				
		elsif state = R2SINK_received then
			--MoMState <= "010";
			if uC_toInactive = '1' then 
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; -- 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '0';
				reg_command_enab <= '1';
				commandReady2uC <= '0';
				Mom_Free <= '0';
			elsif command_In_Queue = '1' then 
				-- rndDelay_shift <= '1';
				ContentionEnab <= '0';
				RF_selector <= '0'; -- 
				TX_load <= '1';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '0';
				reg_command_enab <= '1';
				commandReady2uC <= '0';
				Mom_Free <= '0';
			else
				-- rndDelay_shift <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				awake_uC <= '0';
				reg_command_enab <= '1';
				commandReady2uC <= '0';
				Mom_Free <= '1';
			end if;
		
		elsif state = R2SINK_ack then
			--MoMState <= "001";
			-- rndDelay_shift <= '0';
			ContentionEnab <= '0';
			RF_selector <= '0'; 
			TX_load <= '0';
			TX_enable <= '0';
			clean_command <= '0';
			awake_uC <= '0';
			reg_command_enab <= '1';
			commandReady2uC <= '0';
			Mom_Free <= '1';
		end if;

	end process;

--======================================================================
--========================================================================	
	
	msgtosendbitChange <= commandtoSend(1) xnor commandtoSend(0);
	commandtoEncoder_int <= '1' & msgtosendbitChange when SinkNeighbor = '1' else commandtoSend ;
	command_Type_uC <= not commandtoEncoder_int(0); -- cambio el bit de msg para el micro asi si el comando que ve es 0 se correponde con respuesta a R2SINK y si ve 1 es NWKRroute y coincide con el tipo de comando que escribe el micro
	commandType2uC <= command_Type_uC;
	
	COMMAND_QUEUE_P: process (clk, rst)--selCommandSource, uC_commandType, RX_active, reg_comandToSend, RX_commandType)
	begin
		if rst = '0' then
			commandToSend <= "01" ; -- 01 no se corresponde con nigun tipo de mensaje por eso se inicializa a ese valor
			command_In_Queue <= '0';
			commandQueue <= "01"; -- 01 no se corresponde con nigun tipo de mensaje por eso se inicializa a ese valor
			commandQueue_flag <= '0';
			commandSource <= '0';
			uCcommandinQueue <= '0';
		
		elsif clk'event and clk = '1' then
			
			if reg_command_enab = '1' then
				if RX_commandReady = '1' and uC_commandReady = '0'then
					commandToSend <= RX_commandType;
					commandQueue <= "01";
					command_In_Queue <= '1';
					commandQueue_flag <= '0';
					commandSource <= '1';
					uCcommandinQueue <= '0';
				elsif uC_commandReady = '1' and ( RX_commandReady = '0' or RX_active = '0')  then
					commandToSend <= uC_commandType & '0'; 
					command_In_Queue <= '1';
					commandQueue_flag <= '0';
					commandSource <= '0';
					uCcommandinQueue <= '1';
				elsif uC_commandReady = '1' and RX_commandReady = '1' then
					commandToSend <= RX_commandType;
					commandQueue <= uC_commandType & '0'; 
					command_In_Queue <= '1';
					commandQueue_flag <= '1';
					commandSource <= '1';
					uCcommandinQueue <= '1';
				else
					commandToSend <= "01";
					commandQueue <= "01";
					command_In_Queue <= '0';
					commandQueue_flag <= '0';
					commandSource <= '0';
					uCcommandinQueue <= '0';
				end if;
			
			elsif clean_command = '1' then
				if commandQueue_flag = '1' then
					commandSource <= '0';
					command_In_Queue <= '1';
					commandQueue_flag <= '0';
					commandToSend <= commandQueue;
					commandQueue <= "01";
					uCcommandinQueue <= '1';
				else
					commandSource <= '0';
					command_In_Queue <= '0';
					commandQueue_flag <= '0';
					commandQueue <= "01";
					commandToSend <= "01";
					uCcommandinQueue <= '0';
				end if;
			end if;
		end if;
	end process;
	
	ContentionTimeExpired <= '1' when Contention_int = 166 else '0';
	ChannelFreeTime <= '1'  when Contention_int = 775 else '0';
	
	ChannelFree <= (ContentionTimeExpired and not RX_port) or ChannelFreeTime;
	
	ContentionExpired_proc: process (clk, rst)
	begin
		if rst = '0' then
			ContentionExpired <= '0';
		elsif clk'event and clk = '1' then
			if ContentionTimeExpired = '1' then
				ContentionExpired <= '1';
			
			elsif TX_messageEnd = '1' then
				ContentionExpired <= '0';
			end if;
		end if;
	end process;
	
	Contention_counter: process (clk, rst)
	begin
		if rst = '0' then
			Contention_int <= 0;
			
		elsif clk'event and clk = '1' then
			if ChannelFree = '1' then
				Contention_int <= 0;
			elsif ContentionEnab = '1' then
				if RX_port = '1' and ContentionExpired = '1'then
					Contention_int <= 167;
				else
					if Contention_int = 775 then
						Contention_int <= 0;
					else
						Contention_int <= Contention_int + 1;
					end if;
				end if;
			end if;	
		end if;
	end process;
END;
	-- COMO HAGO EL CSMA 
	-- cuatro opciones 00 no espero y paso a transmitir supongo canal libre
	-- 01 espero al menos 660 us
	-- 10 al menos 780 us
	-- 11 espero al menos 990 us
	-- para la espera uso el manchester decoder para detectar los flancos y detectar un error en la transmision por "stack-at '0'" que entiendo como canal libre
	-- para eso disparo una conversion con un flanco generado por la MoM y espero el tiempo antes mencionado para que señale error de recepcion, en caso de recepcion de msj el contador se irar resetenado hasta q la recepcion termine
	
	-- emptyRandom <= '1' when random_num = "0000000000000000" else '0';
	
	-- strtCSMA <= (delayed_TX(0) or delayed_TX (1)) and -- rndDelay_shift;
	-- delayed_TX <= random_num(7) & random_num(5);
	
	-- CHANNEL_CONTROL: process(clk, rst)
	-- begin
	-- if rst = '0' then
		-- ChannelControlled <= '1';
	-- elsif(clk'event and clk = '1') then
		-- if strtCSMA = '1' then 
			-- ChannelControlled <= '0';
		-- elsif ChannelFree = '1' and -- carrierSense = '1' then
			-- ChannelControlled <= '1';
		-- end if;
	-- end if;
	-- end process;

	-- process (rst,clk)
	-- begin
		-- if rst = '0' then
			-- error_counter <= 0 ;
		-- elsif clk'event and clk = '1' then 
			-- if rst_error_counter = '1' or EndOfMsg = '1' or rx_error = '1' then
				-- error_counter <= 0;
			-- elsif backoff_Flag = '1' then	
				-- if error_counter = ERROR_TIME then
					-- error_counter <= 0;
				-- else
					-- error_counter <= error_counter + 1;
				-- end if;
			-- end if;
		-- end if ;
	-- end process ;	
	
	-- process (clk, rst)
    -- begin

        -- if (rst = '0') then 
            -- backoff_Flag <= '0';
			-- backoffTime <= 0;
        -- elsif (clk'event and clk='1') then
            -- if -- carrierSense = '1' then
                -- if backoffTime = DECODER_REF then
                    -- backoff_Flag <= '1';
					-- backoffTime <=0;
                -- else
                    -- backoffTime <= backoffTime + 1;
					-- backoff_Flag <= '0';
                -- end if;
            -- else
                -- backoff_Flag <= '0';
				-- backoffTime <= 0;
             -- end if;
        -- end if;
    -- end process;
	
	-- RANDOM_DELAYER:	process(clk, rst)
	-- begin
	-- if rst = '0' then
		-- random_num <= (others => '0');
	
	-- elsif(clk'event and clk = '1') then
		-- if addressLoad = '1' and emptyRandom = '1' then
			-- random_num <= NodeAddress (15 downto 0);
		
		-- elsif -- rndDelay_shift = '1' then
			-- random_num(15 downto 1) <= random_num(14 downto 0);
			-- random_num (0) <= random_num (15) xor random_num (0);
		
		-- end if;
	-- end if;
	-- end process;
	
--END;
    