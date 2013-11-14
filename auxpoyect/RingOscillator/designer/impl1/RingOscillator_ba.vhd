-- Version: 9.1 SP3 9.1.3.4
-- File used only for Simulation

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity RingOscillator is

    port( RESET   : in    std_logic;
          CLK_OUT : out   std_logic
        );

end RingOscillator;

architecture DEF_ARCH of RingOscillator is 

  component ULSICC_INT
    port( USTDBY : in    std_logic := 'U';
          LPENA  : in    std_logic := 'U'
        );
  end component;

  component DFI1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          QN  : out   std_logic
        );
  end component;

  component IOTRI_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component IOPAD_TRI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component IOIN_IB
    port( YIN : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component NAND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal DFI1C0_0_QN, DFI1C0_3_QN, DFI1C0_5_QN, DFI1C0_2_QN, 
        DFI1C0_1_QN, DFI1C0_8_QN, DFI1C0_7_QN, DFI1C0_9_QN, 
        DFI1C0_11_QN, DFI1C0_10_QN, DFI1C0_4_QN, AO14_15_Y_i, 
        RESET_c, CLK_OUT_c, AO14_15_Y, \GND\, \VCC\, 
        \RESET_pad/U0/NET1\, \CLK_OUT_pad/U0/NET1\, 
        \CLK_OUT_pad/U0/NET2\, AFLSDF_VCC, AFLSDF_GND
         : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    AFLSDF_GND <= GND_power_net1;
    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    INT_ULSICC_INSTANCE_0 : ULSICC_INT
      port map(USTDBY => \GND\, LPENA => \GND\);
    
    DFI1C0_1 : DFI1C0
      port map(D => DFI1C0_2_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_1_QN);
    
    \CLK_OUT_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => CLK_OUT_c, E => \VCC\, DOUT => 
        \CLK_OUT_pad/U0/NET1\, EOUT => \CLK_OUT_pad/U0/NET2\);
    
    \CLK_OUT_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CLK_OUT_pad/U0/NET1\, E => 
        \CLK_OUT_pad/U0/NET2\, PAD => CLK_OUT);
    
    \RESET_pad/U0/U0\ : IOPAD_IN
      port map(PAD => RESET, Y => \RESET_pad/U0/NET1\);
    
    DFI1C0_11 : DFI1C0
      port map(D => DFI1C0_9_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_11_QN);
    
    DFI1C0_10 : DFI1C0
      port map(D => DFI1C0_11_QN, CLK => AO14_15_Y, CLR => 
        RESET_c, QN => DFI1C0_10_QN);
    
    \RESET_pad/U0/U1\ : IOIN_IB
      port map(YIN => \RESET_pad/U0/NET1\, Y => RESET_c);
    
    DFI1C0_9 : DFI1C0
      port map(D => DFI1C0_7_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_9_QN);
    
    DFI1C0_6 : DFI1C0
      port map(D => DFI1C0_10_QN, CLK => AO14_15_Y, CLR => 
        RESET_c, QN => CLK_OUT_c);
    
    DFI1C0_2 : DFI1C0
      port map(D => DFI1C0_0_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_2_QN);
    
    DFI1C0_5 : DFI1C0
      port map(D => DFI1C0_3_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_5_QN);
    
    AO14_15 : NAND2
      port map(A => RESET_c, B => AO14_15_Y, Y => AO14_15_Y_i);
    
    DFI1C0_7 : DFI1C0
      port map(D => DFI1C0_8_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_7_QN);
    
    DFI1C0_4 : DFI1C0
      port map(D => DFI1C0_5_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_4_QN);
    
    DFI1C0_3 : DFI1C0
      port map(D => DFI1C0_1_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_3_QN);
    
    DFI1C0_8 : DFI1C0
      port map(D => DFI1C0_4_QN, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_8_QN);
    
    AO14_15_Y_keep_RNO : CLKINT
      port map(A => AO14_15_Y_i, Y => AO14_15_Y);
    
    DFI1C0_0 : DFI1C0
      port map(D => AO14_15_Y, CLK => AO14_15_Y, CLR => RESET_c, 
        QN => DFI1C0_0_QN);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
