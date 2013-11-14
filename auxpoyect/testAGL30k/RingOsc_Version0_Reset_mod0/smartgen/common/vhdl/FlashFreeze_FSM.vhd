LIBRARY ieee;
   USE ieee.std_logic_1164.all;
LIBRARY igloo;
   USE igloo.all;

ENTITY FlashFreeze_FSM IS
   GENERIC (
      REG_FLASH_FREEZE            : INTEGER := 1);
   PORT (
      Flash_Freeze                : IN STD_LOGIC;
      clock                       : IN STD_LOGIC;
      reset                       : IN STD_LOGIC;
      safe_to_turn_off_clk        : IN STD_LOGIC;
      housekeeping_request        : OUT STD_LOGIC;
      control_user_clock          : OUT STD_LOGIC;
      Flash_Freeze_Enabled        : OUT STD_LOGIC 
   );
END ENTITY FlashFreeze_FSM;

ARCHITECTURE trans OF FlashFreeze_FSM IS

    COMPONENT ULSICC
        PORT(LSICC : in std_logic := 'U') ;
    END COMPONENT;

    COMPONENT CLKINT IS
      PORT (
         A          : IN STD_LOGIC;
         Y         : OUT STD_LOGIC 
      );
   END COMPONENT;

    attribute syn_noprune : boolean;
	attribute syn_noprune of ULSICC: component is true;

   SIGNAL trigger_ulsicc                 : STD_LOGIC;
   
   SIGNAL Flash_Freeze_reg               : STD_LOGIC;
   SIGNAL final_reg_unreg_ff             : STD_LOGIC;

	

type STATE_TYPE is (wait_on_ff, persistent_ff, house_keep_to_user_logic, stop_clock_to_user, trigger_ulsicc_state, turn_on_user_clock, fail_safe1, fail_safe2); 
attribute ENUM_ENCODING: STRING; 
attribute ENUM_ENCODING of STATE_TYPE:type is "000 001 010 011 100 101 110 111";
signal ff_current_state : STATE_TYPE; 

BEGIN
   
   Flash_Freeze_Enabled <= trigger_ulsicc;

   PROCESS (Flash_Freeze, Flash_Freeze_reg)
   BEGIN
      IF (REG_FLASH_FREEZE = 1) THEN
         final_reg_unreg_ff <= Flash_Freeze_reg;
      ELSE
         final_reg_unreg_ff <= Flash_Freeze;
      END IF;
   END PROCESS;
   
   PROCESS (clock, reset)
   BEGIN
      IF (reset = '0') THEN
         control_user_clock <= '1';
         trigger_ulsicc <= '0';
         housekeeping_request <= '0';
         Flash_Freeze_reg <= '0';
         ff_current_state <= wait_on_ff;
      ELSIF (clock'EVENT AND clock = '1') THEN
         
         Flash_Freeze_reg <= Flash_Freeze;
         
         CASE (ff_current_state) IS
            
            WHEN wait_on_ff =>
               housekeeping_request <= '0';
               trigger_ulsicc <= '0';
               control_user_clock <= '1';
               IF (final_reg_unreg_ff = '0') THEN
                  ff_current_state <= persistent_ff;
               ELSE
                  ff_current_state <= wait_on_ff;
               END IF;
            
            WHEN persistent_ff =>
               IF (final_reg_unreg_ff = '0') THEN
                  ff_current_state <= house_keep_to_user_logic;
               ELSE
                  ff_current_state <= wait_on_ff;
               END IF;
            
            WHEN house_keep_to_user_logic =>
               IF (final_reg_unreg_ff = '0') THEN
                  housekeeping_request <= '1';
                  ff_current_state <= stop_clock_to_user;
               ELSE
                  ff_current_state <= wait_on_ff;
               END IF;
            
            WHEN stop_clock_to_user =>
               IF (final_reg_unreg_ff = '0') THEN
                  IF (safe_to_turn_off_clk = '1') THEN
                     housekeeping_request <= '0';
                     control_user_clock <= '0';
                     ff_current_state <= trigger_ulsicc_state;
                  ELSE
                     ff_current_state <= stop_clock_to_user;
                  END IF;
               ELSE
                  ff_current_state <= wait_on_ff;
               END IF;
            
            WHEN trigger_ulsicc_state =>
               IF (final_reg_unreg_ff = '0') THEN
                  trigger_ulsicc <= '1';
                  ff_current_state <= trigger_ulsicc_state;
               ELSE
                  trigger_ulsicc <= '0';
                  ff_current_state <= turn_on_user_clock;
               END IF;
            
            WHEN turn_on_user_clock =>
               ff_current_state <= wait_on_ff;
            WHEN fail_safe1 =>
               ff_current_state <= wait_on_ff;
            
            WHEN fail_safe2 =>
               ff_current_state <= wait_on_ff;
            
            WHEN OTHERS =>
               ff_current_state <= wait_on_ff;
         END CASE;
      END IF;
   END PROCESS;
   
   
   ULSICC_INSTANCE : ULSICC
      PORT MAP (
         LSICC  => trigger_ulsicc
      );
   
END ARCHITECTURE trans;


