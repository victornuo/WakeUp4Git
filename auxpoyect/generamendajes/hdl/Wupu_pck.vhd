--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Wupu_pck is
	
	-- Definici�n de tipos de dato para UART
	-- subtype my_char_type is std_logic_vector(7 downto 0);

	-- type my_msg_string is array (NATURAL  range <>) of my_char_type;
	-- subtype my_atscast is my_msg_string (14 downto 0);
	-- subtype my_ats_command is my_msg_string (11 downto 0);

	-- Constantes mensajes
	
	constant R2SINK : std_logic_vector (1 downto 0) := "00";
	constant NWKRroute : std_logic_vector (1 downto 0) := "01";
	--constant R2SACK : std_logic_vector (1 downto 0) := "11";
	
	-- Declaraci�n de constantes
	constant PREAMBLELENGTH : integer := 16;
	constant ADDRESSLENGTH : integer := 16;
	constant HEADERLENGTH : integer := 4;
	constant COMMANDLENGTH : integer := 2;
	constant PARITYLENGTH : integer := 1;
	constant MSGLENGTH : integer := 41;
	constant FCLK_ENC	: integer := 480000; -- frecuencia del CLK (11.0592 MHZ)
	constant FCLK_DEC	: integer := 480000; -- frecuencia del CLK 
	constant BITTIME_IR	: integer := 600; -- tiempo de bit en us
	constant BITTIME_OOK : integer := 53; --416; -- tiempo de bit en us
	constant ENCODER_REF : integer := 2*(BITTIME_OOK/4) * (FCLK_ENC/10**4);
	constant DECODER_REF : integer := (BITTIME_OOK/8) * (FCLK_DEC/10**4);
	constant RX_ERROR_REF : integer := 12;
	constant BAUDRATE_REF : integer := 19200;
	constant BAUD_VAL : integer := FCLK_ENC/(16*BAUDRATE_REF);
	
  
end;



