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
		RX_addressOK : IN std_logic;
		
		uC_commandType: IN  std_logic; --  generada por el microcontroller (solo necesito un bit el msg 11 ACK solo lo envia la Wupu)
        uC_commandReady : IN std_logic; -- generada por el microcontroller
		ZB_active : IN std_logic; -- el ctrl de ZB esta activo
				
		TX_Active: in std_logic; -- el encoder esta enviando un mensaje
		
		commandType2ZB: OUT  std_logic;  --Solo me hace falta el bit LSB para indicar si el micro tiene q procesar un NWKRRoute o un R2SINK
        commandReady2ZB : OUT std_logic; 
		---uCcommandinQueue : OUT std_logic;  
		
	--	NodeAddress : IN std_logic_vector (ADDRESSLENGTH-1 downto 0);
		nextHopAddress : IN std_logic_vector(ADDRESSLENGTH-1 downto 0);
		 
		commandToEncoder : OUT  std_logic_vector (1 downto 0); -- dato que se le pasa a manchester encoder
		
		Enable_encoder : out std_logic; -- habilita en manchester encoder 
		RF_selector : out std_logic; --señal de seleccion para el RF switch 0 para RX_port y 1 para TX
		TX_load : out std_logic;	
		RX_processed : out std_logic;
		--ZB_ACK : in std_logic; -- señalq ue indica que el ZB ctrl ha leido el comando que la MoM le quiere enviar.
		

		MoMState: out std_logic_vector (2 downto 0);
		
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
END MoM_unit;

ARCHITECTURE RTL of MoM_unit is

type state_type is (MoM_StandBy, Contention, Sending_MSG, WaitingACK, WakeupZB, WaitingTimeout);
signal state, next_state : state_type; 

signal TX_enable : std_logic;
signal SINKNeighbor : std_logic;
signal commandSource : std_logic;
--signal uC_commandReady : std_logic;
signal clean_command : std_logic;
signal commandToSend : std_logic_vector (1 downto 0);
signal commandType : std_logic_vector (1 downto 0);

signal commandtoEncoder_int : std_logic_vector (1 downto 0);

signal command_Type_uC : std_logic;

signal commandReceived : std_logic;

signal emptyRandom : std_logic;

signal ZB_toInactive : std_logic;
signal ZB_active_D0 : std_logic;
signal ZB_active_D1 : std_logic;

signal WaitingACKEnab : std_logic;

signal timeOutACK : std_logic;

signal NACKCnt : integer range 0 to MAXRETRIES;
constant ACKTIMEOUT : integer := FCLK/FTIMEOUTACK;
signal aux_timeOut : integer range 0 to FCLK/FTIMEOUTACK; -- FTIMEOUTACK = 200 --> T 5 ms


signal ContentionEnab: std_logic;

signal delayed_TX : std_logic_vector (1 downto 0);
signal ZB_ACK_reg : std_logic;

signal ContentionTimeExpired : std_logic; 
signal Contention_int : integer range 0 to 775; 
signal	ChannelFreeTime : std_logic; 
signal	ChannelFree : std_logic;
signal ContentionExpired :  std_logic;


constant RX : std_logic := '1';
constant uC : std_logic := '0';

signal Mom_Free : std_logic;

signal backoff_Flag : std_logic;

begin







	-- process (clk, rst)
	-- begin
		-- if rst = '0' then
			-- ZB_ACK_reg <= '0';
		-- elsif clk'event and clk = '1' then
			-- ZB_ACK_reg <= ZB_ACK; 
		-- end if;
	-- end process;

	
	
	
	-- process (clk, rst)
	-- begin
		-- if rst = '0' then
			-- ZB_ACK_reg <= '0';
		-- elsif clk'event and clk = '1' then
			-- ZB_ACK_reg <= ZB_ACK; 
		-- end if;
	-- end process;
-- process (iamtheSINK, NodeAddress)
-- begin
	-- if NodeAddress = "00000000" then
		-- iamtheSINK <= '1';
	-- else
		-- iamtheSINK <= '0';
	-- end if;
-- end process;

process (nextHopAddress, SINKNeighbor)
begin
	if nextHopAddress = "00000000" then
		SINKNeighbor <= '1';
	else
		SINKNeighbor <= '0';
	end if;
end process;

commandType2ZB <= commandType (1);
commandtoEncoder <= commandType;

