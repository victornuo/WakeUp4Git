-- Version: 9.1 SP1 9.1.1.7

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity housekeepingCheck is 
  port( Data1 : in std_logic; 
        Data2 : in std_logic; 
        Data3 : in std_logic; 
        Data4 : in std_logic; 
		Data5 : in std_logic;
		Data6 : in std_logic;
		Data7 : in std_logic;
	
        Result : out std_logic) ;
end housekeepingCheck;


architecture DEF_ARCH of  housekeepingCheck is
begin
    Result <= ((((Data1 and Data2)) and Data3) and (Data4 and (Data5 and Data6)) and Data7) ;

end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.1.7
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_AND
-- LPM_HINT:NONE
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor/Documents/Libero Projects/Wur0.1/smartgen\housekeepingCheck
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IS4X4M1LPLV
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- SIZE:8
-- RESULT_POLARITY:1

-- _End_Comments_
