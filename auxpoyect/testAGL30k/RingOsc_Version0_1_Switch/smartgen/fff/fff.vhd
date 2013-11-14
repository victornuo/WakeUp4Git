-- Version: v11.1 11.1.0.14

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity fff is

    port( Flash_Freeze_N       : in    std_logic;
          RST_N                : in    std_logic;
          CLK                  : in    std_logic;
          CLK_GATED            : out   std_logic;
          Flash_Freeze_Enabled : out   std_logic
        );

end fff;

architecture DEF_ARCH of fff is 

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INBUF_FF
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component fff_wrapper
    port( Flash_Freeze_N       : in    std_logic := 'U';
          RST_N                : in    std_logic := 'U';
          CLK                  : in    std_logic := 'U';
          Done_Housekeeping    : in    std_logic := 'U';
          Wait_Housekeeping    : out   std_logic;
          CLK_GATED            : out   std_logic;
          AUX_CLK              : in    std_logic_vector(0 to 0) := (others => 'U');
          AUX_CLK_GATED        : out   std_logic_vector(0 to 0);
          Flash_Freeze_Enabled : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  attribute syn_noprune : boolean;
  attribute syn_noprune of INBUF_FF: component is true;

    signal N_FlashFreeze, N_Housekeeping, 
        N_FLASH_FREEZE_ENABLED_INV, GND_net : std_logic;
    signal GND_power_net1 : std_logic;
    signal nc1 : std_logic;

begin 

    GND_net <= GND_power_net1;

    Flash_Freeze_Enabled_Inv : INV
      port map(A => N_FLASH_FREEZE_ENABLED_INV, Y => 
        Flash_Freeze_Enabled);
    
    FlashFreeze_Inbuf : INBUF_FF
      port map(PAD => Flash_Freeze_N, Y => N_FlashFreeze);
    
    fff_wrapper_inst : fff_wrapper
      port map(Flash_Freeze_N => N_FlashFreeze, RST_N => RST_N, 
        CLK => CLK, Done_Housekeeping => N_Housekeeping, 
        Wait_Housekeeping => N_Housekeeping, CLK_GATED => 
        CLK_GATED, AUX_CLK(0) => GND_net, AUX_CLK_GATED(0) => nc1, 
        Flash_Freeze_Enabled => N_FLASH_FREEZE_ENABLED_INV);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);


end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.1.0.14
-- FLASH_FREEZE_PN:Flash_Freeze_N
-- FF_TYPE:2
-- FLASH_FREEZE_ENABLED_PN:Flash_Freeze_Enabled
-- FLASH_FREEZE_ENABLED_POLARITY:0
-- ENABLE_HK:0
-- RST_PN:RST_N
-- CLK_PN:CLK
-- GATED_CLK_PN:CLK_GATED
-- NUMBER_OF_AUX_CLKS:0
-- LPMTYPE:LPM_FLASHFREEZE
-- LPM_HINT:NONE
-- OUTFORMAT:VHDL
-- DESIGN:fff
-- FAM:PA3LCLP

-- _End_Comments_

