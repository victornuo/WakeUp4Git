-- Version: v11.1 11.1.0.14

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity ringO_cnt is

    port( Aclr  : in    std_logic;
          Clock : in    std_logic;
          Q     : out   std_logic_vector(5 downto 0)
        );

end ringO_cnt;

architecture DEF_ARCH of ringO_cnt is 

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal NU_0, NU_1, NU_2, NU_3, NU_4, NU_5, NU_0_1, NU_0_1_2, 
        NU_3_4, NU_3_4_5, INV_2_Y, XOR2_1_Y, AND2_1_Y, XOR2_0_Y, 
        INV_1_Y, INV_0_Y, XOR2_2_Y, AND2_0_Y : std_logic;

begin 

    Q(5) <= NU_5;
    Q(4) <= NU_4;
    Q(3) <= NU_3;
    Q(2) <= NU_2;
    Q(1) <= NU_1;
    Q(0) <= NU_0;

    XOR2_1 : XOR2
      port map(A => NU_5, B => AND2_1_Y, Y => XOR2_1_Y);
    
    AND2_0 : AND2
      port map(A => NU_0, B => NU_1, Y => AND2_0_Y);
    
    DFN1E1C0_NU_1 : DFN1E1C0
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, E => NU_0, 
        Q => NU_1);
    
    INV_0 : INV
      port map(A => NU_3, Y => INV_0_Y);
    
    AND2_1 : AND2
      port map(A => NU_3, B => NU_4, Y => AND2_1_Y);
    
    U_AND2_0_1 : AND2
      port map(A => NU_0, B => NU_1, Y => NU_0_1);
    
    DFN1E1C0_NU_5 : DFN1E1C0
      port map(D => XOR2_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_5);
    
    DFN1C0_NU_2 : DFN1C0
      port map(D => XOR2_2_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_2);
    
    XOR2_0 : XOR2
      port map(A => NU_4, B => NU_3, Y => XOR2_0_Y);
    
    XOR2_2 : XOR2
      port map(A => NU_2, B => AND2_0_Y, Y => XOR2_2_Y);
    
    DFN1C0_NU_0 : DFN1C0
      port map(D => INV_2_Y, CLK => Clock, CLR => Aclr, Q => NU_0);
    
    INV_1 : INV
      port map(A => NU_1, Y => INV_1_Y);
    
    U_AND3_3_4_5 : AND3
      port map(A => NU_3, B => NU_4, C => NU_5, Y => NU_3_4_5);
    
    INV_2 : INV
      port map(A => NU_0, Y => INV_2_Y);
    
    DFN1E1C0_NU_3 : DFN1E1C0
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_3);
    
    U_AND3_0_1_2 : AND3
      port map(A => NU_0, B => NU_1, C => NU_2, Y => NU_0_1_2);
    
    DFN1E1C0_NU_4 : DFN1E1C0
      port map(D => XOR2_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_4);
    
    U_AND2_3_4 : AND2
      port map(A => NU_3, B => NU_4, Y => NU_3_4);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.1.0.14
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LCLP
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_COUNTER
-- LPM_HINT:COMPCNT
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/auxpoyect/testAGL30k/RingOsc_Version3/smartgen\ringO_cnt
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IQ2X1M0LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:6
-- DIRECTION:UP
-- CLR_POLARITY:0
-- LD_POLARITY:2
-- EN_POLARITY:2
-- UPDOWN_POLARITY:2
-- CLK_EDGE:RISE
-- CLR_FANIN:MANUAL
-- CLR_VAL:1
-- CLK_FANIN:MANUAL
-- CLK_VAL:1
-- LD_FANIN:AUTO
-- LD_VAL:12
-- UPDOWN_FANIN:AUTO
-- UPDOWN_VAL:12
-- TCNT_POLARITY:2
-- SET_POLARITY:2
-- SET_FANIN:MANUAL
-- SET_VAL:1

-- _End_Comments_

