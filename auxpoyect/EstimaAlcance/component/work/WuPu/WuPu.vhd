-- Version: 9.1 SP3 9.1.3.4

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity WuPu is

    port( clk            : in    std_logic;
          RX             : in    std_logic;
          RST            : in    std_logic;
          RESETZB        : out   std_logic;
          RX_OUT         : out   std_logic;
          AddOKflag      : out   std_logic;
          bit_error      : out   std_logic;
          NewMsg         : out   std_logic;
          dout           : out   std_logic;
          new_data       : out   std_logic;
          d_hk           : out   std_logic;
          Flash_Freeze_N : in    std_logic
        );

end WuPu;

architecture DEF_ARCH of WuPu is 

  component LowPowerManagement
    port( Flash_Freeze_N    : in    std_logic := 'U';
          RST_N             : in    std_logic := 'U';
          CLK               : in    std_logic := 'U';
          CLK_GATED         : out   std_logic;
          Done_Housekeeping : in    std_logic := 'U';
          Wait_Housekeeping : out   std_logic;
          SleepActive       : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component ShiftEnab
    port( Shiften  : in    std_logic := 'U';
          Shiftin  : in    std_logic := 'U';
          Clock    : in    std_logic := 'U';
          Shiftout : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component INBUF
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component DFN1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

    signal \AddOKflag\, command_process_0_Busy, 
        \command_process_0_msgType_0_[1]\, 
        \command_process_0_msgType_0_[0]\, \dout\, \d_hk\, d_hk_0, 
        LowPowerManagement_0_CLK_GATED, md_v3_0_bit_error, net_25, 
        \new_data\, \RX_OUT\, ShiftEnab_0_Shiftout, GND_net, 
        VCC_net : std_logic;

begin 

    RESETZB <= net_25;
    RX_OUT <= \RX_OUT\;
    AddOKflag <= \AddOKflag\;
    bit_error <= md_v3_0_bit_error;
    dout <= \dout\;
    new_data <= \new_data\;
    d_hk <= d_hk_0;

    LowPowerManagement_0 : LowPowerManagement
      port map(Flash_Freeze_N => Flash_Freeze_N, RST_N => net_25, 
        CLK => clk, CLK_GATED => LowPowerManagement_0_CLK_GATED, 
        Done_Housekeeping => d_hk_0, Wait_Housekeeping => OPEN, 
        SleepActive => OPEN);
    
    \VCC\ : VCC
      port map(Y => VCC_net);
    
    command_process_0 : entity work.command_process
      port map(din => \dout\, newData => \new_data\, dataClean
         => ShiftEnab_0_Shiftout, bitError => md_v3_0_bit_error, 
        endOfMessage => \AddOKflag\, newMsg => NewMsg, Busy => 
        command_process_0_Busy, clk => 
        LowPowerManagement_0_CLK_GATED, rst => net_25, AddOKflag
         => OPEN, d_hk => \d_hk\, nodeAddress(15) => GND_net, 
        nodeAddress(14) => GND_net, nodeAddress(13) => VCC_net, 
        nodeAddress(12) => GND_net, nodeAddress(11) => GND_net, 
        nodeAddress(10) => GND_net, nodeAddress(9) => VCC_net, 
        nodeAddress(8) => GND_net, nodeAddress(7) => GND_net, 
        nodeAddress(6) => GND_net, nodeAddress(5) => VCC_net, 
        nodeAddress(4) => GND_net, nodeAddress(3) => GND_net, 
        nodeAddress(2) => GND_net, nodeAddress(1) => VCC_net, 
        nodeAddress(0) => GND_net, msgType(1) => 
        \command_process_0_msgType_0_[1]\, msgType(0) => 
        \command_process_0_msgType_0_[0]\);
    
    ShiftEnab_0 : ShiftEnab
      port map(Shiften => VCC_net, Shiftin => \AddOKflag\, Clock
         => LowPowerManagement_0_CLK_GATED, Shiftout => 
        ShiftEnab_0_Shiftout);
    
    \GND\ : GND
      port map(Y => GND_net);
    
    md_v3_0 : entity work.md_v3
      port map(mdi => \RX_OUT\, EoM => \AddOKflag\, bit_error => 
        md_v3_0_bit_error, dout => \dout\, new_data => \new_data\, 
        rst => net_25, clk => LowPowerManagement_0_CLK_GATED, 
        d_hk => d_hk_0);
    
    INBUF_0 : INBUF
      port map(PAD => RST, Y => net_25);
    
    DFN1C0_0 : DFN1C0
      port map(D => RX, CLK => LowPowerManagement_0_CLK_GATED, 
        CLR => net_25, Q => \RX_OUT\);
    

end DEF_ARCH; 
