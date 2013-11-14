--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Wupu_pck is
	
	-- Definición de tipos de dato para UART
	-- subtype my_char_type is std_logic_vector(7 downto 0);

	-- type my_msg_string is array (NATURAL  range <>) of my_char_type;
	-- subtype my_atscast is my_msg_string (14 downto 0);
	-- subtype my_ats_command is my_msg_string (11 downto 0);

	-- Constantes mensajes
	
	constant R2SINK : std_logic_vector (1 downto 0) := "00";
	constant NWKRroute : std_logic_vector (1 downto 0) := "01";
	--constant R2SACK : std_logic_vector (1 downto 0) := "11";
	
	-- Declaración de constantes
	constant PREAMBLELENGTH : integer := 8;
	constant HEADERLENGTH : integer := 4;
	constant COMMANDLENGTH : integer := 4;
	constant CONSECUTIVEMSGS : integer := 3;
	constant ADDRESSLENGTH : integer := 8;
	constant FORWARDS : integer := 3; -- veces q se envia el comando en un mensaje para aumentar las probabilidades de exito
	constant MAXRETRIES : integer := 3; -- en caso de no recivir el indirect ACK las veces q se reenvia el mensaje
	constant PARITYLENGTH : integer := 1;
	--constant MSGLENGTH : integer := 33;
	constant MEILENGTH : integer := 8; -- manchester encoder input
	
	 -- CONTION 5% DE BIT TIME
	
	constant FTIMEOUTACK	: integer := 200; -- frecuencia del TIMEOUTACK(200 HZ --> T 5ms)
	constant FCLK	: integer := 1400000; -- frecuencia del CLK (11.0592 MHZ)
	
	constant FCLK_ENC	: integer := 1250000; -- frecuencia del CLK 2
	constant FCLK_DEC	: integer := 1250000; -- frecuencia del CLK 
	constant FCLK_R	: real := 1.25; -- frecuencia del CLK 
	constant BITTIME_IR	: integer := 600; -- tiempo de bit en us
	constant BITTIME_OOK : integer := 76; --416; -- tiempo de bit en us
	constant BITTIME_OOK_R : real := 76.0; --416; -- tiempo de bit en us
	constant ENCODER_REF : integer := integer((BITTIME_OOK_R/2.0) * (FCLK_R));
	constant DECODER_REF : integer := integer((BITTIME_OOK_R/8.0) * (FCLK_R))+1;
	
	constant RX_ERROR_REF : integer := 12;--17; -- DECODER FREQ = BIT_TIME/8 --> ERROR_REF * DECODER FREQ = 1.5 * BIT_TIME
	
	--constant CHANNELFREE_TIME_R	: real :=  (1.1*BITTIME_OOK_R*FCLK_R);--FCLK_ENC); -- BITTIME + 5 % PARA CHANNEL FREE 882;
	
	constant PREAMBLE :std_logic_vector (PREAMBLELENGTH-1 downto 0) := "01010101";
	constant MSGHEADER :std_logic_vector (HEADERLENGTH-1 downto 0) := "0000";
	constant HEADERBIT : std_logic := MSGHEADER(0);
	constant CONTENTION_TIME_R	: real := ((BITTIME_OOK_R)*FCLK_R*(1.25));	--'0' 
	constant CONTENTION_TIME	: integer := integer( CONTENTION_TIME_R) + 1;	--'0' 
	-- constant BAUDRATE_REF : integer := 19200;
	-- constant BAUD_VAL : integer := FCLK_ENC/(16*BAUDRATE_REF);
	
  
end;



