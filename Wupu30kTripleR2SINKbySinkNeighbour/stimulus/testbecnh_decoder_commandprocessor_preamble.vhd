LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

use work.wupu_pck.all;

ENTITY TB_MD_CommP_Pre IS
END TB_MD_CommP_Pre;

ARCHITECTURE behavioral OF TB_MD_CommP_Pre IS 

   
	
   COMPONENT md_v5
	--generic ( ERROR_TIME : integer := RX_ERROR_REF); 
	port(  
		mdi  : in std_logic;
		bit_error  : out std_logic;
		RX_end : out std_logic;
		dout  : out std_logic;
		new_data : out std_logic;
		rstn: in std_logic ;
		d_hk : out std_logic;
		clk: in std_logic  
		
	) ;
   END COMPONENT;

   
   COMPONENT command_process
	port (
		nodeAddress : in std_logic_vector (ADDRESSLENGTH-1 downto 0); -- network adress del SINK
		din : in std_logic ; -- din <=> dout Manchester decoder
		newData : in std_logic; -- newData <=> newData MancheterDecoder
		dataClean : in std_logic;
		bitError : in std_logic;
		
		
		newMsg : out std_logic; -- nuevo mensaje recibido, newMsg <=> newMsg MoM unit 
		msgType : out std_logic_vector (1 downto 0);
		--Busy : out std_logic; 
		
		clk: in std_logic;
		rstn: in std_logic;	--, enable : in std_logic; 
		AddOKflag : out std_logic;
		d_hk : out std_logic);
			
	END COMPONENT; 
	
	

	constant NodeAddress : std_logic_vector (ADDRESSLENGTH-1 downto 0) := "10100100";
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
	SIGNAL RX_real	:	STD_LOGIC := '0';
	SIGNAL interference	:	STD_LOGIC := '0';
	SIGNAL interference_sel	:	STD_LOGIC := '0';
	
	SIGNAL MSG	:	STD_LOGIC_VECTOR (32 downto 0) := (others => '0');
	SIGNAL MSG_RX	:	STD_LOGIC_VECTOR (32 downto 0) := (others => '0');
	                                                               --0123456789ABCDEFP
	SIGNAL	R2SINKADD_ParityBit : std_logic_vector (ADDRESSLENGTH downto 0) := NodeAddress & '0' ; -- numero de ceros par
	--SIGNAL	NodeAddress : std_logic_vector (ADDRESSLENGTH-1 downto 0) := "01100110";
	
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
	
	constant clk_period : time := 833.3 ns;
	constant HALFBIT : time := 38 us;
	constant HALFBIT_L : time := 32us;
	constant HALFBIT_S : time := 20us;
	
BEGIN
	ready2sleepInput <= d_hk_lpm and d_hk_comProc;
   		
   decoder: md_V5 PORT MAP(
		mdi   => RX_real,
		RX_end  => EoM,   
		bit_error => bit_error,
		dout   => DATA,
		new_data  => STROBE,
		rstn => RST,  
		clk => main_clk ,  
		d_hk => d_hk_decoder
		
		
		);

	
	command_p : command_process  port MAP(
		nodeAddress => nodeAddress, -- network adress del SINK
		din => DATA,-- din <=> dout Manchester decoder
		newData => STROBE, -- newData <=> newData MancheterDecoder
		dataClean => dataClean,
		bitError => bit_error,
		newMsg => newMsg, -- nuevo mensaje recibido, newCommand <=> newCommand MoM unit 
		msgType => msgType,
		clk => main_clk,
		rstn => RST,	--, enable : in std_logic; 
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
	
	RX_real <= RX when interference_sel = '0' else interference;
	
	interferece_gen : PROCESS
	BEGIN
		
		wait for 1.5 ms;
		interference_sel <= '1' ;
		interference <= '1';
		
		wait for 150 us;
		interference_sel <= '1' ;
		
		wait for 737 us;
		--wait for 2.5 ms;
		interference_sel <= '1' ;
		wait for 150 us;
		interference_sel <= '0' ;
		
		wait;
	END PROCESS;
	
	
	-- *** Test Bench - User Defined Section ***
	
	desp : PROCESS
	begin
		wait until rising_edge (STROBE) and STROBE = '1';
		MSG_RX<= MSG_RX (31 downto 0) & DATA;
	END PROCESS;
	
	
	d_hk_global <= d_hk_comProc and d_hk_decoder;
	
	-- *** Test Bench - User Defined Section ***
	
	tb : PROCESS
	variable messageType : integer := 0;
	BEGIN
		
		if messageType = 0 then 
			
			RST <= '0';
				
			MSG <= PREAMBLE & PREAMBLE & MSGHEADER & "10" & "01" & '1' & "00000000";  
			wait for 113us;
						
			RST <= '1';
			wait for 113us;
			
			ShortMSG_Loop : for i in  0 to 24 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
				wait for HALFBIT;			
			end loop;
			ShortMSG_2nd : for i in  16 to 24 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
				wait for HALFBIT;			
			end loop;
			ShortMSG_3rd : for i in  16 to 24 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
				wait for HALFBIT;			
			end loop;
			
			RX <= '0';
		
		elsif messageType = 1 then
			
			MSG <= PREAMBLE & PREAMBLE & MSGHEADER & "11" & "00" & R2SINKADD_ParityBit ;  
			wait for 113us;
			
			LongMSG_Loop : for i in  0 to 32 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
				wait for HALFBIT;			
			end loop;
			
			LongMSG_second : for i in  16 to 32 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
				wait for HALFBIT;			
			end loop;
			
			LongMSG_third : for i in  16 to 32 loop
				RX <= MSG (32-i);
				wait for HALFBIT;
				RX <= not MSG (32-i);	
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