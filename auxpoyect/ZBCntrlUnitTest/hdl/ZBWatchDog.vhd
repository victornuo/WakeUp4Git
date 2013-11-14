-- Version: 10.1 SP3 10.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity ZBWatchDog is

    port( Aclr   : in    std_logic;
          Clock  : in    std_logic;
          Tcnt   : out   std_logic;
          Q      : out   std_logic_vector(25 downto 0);
          Enable : in    std_logic
        );

end ZBWatchDog;

architecture DEF_ARCH of ZBWatchDog is 

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1C1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1C1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

    signal NU_1, NU_2, NU_3, NU_4, NU_5, NU_6, NU_7, NU_8, NU_9, 
        NU_10, NU_11, NU_12, NU_13, NU_14, NU_15, NU_16, NU_17, 
        NU_18, NU_0_1, NU_1_2, NU_0_1_2, NU_3_4, NU_3_4_5, NU_6_7, 
        NU_6_7_8, NU_9_10, NU_9_10_11, NU_12_13, NU_12_13_14, 
        NU_15_16, NU_15_16_17, NU_18_19, NU_1_to_8, NU_0_to_8, 
        NU_9_to_17, NU_9_to_14, N_Tcnt_Stg1, NU_19, XOR2_4_Y, 
        AND2_8_Y, XOR2_5_Y, AND2_1_Y, XOR2_11_Y, XOR2_12_Y, 
        AND2_3_Y, XOR2_14_Y, AND2_0_Y, XOR2_0_Y, AND2_11_Y, 
        XOR2_9_Y, AND2_6_Y, XOR2_1_Y, INV_1_Y, XOR2_13_Y, 
        AND2_5_Y, XOR2_6_Y, AND2_10_Y, INV_0_Y, XOR2_7_Y, 
        AND2_4_Y, INV_2_Y, XOR2_8_Y, XOR2_2_Y, AND2_2_Y, 
        XOR2_10_Y, AND2_12_Y, XOR2_15_Y, AND2_7_Y, XOR2_3_Y, 
        AND2_9_Y : std_logic;

