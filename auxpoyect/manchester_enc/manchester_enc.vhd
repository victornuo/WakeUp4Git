-- Mom_unit.vhd
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY MoM_unit is
    PORT(
        --WakeupSource : IN std_logic_vector (1 downto 0); -- conected to a microncontroller pin (1 if the uC wakeup the FPGA)
		
        RX_active : IN std_logic; -- bandera que indica que el receptor esta activo
		RX_commandType: IN  std_logic; --  generada por el command processor
        RX_commandReady : IN std_logic;
		
		uC_commandType: IN  std_logic; --  generada por el microcontroller
        uC_commandReady : IN std_logic; -- generada por el microcontroller
		uC_addressingData : IN std_logic; -- generada por el microcontroller '1' indica que el dato que va a enviar el micro son direcciones
		uC_active : IN std_logic; -- el microcontrolador esta despierto
		activate_uC : OUT std_logic; -- despierto al uC
		TX_active: in std_logic; -- el encoder esta en funcionamiento
		TX_messageEnd: in std_logic; -- el encoder ha terminado el envio

		WuR_commandType: OUT  std_logic; 
        WuR_commandReady : OUT std_logic;  		
		
		NodeAddress : IN std_logic_vector (15 downto 0);
		--nextHopAddress : IN std_logic_vector(15 downto 0);
		 
		comandToSend : OUT  std_logic; -- dato que se le pasa a manchester encoder
		--EoD : OUT  std_logic; -- ultimo bit pendiente de ser transmitido
		--newData : OUT  std_logic; -- paso un nuevo bit al encoder
			 
		Enable_encoder : out std_logic; -- habilita en manchester encoder 
		RF_selector : out std_logic; --señal de seleccion para el RF switch 0 para RX y 1 para TX
		TX_load : out std_logic;	
		RX_processed : out std_logic;
		uC_ACK : in std_logic;
		uC_processed : out std_logic;
		--RX_enable : OUT std_logic; 
         
		d_hk : OUT  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic
        );
END MoM_unit;

ARCHITECTURE RTL of MoM_unit is

type state_type is (MoM_AWAKE, Sending_MSG, R2SINK_1st, R2SINK_active, rRoutingNWK);
signal state, next_state : state_type; 

signal FullMsg :  std_logic_vector(18 downto 0); 
signal msgPendingFlag : std_logic;
signal TX_enable : std_logic;
signal iamtheSINK : std_logic;
signal selCommandSource : std_logic;
signal uC_tobeload : std_logic;
signal shortMsgFlag : std_logic;
signal clean_command : std_logic;
signal prev_comandToSend : std_logic;
signal uC_toInactive : std_logic;
signal uC_active_ED : std_logic;
begin


process (iamtheSINK, NodeAddress)
begin
	if NodeAddress = "0000000000000000" then
		iamtheSINK <= '1';
	else
		iamtheSINK <= '0';
	end if;
end process;

Enable_encoder <= TX_enable and (not iamtheSINK);
comandToSend <= prev_comandToSend;-- leo el comando de respuesta

RX_processed <= clean_command and  RX_commandReady;
uC_processed <= clean_command and (not RX_commandReady);

uC_toInactive <= uC_active_ED and (not uC_active); 


