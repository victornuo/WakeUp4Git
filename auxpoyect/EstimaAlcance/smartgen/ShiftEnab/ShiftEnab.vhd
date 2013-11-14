-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity ShiftEnab is 
    port(Shiften, Shiftin, Clock : in std_logic;  Shiftout : out 
        std_logic) ;
end ShiftEnab;


architecture DEF_ARCH of  ShiftEnab is

    component DFN1E1
        port(D, CLK, E : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal DFN1E1_0_Q : std_logic ;
    begin   

    DFN1E1_0 : DFN1E1
      port map(D => Shiftin, CLK => Clock, E => Shiften, Q => 
        DFN1E1_0_Q);
    DFN1E1_Shiftout : DFN1E1
      port map(D => DFN1E1_0_Q, CLK => Clock, E => Shiften, Q => 
        Shiftout);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_DFF
-- LPM_HINT:SISO
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/EstimaAlcance/smartgen\ShiftEnab
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IS4X4M1LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- CLR_POLARITY:2
-- CLR_FANIN:AUTO
-- CLR_VAL:8
-- EN_POLARITY:2
-- EN_FANIN:AUTO
-- EN_VAL:6
-- SHEN_POLARITY:1
-- SHEN_FANIN:AUTO
-- SHEN_VAL:6
-- CLK_EDGE:RISE
-- CLK_FANIN:MANUAL
-- CLK_VAL:1
-- WIDTH:2
-- FF_TYPE:REGULAR

-- _End_Comments_

