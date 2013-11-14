LIBRARY igloo;
   USE igloo.all;
LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;


ENTITY FlashFreeze_Managment IS
   GENERIC (
      NUMBER_OF_ADDITIONAL_CLOCKS  : INTEGER := 1);
     
     PORT (
      Flash_Freeze_N                : IN STD_LOGIC;
      CLK                           : IN STD_LOGIC;
      RST_N                         : IN STD_LOGIC;
      Done_Housekeeping             : IN STD_LOGIC;
      AUX_CLK                       : IN STD_LOGIC_VECTOR(NUMBER_OF_ADDITIONAL_CLOCKS - 1 DOWNTO 0);
      AUX_CLK_GATED                 : OUT STD_LOGIC_VECTOR(NUMBER_OF_ADDITIONAL_CLOCKS - 1 DOWNTO 0);
      Wait_Housekeeping             : OUT STD_LOGIC;
      CLK_GATED                     : OUT STD_LOGIC;
      Flash_Freeze_Enabled          : OUT STD_LOGIC
   );
END ENTITY FlashFreeze_Managment;

ARCHITECTURE trans OF FlashFreeze_Managment IS
   COMPONENT FlashFreeze_FSM IS
      GENERIC (
         REG_FLASH_FREEZE            : INTEGER
      );
      PORT (
         Flash_Freeze                : IN STD_LOGIC;
         clock                       : IN STD_LOGIC;
         reset                       : IN STD_LOGIC;
         safe_to_turn_off_clk        : IN STD_LOGIC;
         housekeeping_request        : OUT STD_LOGIC;
         control_user_clock          : OUT STD_LOGIC;
         Flash_Freeze_Enabled        : OUT STD_LOGIC
      );
   END COMPONENT;
   
   COMPONENT FlashFreeze_Filter IS
      PORT (
         control_user_clock          : IN STD_LOGIC;
         clock                       : IN STD_LOGIC;
         clock_to_user_logic         : OUT STD_LOGIC
      );
   END COMPONENT;
   
   SIGNAL control_user_clock_net         : STD_LOGIC;
   
   SIGNAL Seconday_Clock_Sanitized_xhdl1 : STD_LOGIC_VECTOR(NUMBER_OF_ADDITIONAL_CLOCKS - 1 DOWNTO 0);
   SIGNAL housekeeping_request_xhdl2     : STD_LOGIC;
   SIGNAL Primary_Clock_Sanitized_xhdl0  : STD_LOGIC;

   attribute syn_global_buffers : integer;
   attribute syn_global_buffers of trans : architecture is 18; 

BEGIN
   AUX_CLK_GATED <= Seconday_Clock_Sanitized_xhdl1;
   Wait_Housekeeping <= housekeeping_request_xhdl2;
   CLK_GATED <= Primary_Clock_Sanitized_xhdl0;

   FlashFreeze_FSM_inst : FlashFreeze_FSM
        GENERIC MAP (
         REG_FLASH_FREEZE  => 1
      )
      PORT MAP (
         Flash_Freeze          => Flash_Freeze_N,
         clock                 => CLK,
         reset                 => RST_N,
         safe_to_turn_off_clk  => Done_Housekeeping,
         housekeeping_request  => housekeeping_request_xhdl2,
         control_user_clock    => control_user_clock_net,
         Flash_Freeze_Enabled  => Flash_Freeze_Enabled
      );
   
   
   Primary_Filter_Instance : FlashFreeze_Filter 
      PORT MAP (
         control_user_clock   => control_user_clock_net,
         clock                => CLK,
         clock_to_user_logic  => Primary_Clock_Sanitized_xhdl0
      );
   
   GEN1: IF (NUMBER_OF_ADDITIONAL_CLOCKS > 0) GENERATE
   GEN2:   FOR i IN 0 TO  NUMBER_OF_ADDITIONAL_CLOCKS - 1 GENERATE 
         seconday_filter_instance : FlashFreeze_Filter 
            PORT MAP (
               control_user_clock   => control_user_clock_net,
               clock                => AUX_CLK(i),
               clock_to_user_logic  => Seconday_Clock_Sanitized_xhdl1(i)
            );
      END GENERATE;
   END GENERATE;
   
   
END ARCHITECTURE trans;


