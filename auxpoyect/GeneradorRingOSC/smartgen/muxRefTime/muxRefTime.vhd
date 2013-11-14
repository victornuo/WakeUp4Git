-- Version: 10.1 SP3 10.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity muxRefTime is

    port( Data0_port : in    std_logic;
          Data1_port : in    std_logic;
          Data2_port : in    std_logic;
          Data3_port : in    std_logic;
          Sel0       : in    std_logic;
          Sel1       : in    std_logic;
          Result     : out   std_logic
        );

end muxRefTime;

architecture DEF_ARCH of muxRefTime is 

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal MX2_1_Y, MX2_0_Y : std_logic;

begin 


    MX2_0 : MX2
      port map(A => Data2_port, B => Data3_port, S => Sel0, Y => 
        MX2_0_Y);
    
    MX2_Result : MX2
      port map(A => MX2_1_Y, B => MX2_0_Y, S => Sel1, Y => Result);
    
    MX2_1 : MX2
      port map(A => Data0_port, B => Data1_port, S => Sel0, Y => 
        MX2_1_Y);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.1.3.1
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LCLP
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_MUX
-- LPM_HINT:None
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/auxpoyect/GeneradorRingOSC/smartgen\muxRefTime
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:M1IS6X6M2LPLV
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:1
-- SIZE:4
-- SEL0_FANIN:AUTO
-- SEL0_VAL:6
-- SEL0_POLARITY:1
-- SEL1_FANIN:AUTO
-- SEL1_VAL:6
-- SEL1_POLARITY:2
-- SEL2_FANIN:AUTO
-- SEL2_VAL:6
-- SEL2_POLARITY:2
-- SEL3_FANIN:AUTO
-- SEL3_VAL:6
-- SEL3_POLARITY:2
-- SEL4_FANIN:AUTO
-- SEL4_VAL:6
-- SEL4_POLARITY:2

-- _End_Comments_

