-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity ZBWatchDog is

    port( Aclr   : in    std_logic;
          Clock  : in    std_logic;
          Tcnt   : out   std_logic;
          Q      : out   std_logic_vector(26 downto 0);
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

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
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
        NU_18, NU_19, NU_20, NU_21, NU_22, NU_23, NU_24, NU_25, 
        NU_26, NU_0_1, NU_1_2, NU_0_1_2, NU_3_4, NU_3_4_5, NU_6_7, 
        NU_6_7_8, NU_9_10, NU_9_10_11, NU_12_13, NU_12_13_14, 
        NU_15_16, NU_15_16_17, NU_18_19, NU_18_19_20, NU_21_22, 
        NU_21_22_23, NU_24_25, NU_24_25_26, NU_1_to_8, NU_0_to_8, 
        NU_9_to_17, NU_18_to_26, NU_1_to_26, NU_0_to_26, 
        NU_9_to_14, NU_18_to_21, NU_18_to_22, NU_18_to_23, 
        NU_18_to_24, NU_18_to_25, N_Tcnt_Stg1, NU_27, XOR2_7_Y, 
        AND2_15_Y, XOR2_8_Y, AND2_2_Y, XOR2_12_Y, AND2_8_Y, 
        XOR2_16_Y, XOR2_17_Y, AND2_4_Y, XOR2_19_Y, AND2_1_Y, 
        XOR2_22_Y, AND2_6_Y, XOR2_0_Y, AND2_19_Y, XOR2_13_Y, 
        AND2_11_Y, XOR2_2_Y, XOR2_5_Y, AND2_7_Y, INV_1_Y, 
        XOR2_18_Y, AND2_10_Y, XOR2_21_Y, AND2_14_Y, XOR2_9_Y, 
        AND2_18_Y, INV_0_Y, XOR2_1_Y, AND2_0_Y, XOR2_10_Y, 
        AND2_5_Y, INV_2_Y, XOR2_11_Y, XOR2_14_Y, AND2_12_Y, 
        XOR2_3_Y, AND2_3_Y, XOR2_6_Y, AND2_9_Y, XOR2_15_Y, 
        AND2_20_Y, XOR2_20_Y, AND2_13_Y, XOR2_23_Y, AND2_16_Y, 
        XOR2_4_Y, AND2_17_Y : std_logic;

begin 

    Q(26) <= NU_27;
    Q(25) <= NU_26;
    Q(24) <= NU_25;
    Q(23) <= NU_24;
    Q(22) <= NU_23;
    Q(21) <= NU_22;
    Q(20) <= NU_21;
    Q(19) <= NU_20;
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
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_9_Y);
    
    DFN1E1C1_NU_19 : DFN1E1C1
      port map(D => XOR2_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18, Q => NU_19);
    
    DFN1E1C1_NU_24 : DFN1E1C1
      port map(D => XOR2_14_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_23, Q => NU_24);
    
    DFN1E1C1_NU_5 : DFN1E1C1
      port map(D => XOR2_13_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_5);
    
    AND2_11 : AND2
      port map(A => NU_3, B => NU_4, Y => AND2_11_Y);
    
    XOR2_9 : XOR2
      port map(A => NU_2, B => AND2_18_Y, Y => XOR2_9_Y);
    
    U_AND3_24_25_26 : AND3
      port map(A => NU_24, B => NU_25, C => NU_26, Y => 
        NU_24_25_26);
    
    XOR2_16 : XOR2
      port map(A => NU_10, B => NU_9, Y => XOR2_16_Y);
    
    AND2_13 : AND2
      port map(A => NU_9_10_11, B => NU_12, Y => AND2_13_Y);
    
    U_AND2_0_1 : AND2
      port map(A => Enable, B => NU_1, Y => NU_0_1);
    
    AND2_12 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_12_Y);
    
    DFN1E1C1_NU_20 : DFN1E1C1
      port map(D => XOR2_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_19, Q => NU_20);
    
    DFN1E1C1_NU_26 : DFN1E1C1
      port map(D => XOR2_12_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_25, Q => NU_26);
    
    XOR2_1 : XOR2
      port map(A => NU_20, B => AND2_0_Y, Y => XOR2_1_Y);
    
    XOR2_15 : XOR2
      port map(A => NU_18, B => AND2_20_Y, Y => XOR2_15_Y);
    
    U_AND2_Tcnt_2 : AND2
      port map(A => NU_27, B => N_Tcnt_Stg1, Y => Tcnt);
    
    XOR2_10 : XOR2
      port map(A => NU_14, B => AND2_5_Y, Y => XOR2_10_Y);
    
    XOR2_22 : XOR2
      port map(A => NU_27, B => AND2_6_Y, Y => XOR2_22_Y);
    
    XOR2_19 : XOR2
      port map(A => NU_17, B => AND2_1_Y, Y => XOR2_19_Y);
    
    DFN1E1C1_NU_8 : DFN1E1C1
      port map(D => XOR2_4_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6_7, Q => NU_8);
    
    U_U_AND2_18_to_23 : AND2
      port map(A => NU_18_19_20, B => NU_21_22_23, Y => 
        NU_18_to_23);
    
    XOR2_18 : XOR2
      port map(A => NU_11, B => AND2_10_Y, Y => XOR2_18_Y);
    
    U_U_AND3_1_to_26 : AND3
      port map(A => NU_1_to_8, B => NU_9_to_17, C => NU_18_to_26, 
        Y => NU_1_to_26);
    
    U_AND2_9_10 : AND2
      port map(A => NU_9, B => NU_10, Y => NU_9_10);
    
    AND2_0 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_0_Y);
    
    XOR2_7 : XOR2
      port map(A => NU_6, B => AND2_15_Y, Y => XOR2_7_Y);
    
    U_U_AND3_18_to_26 : AND3
      port map(A => NU_18_19_20, B => NU_21_22_23, C => 
        NU_24_25_26, Y => NU_18_to_26);
    
    DFN1E1C1_NU_13 : DFN1E1C1
      port map(D => XOR2_20_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_13);
    
    U_U_AND3_0_to_26 : AND3
      port map(A => NU_0_to_8, B => NU_9_to_17, C => NU_18_to_26, 
        Y => NU_0_to_26);
    
    U_AND2_12_13 : AND2
      port map(A => NU_12, B => NU_13, Y => NU_12_13);
    
    AND2_16 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_16_Y);
    
    INV_1 : INV
      port map(A => NU_9, Y => INV_1_Y);
    
    DFN1E1C1_NU_12 : DFN1E1C1
      port map(D => XOR2_2_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_12);
    
    U_U_AND2_18_to_21 : AND2
      port map(A => NU_18_19_20, B => NU_21, Y => NU_18_to_21);
    
    AND2_2 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_14, Y => AND2_2_Y);
    
    U_AND3_12_13_14 : AND3
      port map(A => NU_12, B => NU_13, C => NU_14, Y => 
        NU_12_13_14);
    
    U_AND3_18_19_20 : AND3
      port map(A => NU_18, B => NU_19, C => NU_20, Y => 
        NU_18_19_20);
    
    AND2_8 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_8_Y);
    
    AND2_5 : AND2
      port map(A => NU_9_10_11, B => NU_12_13, Y => AND2_5_Y);
    
    AND2_4 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_4_Y);
    
    AND2_1 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_14, Y => AND2_1_Y);
    
    AND2_3 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => AND2_3_Y);
    
    XOR2_23 : XOR2
      port map(A => NU_23, B => AND2_16_Y, Y => XOR2_23_Y);
    
    DFN1C1_NU_6 : DFN1C1
      port map(D => XOR2_7_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_6);
    
    AND2_17 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_17_Y);
    
    AND2_7 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_7_Y);
    
    U_AND2_1_2 : AND2
      port map(A => NU_1, B => NU_2, Y => NU_1_2);
    
    U_U_AND3_18_to_24 : AND3
      port map(A => NU_18_19_20, B => NU_21_22_23, C => NU_24, Y
         => NU_18_to_24);
    
    DFN1E1C1_NU_15 : DFN1E1C1
      port map(D => XOR2_3_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_15);
    
    DFN1E1C1_NU_7 : DFN1E1C1
      port map(D => XOR2_17_Y, CLK => Clock, CLR => Aclr, E => 
        NU_6, Q => NU_7);
    
    DFN1E1C1_NU_3 : DFN1E1C1
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_3);
    
    DFN1E1C1_NU_23 : DFN1E1C1
      port map(D => XOR2_23_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_22, Q => NU_23);
    
    U_U_AND3_18_to_25 : AND3
      port map(A => NU_18_19_20, B => NU_21_22_23, C => NU_24_25, 
        Y => NU_18_to_25);
    
    U_AND3_6_7_8 : AND3
      port map(A => NU_6, B => NU_7, C => NU_8, Y => NU_6_7_8);
    
    XOR2_12 : XOR2
      port map(A => NU_26, B => AND2_8_Y, Y => XOR2_12_Y);
    
    XOR2_3 : XOR2
      port map(A => NU_15, B => AND2_3_Y, Y => XOR2_3_Y);
    
    AND2_6 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_6_Y);
    
    XOR2_21 : XOR2
      port map(A => NU_21, B => AND2_14_Y, Y => XOR2_21_Y);
    
    U_AND2_6_7 : AND2
      port map(A => NU_6, B => NU_7, Y => NU_6_7);
    
    DFN1E1C1_NU_11 : DFN1E1C1
      port map(D => XOR2_18_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_11);
    
    U_AND3_9_10_11 : AND3
      port map(A => NU_9, B => NU_10, C => NU_11, Y => NU_9_10_11);
    
    U_U_AND3_1_to_8 : AND3
      port map(A => NU_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_1_to_8);
    
    DFN1E1C1_NU_22 : DFN1E1C1
      port map(D => XOR2_5_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_21, Q => NU_22);
    
    U_AND3_3_4_5 : AND3
      port map(A => NU_3, B => NU_4, C => NU_5, Y => NU_3_4_5);
    
    INV_2 : INV
      port map(A => NU_1, Y => INV_2_Y);
    
    AND2_20 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_20_Y);
    
    U_AND3_0_1_2 : AND3
      port map(A => Enable, B => NU_1, C => NU_2, Y => NU_0_1_2);
    
    U_AND3_21_22_23 : AND3
      port map(A => NU_21, B => NU_22, C => NU_23, Y => 
        NU_21_22_23);
    
    XOR2_0 : XOR2
      port map(A => NU_19, B => AND2_19_Y, Y => XOR2_0_Y);
    
    U_AND2_21_22 : AND2
      port map(A => NU_21, B => NU_22, Y => NU_21_22);
    
    U_U_AND2_18_to_22 : AND2
      port map(A => NU_18_19_20, B => NU_21_22, Y => NU_18_to_22);
    
    AND2_10 : AND2
      port map(A => NU_9, B => NU_10, Y => AND2_10_Y);
    
    DFN1E1C1_NU_25 : DFN1E1C1
      port map(D => XOR2_6_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_24, Q => NU_25);
    
    AND2_18 : AND2
      port map(A => Enable, B => NU_1, Y => AND2_18_Y);
    
    DFN1E1C1_NU_17 : DFN1E1C1
      port map(D => XOR2_19_Y, CLK => Clock, CLR => Aclr, E => 
        NU_15_16, Q => NU_17);
    
    XOR2_13 : XOR2
      port map(A => NU_5, B => AND2_11_Y, Y => XOR2_13_Y);
    
    AND2_19 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_19_Y);
    
    XOR2_17 : XOR2
      port map(A => NU_7, B => AND2_4_Y, Y => XOR2_17_Y);
    
    XOR2_5 : XOR2
      port map(A => NU_22, B => AND2_7_Y, Y => XOR2_5_Y);
    
    DFN1E1C1_NU_1 : DFN1E1C1
      port map(D => INV_2_Y, CLK => Clock, CLR => Aclr, E => 
        Enable, Q => NU_1);
    
    DFN1E1C1_NU_14 : DFN1E1C1
      port map(D => XOR2_10_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_14);
    
    U_AND2_15_16 : AND2
      port map(A => NU_15, B => NU_16, Y => NU_15_16);
    
    XOR2_14 : XOR2
      port map(A => NU_24, B => AND2_12_Y, Y => XOR2_14_Y);
    
    XOR2_2 : XOR2
      port map(A => NU_12, B => NU_9_10_11, Y => XOR2_2_Y);
    
    XOR2_20 : XOR2
      port map(A => NU_13, B => AND2_13_Y, Y => XOR2_20_Y);
    
    AND2_14 : AND2
      port map(A => NU_0_to_8, B => NU_9_to_17, Y => AND2_14_Y);
    
    XOR2_6 : XOR2
      port map(A => NU_25, B => AND2_9_Y, Y => XOR2_6_Y);
    
    DFN1C1_NU_2 : DFN1C1
      port map(D => XOR2_9_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_2);
    
    U_U_AND3_9_to_17 : AND3
      port map(A => NU_9_10_11, B => NU_12_13_14, C => 
        NU_15_16_17, Y => NU_9_to_17);
    
    XOR2_4 : XOR2
      port map(A => NU_8, B => AND2_17_Y, Y => XOR2_4_Y);
    
    DFN1E1C1_NU_10 : DFN1E1C1
      port map(D => XOR2_16_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_10);
    
    U_AND2_24_25 : AND2
      port map(A => NU_24, B => NU_25, Y => NU_24_25);
    
    XOR2_8 : XOR2
      port map(A => NU_16, B => AND2_2_Y, Y => XOR2_8_Y);
    
    DFN1E1C1_NU_16 : DFN1E1C1
      port map(D => XOR2_8_Y, CLK => Clock, CLR => Aclr, E => 
        NU_15, Q => NU_16);
    
    AND2_15 : AND2
      port map(A => NU_0_1_2, B => NU_3_4_5, Y => AND2_15_Y);
    
    U_AND2_3_4 : AND2
      port map(A => NU_3, B => NU_4, Y => NU_3_4);
    
    DFN1E1C1_NU_21 : DFN1E1C1
      port map(D => XOR2_21_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_19_20, Q => NU_21);
    
    U_AND3_15_16_17 : AND3
      port map(A => NU_15, B => NU_16, C => NU_17, Y => 
        NU_15_16_17);
    
    DFN1C1_NU_18 : DFN1C1
      port map(D => XOR2_15_Y, CLK => Clock, CLR => Aclr, Q => 
        NU_18);
    
    XOR2_11 : XOR2
      port map(A => NU_4, B => NU_3, Y => XOR2_11_Y);
    
    DFN1E1C1_NU_9 : DFN1E1C1
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_to_8, Q => NU_9);
    
    DFN1E1C1_NU_4 : DFN1E1C1
      port map(D => XOR2_11_Y, CLK => Clock, CLR => Aclr, E => 
        NU_0_1_2, Q => NU_4);
    
    U_AND2_18_19 : AND2
      port map(A => NU_18, B => NU_19, Y => NU_18_19);
    
    U_U_AND2_9_to_14 : AND2
      port map(A => NU_9_10_11, B => NU_12_13_14, Y => NU_9_to_14);
    
    U_AND3_Tcnt : AND3
      port map(A => NU_1_to_8, B => NU_9_to_17, C => NU_18_to_26, 
        Y => N_Tcnt_Stg1);
    
    INV_0 : INV
      port map(A => NU_3, Y => INV_0_Y);
    
    U_U_AND3_0_to_8 : AND3
      port map(A => NU_0_1_2, B => NU_3_4_5, C => NU_6_7_8, Y => 
        NU_0_to_8);
    
    DFN1E1C1_NU_27 : DFN1E1C1
      port map(D => XOR2_22_Y, CLK => Clock, CLR => Aclr, E => 
        NU_18_to_26, Q => NU_27);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.3.4
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_COUNTER
-- LPM_HINT:COMPCNT
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Victor/Documents/Cookies/wake_up_radio/WupPMODbyIRQ/smartgen\ZBWatchDog
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:IS4X4M1LP
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:27
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

