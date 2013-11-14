-- Version: v11.1 SP3 11.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity CuentaEnvios is

    port( Aclr   : in    std_logic;
          Clock  : in    std_logic;
          Tcnt   : out   std_logic;
          Q      : out   std_logic_vector(8 downto 0);
          Enable : in    std_logic
        );

end CuentaEnvios;

architecture DEF_ARCH of CuentaEnvios is 

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

    signal NU_1, NU_2, NU_3, NU_4, NU_5, NU_6, NU_7, NU_8, NU_9, 
        NU_0_1, NU_1_2, NU_0_1_2, NU_3_4, NU_3_4_5, NU_6_7, 
        NU_6_7_8, NU_1_to_8, NU_0_to_8, XOR2_4_Y, AND2_1_Y, 
        INV_0_Y, XOR2_3_Y, XOR2_2_Y, AND2_4_Y, INV_1_Y, XOR2_5_Y, 
        AND2_0_Y, XOR2_0_Y, AND2_3_Y, XOR2_1_Y, AND2_2_Y, INV_2_Y
         : std_logic;

begin 

    Q(8) <= NU_9;
    Q(7) <= NU_8;
    Q(6) <= NU_7;
    Q(5) <= NU_6;
    Q(4) <= NU_5;
    Q(3) <= NU_4;
    Q(2) <= NU_3;
    Q(1) <= NU_2;
    Q(0) <= NU_1;

    XOR2_1 : XOR2
      port map(A => NU_6, B => AND2_2_Y, Y => XOR2_1_Y);
    
    AND2_0 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_0_Y);
    
    DFN1E1C0_NU_9 : DFN1E1C0
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_9);
    
    XOR2_4 : XOR2
      port map(A => NU_5, B => AND2_1_Y, Y => XOR2_4_Y);
    
    DFN1E1C0_NU_1 : DFN1E1C0
      port map(D => INV_2_Y, CLK => Clock, CLR => Aclr, E => 
        Enable, Q => NU_1);
    
    AND2_4 : AND2
      port map(A => Enable, B => NU_1, Y => AND2_4_Y);
    
    XOR2_5 : XOR2
      port map(A => NU_7, B => AND2_0_Y, Y => XOR2_5_Y);
    
    AND2_3 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_3_Y);
    
    INV_0 : INV
      port map(A => NU_3, Y => INV_0_Y);
    
    DFN1C0_NU_6 : DFN1C0
      port map(D => XOR2_1_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_6);
    
    AND2_1 : AND2
      port map(A => NU_3, B => NU_4, Y => AND2_1_Y);
    
    U_AND2_0_1 : AND2
      port map(A => Enable, B => NU_1, Y => NU_0_1);
    
    DFN1E1C0_NU_7 : DFN1E1C0
      port map(D => XOR2_5_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6, Q => NU_7);
    
    DFN1E1C0_NU_5 : DFN1E1C0
      port map(D => XOR2_4_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_5);
    
    XOR2_0 : XOR2
      port map(A => NU_8, B => AND2_3_Y, Y => XOR2_0_Y);
    
    DFN1C0_NU_2 : DFN1C0
      port map(D => XOR2_2_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_2);
    
    XOR2_2 : XOR2
      port map(A => NU_2, B => AND2_4_Y, Y => XOR2_2_Y);
    
    U_AND2_Tcnt : AND2
      port map(A => NU_1_to_8, B => NU_9, Y => Tcnt);
    
    U_U_AND3_0_to_8 : AND3
      port map(A => NU_0_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_0_to_8);
    
    INV_1 : INV
      port map(A => NU_9, Y => INV_1_Y);
    
    U_U_AND3_1_to_8 : AND3
      port map(A => NU_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_1_to_8);
    
    U_AND3_3_4_5 : AND3
      port map(A => NU_3, B => NU_4, C => NU_5, Y => NU_3_4_5);
    
    U_AND2_6_7 : AND2
      port map(A => NU_6, B => NU_7, Y => NU_6_7);
    
    AND2_2 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_2_Y);
    
    XOR2_3 : XOR2
      port map(A => NU_4, B => NU_3, Y => XOR2_3_Y);
    
    INV_2 : INV
      port map(A => NU_1, Y => INV_2_Y);
    
    DFN1E1C0_NU_3 : DFN1E1C0
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_3);
    
    U_AND3_0_1_2 : AND3
      port map(A => Enable, B => NU_1, C => NU_2, Y => NU_0_1_2);
    
    U_AND3_6_7_8 : AND3
      port map(A => NU_6, B => NU_7, C => NU_8, Y => NU_6_7_8);
    
    DFN1E1C0_NU_8 : DFN1E1C0
      port map(D => XOR2_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6_7, Q => NU_8);
    
    U_AND2_1_2 : AND2
      port map(A => NU_1, B => NU_2, Y => NU_1_2);
    
    DFN1E1C0_NU_4 : DFN1E1C0
      port map(D => XOR2_3_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_4);
    
    U_AND2_3_4 : AND2
      port map(A => NU_3, B => NU_4, Y => NU_3_4);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.1.3.1
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
-- DESDIR:C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/Wupu30K-InitializationwithR2SINK/smartgen\CuentaEnvios
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IQ2X1M0LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:9
-- DIRECTION:UP
-- CLR_POLARITY:0
-- LD_POLARITY:2
-- EN_POLARITY:1
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
-- TCNT_POLARITY:1
-- SET_POLARITY:2
-- SET_FANIN:MANUAL
-- SET_VAL:1

-- _End_Comments_