begin 

    Q(18) <= NU_19;
    Q(17) <= NU_18;
    Q(16) <= NU_17;
    Q(15) <= NU_16;
    Q(14) <= NU_15;
    Q(13) <= NU_14;
    Q(12) <= NU_13;
    Q(11) <= NU_12;
    Q(10) <= NU_11;
    Q(9) <= NU_10;
    Q(8) <= NU_9;
    Q(7) <= NU_8;
    Q(6) <= NU_7;
    Q(5) <= NU_6;
    Q(4) <= NU_5;
    Q(3) <= NU_4;
    Q(2) <= NU_3;
    Q(1) <= NU_2;
    Q(0) <= NU_1;

    AND2_9 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_9_Y);
    
    AND2_11 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_11_Y);
    
    DFN1E1C1_NU_19 : DFN1E1C1
      port map(D => XOR2_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18, Q => NU_19);
    
    DFN1E1C1_NU_5 : DFN1E1C1
      port map(D => XOR2_9_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_5);
    
    XOR2_9 : XOR2
      port map(A => NU_5, B => AND2_6_Y, Y => XOR2_9_Y);
    
    AND2_12 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_12_Y);
    
    U_AND2_0_1 : AND2
      port map(A => Enable, B => NU_1, Y => NU_0_1);
    
    XOR2_1 : XOR2
      port map(A => NU_12, B => NU_9_10_11, Y => XOR2_1_Y);
    
    XOR2_15 : XOR2
      port map(A => NU_13, B => AND2_7_Y, Y => XOR2_15_Y);
    
    U_AND2_Tcnt_2 : AND2
      port map(A => NU_19, B => N_Tcnt_Stg1, Y => Tcnt);
    
    XOR2_10 : XOR2
      port map(A => NU_18, B => AND2_12_Y, Y => XOR2_10_Y);
    
    DFN1E1C1_NU_8 : DFN1E1C1
      port map(D => XOR2_3_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6_7, Q => NU_8);
    
    U_AND2_9_10 : AND2
      port map(A => NU_9, B => NU_10, Y => NU_9_10);
    
    AND2_0 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_14, Y => AND2_0_Y);
    
    XOR2_7 : XOR2
      port map(A => NU_14, B => AND2_4_Y, Y => XOR2_7_Y);
    
    DFN1E1C1_NU_13 : DFN1E1C1
      port map(D => XOR2_15_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_13);
    
    U_AND2_12_13 : AND2
      port map(A => NU_12, B => NU_13, Y => NU_12_13);
    
    INV_1 : INV
      port map(A => NU_9, Y => INV_1_Y);
    
    AND2_2 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => AND2_2_Y);
    
    U_AND3_12_13_14 : AND3
      port map(A => NU_12, B => NU_13, C => NU_14, Y => 
        NU_12_13_14);
    
    DFN1E1C1_NU_12 : DFN1E1C1
      port map(D => XOR2_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_12);
    
    AND2_8 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_8_Y);
    
    AND2_5 : AND2
      port map(A => NU_9, B => NU_10, Y => AND2_5_Y);
    
    AND2_4 : AND2
      port map(A => NU_9_10_11, B => NU_12_13, Y => AND2_4_Y);
    
    AND2_1 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_14, Y => AND2_1_Y);
    
    AND2_3 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_3_Y);
    
    DFN1C1_NU_6 : DFN1C1
      port map(D => XOR2_4_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_6);
    
    AND2_7 : AND2
      port map(A => NU_9_10_11, B => NU_12, Y => AND2_7_Y);
    
    U_AND2_1_2 : AND2
      port map(A => NU_1, B => NU_2, Y => NU_1_2);
    
    DFN1E1C1_NU_15 : DFN1E1C1
      port map(D => XOR2_2_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_15);
    
    DFN1E1C1_NU_7 : DFN1E1C1
      port map(D => XOR2_12_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6, Q => NU_7);
    
    DFN1E1C1_NU_3 : DFN1E1C1
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_3);
    
    U_AND3_6_7_8 : AND3
      port map(A => NU_6, B => NU_7, C => NU_8, Y => NU_6_7_8);
    
    XOR2_12 : XOR2
      port map(A => NU_7, B => AND2_3_Y, Y => XOR2_12_Y);
    
    XOR2_3 : XOR2
      port map(A => NU_8, B => AND2_9_Y, Y => XOR2_3_Y);
    
    AND2_6 : AND2
      port map(A => NU_3, B => NU_4, Y => AND2_6_Y);
    
    U_AND2_6_7 : AND2
      port map(A => NU_6, B => NU_7, Y => NU_6_7);
    
    DFN1E1C1_NU_11 : DFN1E1C1
      port map(D => XOR2_13_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_11);
    
    U_U_AND3_1_to_8 : AND3
      port map(A => NU_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_1_to_8);
    
    U_AND3_9_10_11 : AND3
      port map(A => NU_9, B => NU_10, C => NU_11, Y => NU_9_10_11);
    
    U_AND3_3_4_5 : AND3
      port map(A => NU_3, B => NU_4, C => NU_5, Y => NU_3_4_5);
    
    INV_2 : INV
      port map(A => NU_1, Y => INV_2_Y);
    
    U_AND3_0_1_2 : AND3
      port map(A => Enable, B => NU_1, C => NU_2, Y => NU_0_1_2);
    
    XOR2_0 : XOR2
      port map(A => NU_19, B => AND2_11_Y, Y => XOR2_0_Y);
    
    AND2_10 : AND2
      port map(A => Enable, B => NU_1, Y => AND2_10_Y);
    
    DFN1E1C1_NU_17 : DFN1E1C1
      port map(D => XOR2_14_Y, CLK => Clock, CLR => Aclr, E => 
        NU_15_16, Q => NU_17);
    
    XOR2_13 : XOR2
      port map(A => NU_11, B => AND2_5_Y, Y => XOR2_13_Y);
    
    XOR2_5 : XOR2
      port map(A => NU_16, B => AND2_1_Y, Y => XOR2_5_Y);
    
    DFN1E1C1_NU_1 : DFN1E1C1
      port map(D => INV_2_Y, CLK => Clock, CLR => Aclr, E => 
        Enable, Q => NU_1);
    
    DFN1E1C1_NU_14 : DFN1E1C1
      port map(D => XOR2_7_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_14);
    
    XOR2_14 : XOR2
      port map(A => NU_17, B => AND2_0_Y, Y => XOR2_14_Y);
    
    U_AND2_15_16 : AND2
      port map(A => NU_15, B => NU_16, Y => NU_15_16);
    
    XOR2_2 : XOR2
      port map(A => NU_15, B => AND2_2_Y, Y => XOR2_2_Y);
    
    XOR2_6 : XOR2
      port map(A => NU_2, B => AND2_10_Y, Y => XOR2_6_Y);
    
    DFN1C1_NU_2 : DFN1C1
      port map(D => XOR2_6_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_2);
    
    XOR2_4 : XOR2
      port map(A => NU_6, B => AND2_8_Y, Y => XOR2_4_Y);
    
    U_U_AND3_9_to_17 : AND3
      port map(A => NU_9_10_11, B => NU_12_13_14, C => 
        NU_15_16_17, Y => NU_9_to_17);
    
    DFN1E1C1_NU_10 : DFN1E1C1
      port map(D => XOR2_11_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_10);
    
    XOR2_8 : XOR2
      port map(A => NU_4, B => NU_3, Y => XOR2_8_Y);
    
    DFN1E1C1_NU_16 : DFN1E1C1
      port map(D => XOR2_5_Y, CLK => Clock, CLR => Aclr, E => 
        NU_15, Q => NU_16);
    
    U_AND2_3_4 : AND2
      port map(A => NU_3, B => NU_4, Y => NU_3_4);
    
    U_AND3_15_16_17 : AND3
      port map(A => NU_15, B => NU_16, C => NU_17, Y => 
        NU_15_16_17);
    
    DFN1C1_NU_18 : DFN1C1
      port map(D => XOR2_10_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_18);
    
    DFN1E1C1_NU_9 : DFN1E1C1
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_9);
    
    XOR2_11 : XOR2
      port map(A => NU_10, B => NU_9, Y => XOR2_11_Y);
    
    DFN1E1C1_NU_4 : DFN1E1C1
      port map(D => XOR2_8_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_4);
    
    U_AND2_18_19 : AND2
      port map(A => NU_18, B => NU_19, Y => NU_18_19);
    
    U_U_AND2_9_to_14 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => NU_9_to_14);
    
    U_AND3_Tcnt : AND3
      port map(A => NU_1_to_8, B => NU_9_to_17, C => NU_18, Y => 
        N_Tcnt_Stg1);
    
    INV_0 : INV
      port map(A => NU_3, Y => INV_0_Y);
    
    U_U_AND3_0_to_8 : AND3
      port map(A => NU_0_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_0_to_8);
    

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
-- DESDIR:C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/WUPUMultiMsgInternalOSC/smartgen\ZBWatchDog
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:IS4X4M1LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:19
-- DIRECTION:UP
-- CLR_POLARITY:1
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

