--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package virtex5_pck is
	
	--Declaración de la función de dividir
  function dividir(numero:std_logic_vector) return std_logic_vector;
  
  

  -- Definición de tipos de dato
  type matrix_row  is array (0 to 48) of std_logic_vector(12 downto 0); -- (t/b,row,numero de frames)
  type fpga_matrix is array (0 to 7) of matrix_row;
  type division is array (6 downto 0) of std_logic_vector(8 downto 0);
    
   -- Declaración de constantes para la división
  constant divisors	: division:=
							("100011000","011110000","011001000","010100000","001111000","001010000","000101000");
  constant results	: division:=
							("000000111","000000110","000000101","000000100","000000011","000000010","000000001");
    

  -- Declaración de constantes de la dirección

  constant top			: std_logic := '0';
  constant bottom		: std_logic := '1';
  constant row0		: std_logic_vector(4 downto 0) := "00000";
  constant row1		: std_logic_vector(4 downto 0) := "00001";
  constant row2		: std_logic_vector(4 downto 0) := "00010";
  constant row3		: std_logic_vector(4 downto 0) := "00011";
  constant CLB			: std_logic_vector(6 downto 0) := "0100100";--36;
  constant DSP			: std_logic_vector(6 downto 0) := "0011100";--28;
  constant BRAM		: std_logic_vector(6 downto 0) := "0011110";--30;
  constant IOBlock	: std_logic_vector(6 downto 0) := "0110110";--54;
  constant Clk_Col	: std_logic_vector(6 downto 0) := "0000100";--4;
  constant forbidden	: std_logic_vector(6 downto 0) := "0000000";--0;
  
  
	--Filas de la matriz
  
	constant matrix_row0: matrix_row:= (bottom&row3&IOBlock,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&BRAM,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&BRAM,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&BRAM,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&IOBlock,bottom&row3&Clk_Col,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&BRAM,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&DSP,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&DSP,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&BRAM,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&IOBlock,
								bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB,bottom&row3&CLB);
								
	constant matrix_row1: matrix_row:= (bottom&row2&IOBlock,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&BRAM,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&BRAM,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&BRAM,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&IOBlock,bottom&row2&Clk_Col,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&BRAM,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&DSP,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&DSP,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&BRAM,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&IOBlock,
								bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB,bottom&row2&CLB);	
  
   constant matrix_row2: matrix_row:= (bottom&row1&IOBlock,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&BRAM,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&BRAM,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&BRAM,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&IOBlock,bottom&row1&Clk_Col,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&BRAM,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&DSP,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&DSP,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&BRAM,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&IOBlock,
								bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB,bottom&row1&CLB);
								
	constant matrix_row3: matrix_row:= (bottom&row0&IOBlock,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&BRAM,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,
								bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,
								bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&forbidden,bottom&row0&IOBlock,bottom&row0&Clk_Col,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&BRAM,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&DSP,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&DSP,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&BRAM,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&IOBlock,
								bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB,bottom&row0&CLB);
								
	constant matrix_row4: matrix_row:= (top&row0&IOBlock,top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&BRAM,
								top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,
								top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,
								top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&forbidden,top&row0&IOBlock,top&row0&Clk_Col,
								top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&BRAM,
								top&row0&CLB,top&row0&CLB,top&row0&DSP,top&row0&CLB,top&row0&CLB,top&row0&DSP,
								top&row0&CLB,top&row0&CLB,top&row0&BRAM,
								top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&IOBlock,
								top&row0&CLB,top&row0&CLB,top&row0&CLB,top&row0&CLB);
								
	constant matrix_row5: matrix_row:= (top&row1&IOBlock,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&BRAM,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&BRAM,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&BRAM,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&IOBlock,top&row1&Clk_Col,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&BRAM,
								top&row1&CLB,top&row1&CLB,top&row1&DSP,top&row1&CLB,top&row1&CLB,top&row1&DSP,
								top&row1&CLB,top&row1&CLB,top&row1&BRAM,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&IOBlock,
								top&row1&CLB,top&row1&CLB,top&row1&CLB,top&row1&CLB);
								
	constant matrix_row6: matrix_row:= (top&row2&IOBlock,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&BRAM,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&BRAM,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&BRAM,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&IOBlock,top&row2&Clk_Col,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&BRAM,
								top&row2&CLB,top&row2&CLB,top&row2&DSP,top&row2&CLB,top&row2&CLB,top&row2&DSP,
								top&row2&CLB,top&row2&CLB,top&row2&BRAM,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&IOBlock,
								top&row2&CLB,top&row2&CLB,top&row2&CLB,top&row2&CLB);
								
	constant matrix_row7: matrix_row:= (top&row3&IOBlock,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&BRAM,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&BRAM,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&BRAM,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&IOBlock,top&row3&Clk_Col,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&BRAM,
								top&row3&CLB,top&row3&CLB,top&row3&DSP,top&row3&CLB,top&row3&CLB,top&row3&DSP,
								top&row3&CLB,top&row3&CLB,top&row3&BRAM,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&IOBlock,
								top&row3&CLB,top&row3&CLB,top&row3&CLB,top&row3&CLB);
								
	-- Fin de las filas
	
	--Declaración de la matriz
	
	constant matrix :fpga_matrix:= (matrix_row0,matrix_row1,matrix_row2,matrix_row3,matrix_row4,matrix_row5,matrix_row6,matrix_row7);



	--Declaración de instrucciones para el ICAP
	constant dummy: std_logic_vector(0 to 31) :="11111111111111111111111111111111";
	constant sync : std_logic_vector(0 to 31) :="10101010100110010101010101100110";
	constant noop : std_logic_vector(0 to 31) :="00100000000000000000000000000000";
	constant cor  : std_logic_vector(0 to 31) :="00110000000000010010000000000001";
		constant crc_bypass: std_logic_vector(0 to 31) :=	"00010000000001000010111111011101";
	constant id   : std_logic_vector(0 to 31) :="00110000000000011000000000000001";
		constant idcode:std_logic_vector(0 to 31) :=		"00000011001011000110000010010011";
	constant far  : std_logic_vector(0 to 31) :="00110000000000000010000000000001";
		constant pack_far:std_logic_vector(0 to 31):=		"00000000000000011001000010000000";
	constant fdri1: std_logic_vector(0 to 31) :="00110000000000000100000000000000"; --¡Cuidado: no se especifica el número de palabras por si hace falta un tipo 2!
	constant fdri2: std_logic_vector(0 to 31) :="01010000000000000000000000000000"; --Hay que especificar el número de palabras a escribir
	constant fdro : std_logic_vector(0 to 31) :="00101000000000000110000000000000";
	constant crc  : std_logic_vector(0 to 31) :="00110000000000000000000000000001";
		constant disabled_auto_crc: std_logic_vector(0 to 31):="00000000000000001101111011111100";
	constant cmd  : std_logic_vector(0 to 31) :="00110000000000001000000000000001";
		constant cmd_rcrc: std_logic_vector(0 to 31):=		"00000000000000000000000000000111";
		constant cmd_wcfg: std_logic_vector(0 to 31):=		"00000000000000000000000000000001";
		constant cmd_rcfg: std_logic_vector(0 to 31):=		"00000000000000000000000000000100";
		constant cmd_grestore: std_logic_vector(0 to 31):="00000000000000000000000000001010";
		constant cmd_desynch: std_logic_vector(0 to 31):=	"00000000000000000000000000001101";
	constant stat: std_logic_vector(0 to 31):=	"00101000000000001110000000000001"; 
	constant bus_width_word : std_logic_vector(0 to 31) :="00000000000000000000000010111011";
		constant bus_width : std_logic_vector(0 to 31)	:="00010001001000100000000001000100";
	
	--Declaración de tamaños de cabeceras y colas
	constant RH_length : integer := 6;
	constant RT_length : integer := 2;
	constant WH_length : integer := 16;
	constant WT_length : integer := 64;
	--Declaración de cabecera y cola de los bitstreams
	type RH is array(0 to RH_length-1) of std_logic_vector(0 to 31);
	constant read_header: RH :=(dummy,sync,cmd,cmd_rcrc,cmd,cmd_rcfg);
	type RT is array(0 to RT_length) of std_logic_vector(0 to 31);
	constant read_tail : RT :=(cmd,cmd_desynch,noop);	--El último dummy no llega al ICAP
	type WH is array(0 to WH_length-1) of std_logic_vector(0 to 31);
	constant write_header: WH :=(dummy,bus_width_word,bus_width,sync,noop,noop,cmd,cmd_rcrc,noop,noop,cor,crc_bypass,id,idcode,cmd,cmd_wcfg);
	type WT is array(0 to WT_length) of std_logic_vector(0 to 31);
	constant write_tail: WT := (fdri1 or "00000000000000000000000000101001",noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,crc,disabled_auto_crc,far,pack_far,crc,disabled_auto_crc,cmd,cmd_desynch,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop,noop);
	
end;

package body virtex5_pck is
	function dividir(numero:std_logic_vector) return std_logic_vector is
	begin
		if numero>="100011000" then return "000000111"; --7
		elsif numero>="011110000" then return "000000110";--6 
		elsif numero>="011001000" then return "000000101";--5
		elsif numero>="010100000" then return "000000100";--4
		elsif numero>="001111000" then return "000000011";--3
		elsif numero>="001010000" then return "000000010";--2
		elsif numero>="000101000" then return "000000001";--1
		else return "000000000";--0
		end if;
	end function;
end package body;



