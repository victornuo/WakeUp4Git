--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;


package ASCII_Char is
	
	-- Definición de tipos de dato para UART
	subtype my_char_type is std_logic_vector(7 downto 0);



	-- Constantes mensajes
	
	constant	cA	: my_char_type := "01000001";
	constant	cB	: my_char_type := "01000010";
	constant	cC	: my_char_type := "01000011";
	constant	cD	: my_char_type := "01000100";
	constant	cE	: my_char_type := "01000101";
	constant	cF	: my_char_type := "01000110";
	constant	cG	: my_char_type := "01000111";
	constant	cH	: my_char_type := "01001000";
	constant	cI	: my_char_type := "01001001";
	constant	cJ	: my_char_type := "01001010";
	constant	cK	: my_char_type := "01001011";
	constant	cL	: my_char_type := "01001100";
	constant	cM	: my_char_type := "01001101";
	constant	cN	: my_char_type := "01001110";
	constant	cO	: my_char_type := "01001111";
	constant	cP	: my_char_type := "01010000";
	constant	cQ	: my_char_type := "01010001";
	constant	cR	: my_char_type := "01010010";
	constant	cS	: my_char_type := "01010011";
	constant	cT	: my_char_type := "01010100";
	constant	cU	: my_char_type := "01010101";
	constant	cV	: my_char_type := "01010110";
	constant	cW	: my_char_type := "01010111";
	constant	cX	: my_char_type := "01011000";
	constant	cY	: my_char_type := "01011001";
	constant	cZ	: my_char_type := "01011010";
	constant	a	: my_char_type := "01100001";
	constant	b	: my_char_type := "01100010";
	constant	c	: my_char_type := "01100011";
	constant	d	: my_char_type := "01100100";
	constant	e	: my_char_type := "01100101";
	constant	f	: my_char_type := "01100110";
	constant	g	: my_char_type := "01100111";
	constant	h	: my_char_type := "01101000";
	constant	i	: my_char_type := "01101001";
	constant	j	: my_char_type := "01101010";
	constant	k	: my_char_type := "01101011";
	constant	l	: my_char_type := "01101100";
	constant	m	: my_char_type := "01101101";
	constant	n	: my_char_type := "01101110";
	constant	o	: my_char_type := "01101111";
	constant	p	: my_char_type := "01110000";
	constant	q	: my_char_type := "01110001";
	constant	r	: my_char_type := "01110010";
	constant	s	: my_char_type := "01110011";
	constant	t	: my_char_type := "01110100";
	constant	u	: my_char_type := "01110101";
	constant	v	: my_char_type := "01110110";
	constant	w	: my_char_type := "01110111";
	constant	x	: my_char_type := "01111000";
	constant	y	: my_char_type := "01111001";
	constant	z	: my_char_type := "01111010";
	
	constant	c_CR			: my_char_type := "00001101";
	constant	c_colon 		: my_char_type := "00111010";
	constant	c_coma		: my_char_type := "00101100";
	constant	c_eq			: my_char_type := "00111101";
	constant	c_question	: my_char_type := "00111111";
	constant	c_adds		: my_char_type := "00101011";
	constant 	c_ETX : my_char_type := "00000011";
	constant 	c_STX : my_char_type := "00000010";
	constant 	c_NULL : my_char_type :="00000001";
	
	constant	c_0	: my_char_type := "00110000";
	constant	c_1	: my_char_type := "00110001";
	constant	c_2	: my_char_type := "00110010";
	constant	c_3	: my_char_type := "00110011";
	constant	c_4	: my_char_type := "00110100";
	constant	c_5	: my_char_type := "00110101";
	constant	c_6	: my_char_type := "00110110";
	constant	c_7	: my_char_type := "00110111";
	constant	c_8	: my_char_type := "00111000";
	constant	c_9	: my_char_type := "00111001";




	
  
end;



