-- Version: 10.1 SP3 10.1.3.1

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity newCore is

    port( Aclr  : in    std_logic;
          Clock : in    std_logic;
          Q     : out   std_logic_vector(1 downto 0)
        );

end newCore;

architecture DEF_ARCH of newCore is 

  component DFN1E1C1
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

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
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

    signal NU_0, NU_1, NU_0_1, INV_1_Y, INV_0_Y : std_logic;

begin 

    Q(1) <= NU_1;
    Q(0) <= NU_0;

    DFN1E1C1_NU_1 : DFN1E1C1
      port map(D => INV_0_Y, CLK => Clock, CLR => Aclr, E => NU_0, 
        Q => NU_1);
    
    INV_0 : INV
      port map(A => NU_1, Y => INV_0_Y);
    
    U_AND2_0_1 : AND2
      port map(A => NU_0, B => NU_1, Y => NU_0_1);
    
    DFN1C1_NU_0 : DFN1C1
      port map(D => INV_1_Y, CLK => Clock, CLR => Aclr, Q => NU_0);
    
    INV_1 : INV
      port map(A => NU_0, Y => INV_1_Y);
    

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
-- DESDIR:C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/generarapido/smartgen\newCore
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:M1IS6X6M2LPLV
-- SMARTGEN_PACKAGE:fg484
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:2
-- DIRECTION:UP
-- CLR_POLARITY:1
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

