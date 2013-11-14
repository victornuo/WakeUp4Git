-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity IOreg is 
    port(Data, Aclr, Clock : in std_logic;  Q : out std_logic) ;
end IOreg;


architecture DEF_ARCH of  IOreg is

    component INV
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component DFN1C1
        port(D, CLK, CLR : in std_logic := 'U'; Q : out std_logic
        ) ;
    end component;

    signal ClrAux_0_net : std_logic ;
    begin   

    INV_ClrAux_0_inst : INV
      port map(A => Aclr, Y => ClrAux_0_net);
    DFN1C1_Q : DFN1C1
      port map(D => Data, CLK => Clock, CLR => ClrAux_0_net, Q => 
        Q);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_DFF
-- LPM_HINT:PIPO
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/EstimaAlcance/smartgen\IOreg
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IS4X4M1LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- CLR_POLARITY:0
-- CLR_FANIN:AUTO
-- CLR_VAL:8
-- EN_POLARITY:2
-- EN_FANIN:AUTO
-- EN_VAL:6
-- CLK_EDGE:RISE
-- CLK_FANIN:MANUAL
-- CLK_VAL:1
-- WIDTH:1
-- FF_TYPE:REGULAR
-- SET_POLARITY:2
-- SET_FANIN:AUTO
-- SET_VAL:8
-- OUTPUTS:1

-- _End_Comments_