--Detector de falnco de ucActive para saber que ya ha terminadop y se va a dormir
	
	process (clk, rst)
	begin
		if rst = '0' then
			uC_active_ED<= '0';
		elsif clk'event and clk='1' then
			uC_active_ED <= uC_active; 
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
 
  uC_tobeload <= (uC_commandReady  and  (not uC_addressingData) )and  (not RX_active) ; -- solo se procesa el msg del micro si no estan llegando mensajes por la radio y los datos no son de direcciones
  shortMsgFlag <= not prev_comandToSend; 

	NEXT_STATE_DECODE: process (state, next_state, iamtheSINK , RX_commandType , RX_commandReady  )
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
        when MoM_AWAKE =>
            if iamtheSINK = '1' and RX_commandReady = '1' and RX_commandType = '0'  then 
				next_state <= R2SINK_active;
			elsif iamtheSINK = '0' and TX_enable = '1' and RX_active = '0' then -- hasta que no termine la recepcion no cambiamos el RF switch 
				next_state <= Sending_MSG;
			end if; 
        
		when Sending_MSG =>
            if TX_messageEnd = '1' and prev_comandToSend = '0' and uC_tobeload = '1' then
				next_state <= R2SINK_1st;
			
			elsif TX_messageEnd = '1' and prev_comandToSend = '0' and RX_commandReady = '1' then
				next_state <= R2SINK_active;
				
			elsif TX_messageEnd = '1' and prev_comandToSend = '1' then
				next_state <= rRoutingNWK;
				
			end if;        
		
		when rRoutingNWK => -- de aqui salgo cuando dice el microcontroller
			if  uC_toInactive = '1' then 
				next_state <= MoM_AWAKE;
			end if;
		when R2SINK_1st => -- de aqui  saldo cunado recibo un R2SINK
			if RX_commandReady = '1' and RX_commandType = '0'  then--  generada por el command processor
				next_state <= R2SINK_active;
			end if;
		when R2SINK_active => -- de aqui salgo cuando dice el micro
            if RX_commandReady = '1' and RX_commandType = '1'  then--  generada por el command processor
				next_state <= rRoutingNWK;
			elsif  uC_toInactive = '1' then 
				next_state <= MoM_AWAKE;
			end if;		
		when others =>
            next_state <= MoM_AWAKE;
      end case;      
   end process;
   
   --MEALY State-Machine - Outputs based on state and inputs
   OUTPUT_DECODE: process (state, RX_active, TX_messageEnd)
   begin
      --insert statements to decode internal output signals
      --below is simple example
		if (state = MoM_AWAKE) then
			if RX_commandReady = '1' or uC_tobeload = '1' then
				RF_selector <= '0';
				TX_load <= '1';
				TX_enable <= '1';
				clean_command <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';		
				d_hk <= '0';
			else
				RF_selector <= '0';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';		
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '1';
			end if;
		elsif state = Sending_MSG then
            if TX_messageEnd = '1' then
				RF_selector <= '1';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '1';
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			
			else --if TX_active = '1' then -- el encoder esta en funcionamiento
				RF_selector <= '1';
				TX_load <= '0';
				TX_enable <= '1';
				clean_command <= '0';
				activate_uC <= '0';		
				WuR_commandReady <= '0';
				WuR_commandType <= '0';					
				d_hk <= '0';
			end if;	
			
		elsif state = rRoutingNWK then
			if uC_active = '0' then
				RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '1';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			elsif uC_active = '1' then
				RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '1';
				WuR_commandType <= '0';	
				d_hk <= '0';
			elsif uC_ACK = '1' then
				RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '1';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '1';
			else
				RF_selector <= '1'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			end if;
			
		elsif state=R2SINK_1st then
			if RX_commandReady = '1' and RX_commandType = '0'  then 	--de aqui me voy cuando recivo otro mensaje por la radio
				RF_selector <= '0';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '1';
				activate_uC <= '1';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			else
				RF_selector <= '0';
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '1';
			end if;
		elsif state=R2SINK_active then
			if uC_toInactive = '1' then --si recivo un rRoting msg pos hare otra cosa
				RF_selector <= '0'; -- 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '1';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			elsif uC_active = '0' then
				RF_selector <= '0'; -- 
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '1';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			elsif uC_active = '1' then
				RF_selector <= '0'; -- 
				TX_load <= '0';
				TX_enable <= '0'; 
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '1';
				WuR_commandType <= '1';	
				d_hk <= '0';
			elsif uC_ACK = '1' then
				RF_selector <= '0'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '1';
			else
				RF_selector <= '0'; -- lo dejo como transmisor asi me no me levanto aunque lleguen mas mensajes hasta que le micronotroller me diga que ha termiando
				TX_load <= '0';
				TX_enable <= '0';
				clean_command <= '0';
				activate_uC <= '0';
				WuR_commandReady <= '0';
				WuR_commandType <= '0';	
				d_hk <= '0';
			end if;
		end if;
   end process;
 
selCommandSource <= RX_commandReady;  
   process (selCommandSource, uC_commandReady, RX_active, prev_comandToSend)
	begin
		if selCommandSource = '1' then
				prev_comandToSend <= RX_commandType;
		else 
				prev_comandToSend <= uC_commandType; 
		end if;
	end process;	
	
END;