LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library igloo;
use igloo.all; 

ENTITY TB_MD_CommP_Pre IS
END TB_MD_CommP_Pre;

ARCHITECTURE behavioral OF TB_MD_CommP_Pre IS 

   
	
   COMPONENT md_v3
   PORT( 
		mdi  : in std_logic;
		EoM : in std_logic; 
		bit_error  : out std_logic;
		dout  : out std_logic;
		new_data : out std_logic;
		rst: in std_logic ;  
		clk: in std_logic ;  
		d_hk: out std_logic );
   END COMPONENT;

   
   COMPONENT command_process
	port (
		nodeAddress : in std_logic_vector (15 downto 0); -- network adress del SINK
		din : in std_logic ; -- din <=> dout Manchester decoder
		newData : in std_logic; -- newData <=> newData MancheterDecoder
		dataClean : in std_logic;
		bitError : in std_logic;
		
		endOfMessage : out std_logic; -- Fin de mensaje, sea o no el destinatario, endOfMessage <=> [] manchesterDecoder od frequency divider
		newMsg : out std_logic; -- nuevo mensaje recibido, newMsg <=> newMsg MoM unit 
		msgType : out std_logic_vector (1 downto 0);
		Busy : out std_logic; 
		
		clk: in std_logic;
		rst: in std_logic;	--, enable : in std_logic; 
		AddOKflag : out std_logic;
		d_hk : out std_logic);
	END COMPONENT; 
	
	
	constant PREAMBLE :std_logic_vector (15 downto 0) := "1010101010101010";
	constant HEADER :std_logic_vector (3 downto 0) := "1111";  
	
	signal AUX_CLK : std_logic_vector (0 downto 0);
	signal AUX_CLK_GATED : std_logic_vector (0 downto 0);
	signal main_clk : std_logic;
	signal ready2sleepInput : std_logic;
	signal ff_enabled : std_logic;
	signal wakeup : std_logic := '1';
	
	signal d_hk_lpm : std_logic;

	SIGNAL	mdi  : std_logic := '0';
	SIGNAL	EoM : std_logic := '0';   
	SIGNAL	bit_error  : std_logic := '0';
	SIGNAL	STROBE : std_logic := '0';
	SIGNAL	d_hk_global :  std_logic :='0';
	SIGNAL DATA	:	STD_LOGIC :='0';
	SIGNAL RST	:	STD_LOGIC := '0';
	SIGNAL CLK	:	STD_LOGIC := '0';
	SIGNAL RX	:	STD_LOGIC := '0';
	
	
	SIGNAL MSG	:	STD_LOGIC_VECTOR (40 downto 0) := (others => '0');
	SIGNAL MSG_RX	:	STD_LOGIC_VECTOR (40 downto 0) := (others => '0');
	                                                               --0123456789ABCDEFP
	SIGNAL	R2SINKADD_ParityBit : std_logic_vector (16 downto 0) := "01100110011001100" ; -- network adress del R2SINK
	SIGNAL	NodeAddress : std_logic_vector (15 downto 0) := "0110011001100110";
	
	SIGNAL	dataClean :  std_logic := '0';
	
	SIGNAL	command :  std_logic_vector (1 downto 0) := "00";
	SIGNAL	addressLastBit :  std_logic := '0';
	
	SIGNAL	newMsg :  std_logic; -- nuevo mensaje recibido, newCommand <=> newCommand MoM unit 
	SIGNAL	msgType :  std_logic_vector (1 downto 0);
	SIGNAL	doubleSpeed :  std_logic;
	SIGNAL	Busy :  std_logic; 
	SIGNAL	d_hk_comProc :  std_logic;
	SIGNAL	d_hk_decoder :  std_logic;
	--SIGNAL	iter :  integer :=0;
	SIGNAL	errorRX :  std_logic := '0';
	
	constant clk_period : time := 90.42ns;
	constant HALFBIT : time := 26us;
	constant HALFBIT_L : time := 32us;
	constant HALFBIT_S : time := 20us;
	