Enable_encoder <= TX_enable;
commandType <= RX_commandType when commandSource=RX else uc_commandType&'0'; --;-- leo el comando de respuesta

RX_processed <= clean_command and  RX_commandReady;

---	commandtoEncoder_int <= RX_commandType when 

d_hk <= Mom_Free;

--Detector de flanco de ucActive para saber que ya ha terminado y se va a dormir

	-- Probablemente no haga falta
	-- ZB_toInactive <=  ( ZB_active_D1) and  (not ZB_active_D0); 	
	-- process (clk, rst)
	-- begin
		-- if rst = '0' then
			-- ZB_active_D0 <= '0';
			-- ZB_active_D1 <= '0';
		-- elsif clk'event and clk = '0' then
			-- ZB_active_D0 <= ZB_active; 
			-- ZB_active_D1 <= ZB_active_D0;
		-- end if;
	-- end process;


	
	SYNC_PROC: process (rst, clk)
	begin
      if (rst = '0') then
         state <= MoM_StandBy;
      elsif (clk'event and clk = '1') then
           state <= next_state;
      end if;
	end process;
 
	--uC_commandReady <= uC_commandInput;
	commandReceived <= RX_commandReady or uC_commandReady;  --  and  (not uC_addressingData); -- solo se procesa el msg del micro si no estan llegando mensajes por la radio y los datos no son de direcciones
	commandSource <= RX_commandReady;
 -- shortMsgFlag <= not reg_comandToSend; 

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	-- state_type is (MoM_StandBy, Sending_MSG, WaitingACK, WakeupZB, WaitingTimeout); --
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	
	NEXT_STATE_DECODE: process (state, RX_addressOK, ZB_ACK_reg, TX_enable , RX_port, TX_Active, commandType,  command_Type_uC, ChannelFree, uC_commandReady, RX_commandReady )
	begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
        when MoM_StandBy =>
			MoMState <= "111"; -- para q funcione el indirect ACK tengo q reenviar
			if commandReceived = '1'and (commandSource = uc or (RX_commandType = NWKrRoute) or (RX_addressOK = '1')) then -- voy a Contention 
				next_state <= Contention; 
			end if; 
        
		when Contention => -- de aqui salgo cuando puedo enviar
			MoMState <= "110";
			if ChannelFree = '1' then
				next_state <= Sending_MSG;
			end if;
		
		when Sending_MSG =>
			MoMState <= "010"; --esta en el proceso de asignacion de las salidas
			-- if ZB_toInactive = '1' then  -- par apoder resetear desde el micro en caso de que no llegue msg end...
				-- next_state <= MoM_StandBy;
            
			-- els
			if TX_Active = '0' then
				if  commandType = R2SINK and SINKNeighbor = '0' then -- si el R2Sink y no soy el ultimo nodo antes del sink/root/coordinador
					next_state <= WaitingACK; -- en estos casos hago data clean y a funcionar no necesito decirle nada al micro
				-- elsif commandType = NWKRroute or commandType = R2SINK then -- si es un NWKReroute 
					-- next_state <= WakeupZB;
				else -- si se un NWKReroute o soy el SINK neigbor despues de enviar no hay q esperar al indirect ACK
					next_state <= WakeupZB;
				end if;
				
			end if;        
			
		when WaitingACK =>
			MoMState <= "101";
			if commandReceived = '1' and (RX_commandType = R2SINK and RX_addressOK = '0') then
				next_state <= WakeupZB;
			
			elsif timeOutACK = '1' and NACKCnt = MAXRETRIES -1 then
				next_state <= MoM_StandBy;
			
			elsif commandReceived = '1' and (RX_commandType = NWKrRoute or uc_CommandType = '0')  then --NWKRroute then -- se recibe el ACK del uc a la notificacionde de rRouteNWK recibido
					next_state <= Contention;
			end if;
			
		when WakeupZB => -- de aqui salgo cuando dice el microcontroller
			MoMState <= "100";
			if  ZB_active = '1' then 
				next_state <= WaitingTimeout;
			end if;
			
			
		when WaitingTimeout => -- de aqui salgo cuando telegesis se va dormir
		
		    MoMState <= "001";
			if  ZB_active = '0' then 
				next_state <= MoM_StandBy;
			
			elsif commandReceived = '1' and commandType = NWKRroute  then -- se recibe un rRouteNWK antes de quie se resuleva el R2SINK, 
				next_state <= Contention;								-- se envia el nuevo comando al considerarse de mas importancia
			end if;
	
      end case;      
   end process;
   
   --MEALY State-Machine - Outputs based on state and inputs
	OUTPUT_DECODE: process (state,  commandType, commandSource, TX_Active, ZB_ACK_reg, RX_port, ContentionExpired)
	begin
		--insert statements to decode internal output signals
      --below is simple example
		if (state = MoM_StandBy) then
				WaitingACKEnab <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';		
				-- reg_command_enab <= '1';
				commandReady2ZB <= '0';
				Mom_Free <= '1';

		
		elsif (state = Contention) then
			if RX_Port = '1' and ContentionExpired = '0' then 
				WaitingACKEnab <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0';
				TX_load <= '1';
				TX_enable <= '0';
				clean_command <= '0';
				-- reg_command_enab <= '0';
				commandReady2ZB <= '0';
				Mom_Free <= '0';
			else
				WaitingACKEnab <= '0';
				ContentionEnab <= '1';
				RF_selector <= '0';
				TX_load <= '1';
				TX_enable <= '0';
				clean_command <= '0';
				-- reg_command_enab <= '0';
				commandReady2ZB <= '0';
				Mom_Free <= '0';
			end if;
			
		elsif state = Sending_MSG then
			--MoMState <= "010";
            if TX_Active = '0' then
				WaitingACKEnab <= '0';
				ContentionEnab <= '0';
				RF_selector <= '1';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';

				commandReady2ZB <= '0';
				Mom_Free <= '0';

			else --if TX_active = '1' then -- el encoder esta en funcionamiento
				WaitingACKEnab <= '0';
				ContentionEnab <= '0';
				RF_selector <= '1';
				TX_load <= '0';
				TX_enable <= '1';
				clean_command <= '0';
		
				commandReady2ZB <= '0';
				Mom_Free <= '0';
			end if;	
			
			
		elsif state = WaitingACK then
			--MoMState <= "010";
			WaitingACKEnab <= '1';
			ContentionEnab <= '0';
			RF_selector <= '0'; 
			TX_load <= '0';
			TX_enable <= '0';
			clean_command <= '0';
			commandReady2ZB <= '0';
			Mom_Free <= '1';
			
		elsif state = WakeupZB then
		
				WaitingACKEnab <= '0';
				ContentionEnab <= '0';
				RF_selector <= '0'; 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '1';
				commandReady2ZB <= '1';
				Mom_Free <= '0';

		
		elsif state = WaitingTimeout then

			WaitingACKEnab <= '0';
			ContentionEnab <= '0';
			RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le microcontroller me diga que ha terminado
			TX_load <= '0';
			TX_enable <= '0';
			clean_command <= '1'; -- cambiado para que en las pruebas con fpgas por cable el rRouting no rebotara, en la implementacion con radio no era necesario dado que el switch se queda en posicion TX para que no lleguen mensajes nuevos.
			commandReady2ZB <= '0';
			Mom_Free <= '1';
		
		
		end if;
				
	end process;

	
-- signal timeOutACK : std_logic;
-- signal timeOutCnt : std_logic;
-- signal aux_timeOut : integer range 0 to FCLK/FTIMEOUTACK; -- FTIMEOUTACK = 200 --> T 5 ms
	
	timeOutACK <= '1' when aux_timeOut = ACKTIMEOUT else '0';
	
	TimeOutACK_proc: process (clk, rst)
	begin
		if rst = '0' then
			aux_timeOut <= 0;
		elsif clk'event and clk = '1' then
			if ContentionEnab = '0' then
				aux_timeOut <= 0;
			elsif ContentionEnab = '1' then
				if aux_timeOut = ACKTIMEOUT then
					aux_timeOut <= 0;
				else
					aux_timeOut <= aux_timeOut + 1;
				end if;
			end if;
		end if;
	end process;
	
	NACK_counterproc: process (clk, rst)
	begin
		if rst = '0' then
			NACKCnt <= 0;
		elsif clk'event and clk = '1' then
			if ContentionEnab = '0' then
				NACKCnt <= 0;
			elsif ContentionEnab = '1' and timeOutACK = '1' then
				if NACKCnt = MAXRETRIES-1 then
					NACKCnt <= 0;
				else 
					NACKCnt <= NACKCnt + 1;
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
			
			elsif TX_Active = '1' then
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

    