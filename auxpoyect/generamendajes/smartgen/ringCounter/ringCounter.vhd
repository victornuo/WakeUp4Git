-- Version: 10.1 SP3 10.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity ringCounter is

    port( Aclr  : in    std_logic;
          Clock : in    std_logic;
          Q     : out   std_logic_vector(3 downto 0)
        );

end ringCounter;

architecture DEF_ARCH of ringCounter is 

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

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
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

    signal NU_0, NU_1, NU_2, NU_3, NU_0_1, NU_0_1_2, INV_1_Y, 
        INV_2_Y, INV_0_Y, XOR2_0_Y, AND2_0_Y : std_logic;

begin 

    Q(3) <= NU_3;
    Q(2) <= NU_2;
    Q(1) <= NU_1;
    Q(0) <= NU_0;

    AND2_0 : AND2
      port map(A => NU_0, B => NU_1, Y => AND2_0_Y);
    
    DFN1E1C0_NU_1 : DFN1E1C0
      port map(D => INV_2_Y, CLK => Clock, CLR => Aclr, E => NU_0, 
        Q => NU_1);
    
    INV_0 : INV
      port map(A => NU_3, Y => INV_0_Y);
    
    U_AND2_0_1 : AND2
      port map(A => NU_0, B => NU_1, Y => NU_0_1);
    
    XOR2_0 : XOR2
      port map(A => NU_2, B => AND2_0_Y, Y => XOR2_0_Y);
    
    DFN1C0_NU_2 : DFN1C0
      port map(D => XOR2_0_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_2);
    
    DFN1C0_NU_0 : DFN1C0
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, Q => NU_0);
    
    INV_1 : INV
      port map(A => NU_0, Y => INV_1_Y);
    
    INV_2 : INV
      port map(A => NU_1, Y => INV_2_Y);
    
    DFN1E1C0_NU_3 : DFN1E1C0
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_3);
    
    U_AND3_0_1_2 : AND3
      port map(A => NU_0, B => NU_1, C => NU_2, Y => NU_0_1_2);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:10.1.3.1
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
-- DESDIR:C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/auxpoyect/generamendajes/smartgen\ringCounter
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:M1IS6X6M2LPLV
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:4
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