BEGIN
	ready2sleepInput <= d_hk_lpm and d_hk_comProc;
   		
   decoder: md_V3 PORT MAP(
		mdi   => RX,
		EoM  => EoM,   
		bit_error => bit_error,
		dout   => DATA,
		new_data  => STROBE,
		rst => RST,  
		clk => main_clk ,  
		d_hk => d_hk_decoder
		);

	
	command_p : command_process  port MAP(
		nodeAddress => nodeAddress, -- network adress del SINK
		din => DATA,-- din <=> dout Manchester decoder
		newData => STROBE, -- newData <=> newData MancheterDecoder
		dataClean => dataClean,
		bitError => bit_error,
		endOfMessage => EoM, -- Fin de mensaje, sea o no el destinatario, endOfMessage <=> [] manchesterDecoder od frequency divider
		newMsg => newMsg, -- nuevo mensaje recibido, newCommand <=> newCommand MoM unit 
		msgType => msgType,
		Busy => Busy, 
		clk => main_clk,
		rst => RST,	--, enable : in std_logic; 
		AddOKflag => open,
		d_hk => d_hk_comProc 
		);
	
	
	clk_p : PROCESS
	BEGIN
		main_clk <= '0'; 
		WAIT FOR clk_period/2; -- will wait forever
		main_clk <= '1'; 
		WAIT FOR clk_period/2;
	END PROCESS;
	
	-- *** Test Bench - User Defined Section ***
	
	desp : PROCESS
	begin
		wait until rising_edge (STROBE) and STROBE = '1';
		MSG_RX<= MSG_RX (39 downto 0) & DATA;
	END PROCESS;
	
	
	d_hk_global <= d_hk_comProc and d_hk_decoder;
	
	-- *** Test Bench - User Defined Section ***
	
	tb : PROCESS
	variable messageType : integer := 0;
	BEGIN
		
		if messageType = 0 then 
			
			RST <= '0';
				
			MSG <= PREAMBLE & HEADER & "10" & "01" & '0' & "0000000000000000";  
			wait for 113us;
						
			RST <= '1';
			wait for 113us;
			
			ShortMSG_Loop : for i in  0 to 24 loop
				RX <= MSG (40-i);
				wait for HALFBIT;
				RX <= not MSG (40-i);	
				wait for HALFBIT;			
			end loop;
			
			RX <= '0';
		
		elsif messageType = 1 then
			
			MSG <= PREAMBLE & HEADER & "00" & "11" & R2SINKADD_ParityBit ;  
			wait for 113us;
			
			LongMSG_Loop : for i in  0 to 40 loop
				RX <= MSG (40-i);
				wait for HALFBIT;
				RX <= not MSG (40-i);	
				wait for HALFBIT;			
			end loop;
						
			RX <= '0';
		
		else
			assert messageType < 2
			report " Fin de la simulacion "
			severity NOTE;
			wait;
		
		end if;	
		
		messageType := messageType + 1; 
		wait for 603us;
		wait  until falling_edge (main_CLK);
		dataClean <= '1';
		wait for clk_period;
		dataClean <= '0';
		
		wait for clk_period*3;
	
	--WAIT; -- will wait forever
	
   END PROCESS;
-- *** End Test Bench - User Defined Section ***
		-- change : PROCESS
	-- variable iter : integer := 0;
	-- begin
	
	-- wait until falling_edge (dataClean);
	-- iter := iter + 1;
	-- if iter = 3 then
		-- errorRX <= '1';
		-- command <= "00";
		-- addressLastBit <= '0';		
	-- else
		-- case iter is
		-- when 0 =>
			-- errorRX <= '0';
			-- command <= "00";	
			-- addressLastBit <= '0';
		
		-- when 1 =>
			-- errorRX <= '0';
			-- command <= "10";	
			-- addressLastBit <= '1';
		
		-- when others =>
			-- errorRX <= '0';
			-- command <= "11";	
			-- addressLastBit <= '1';
		
	 -- end case;	
	-- end if;
	
	-- assert errorRX = '0'
	-- report " Se produce un error, se pierde un bit "
	-- severity NOTE;

	-- END PROCESS;
END;