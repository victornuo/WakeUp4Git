LIBRARY ieee;
   USE ieee.std_logic_1164.all;
LIBRARY igloo;
   USE igloo.all;


ENTITY FlashFreeze_Filter IS
   PORT (
      control_user_clock          : IN STD_LOGIC ;
      clock                       : IN STD_LOGIC;
      clock_to_user_logic         : OUT STD_LOGIC 
   );
END ENTITY FlashFreeze_Filter;

ARCHITECTURE trans OF FlashFreeze_Filter IS
   
	COMPONENT DFN1
        PORT(D, CLK : in STD_LOGIC := 'U'; Q : out STD_LOGIC
        ) ;
    	END COMPONENT;

   	COMPONENT DLN0
        PORT(D, G : in STD_LOGIC := 'U'; Q : out STD_LOGIC
        ) ;
    	END COMPONENT;
	
	component AND2
        PORT(A, B : in STD_LOGIC := 'U'; Y : out STD_LOGIC
        ) ;
    	END component;

    COMPONENT CLKINT IS
      PORT (
         A          : IN STD_LOGIC;
         Y         : OUT STD_LOGIC 
      );
   END COMPONENT;

   SIGNAL stop_stage_one                 : STD_LOGIC ;
   SIGNAL stop_stage_two                 : STD_LOGIC ;
   SIGNAL clock_to_user_logic_temp       : STD_LOGIC ;
   
   SIGNAL clock_to_user_logic_xhdl0      : STD_LOGIC;
BEGIN
   clock_to_user_logic <= clock_to_user_logic_xhdl0;
   
   
   Register_For_Clock_Gating : DFN1
      PORT MAP (
         CLK  => clock,
         D    => control_user_clock,
         Q    => stop_stage_one
      );
   
   
   Latch_For_Clock_Gating : DLN0
      PORT MAP (
         G  => clock,
         D  => stop_stage_one,
         Q  => stop_stage_two
      );
   
   
   Gate_For_Clock_Gating : AND2
      PORT MAP (
         A  => stop_stage_two,
         B  => clock,
         Y  => clock_to_user_logic_temp
      );
   
   
   Gate_For_Clock_Gating_Clkint : CLKINT
      PORT MAP (
         A  => clock_to_user_logic_temp,
         Y  => clock_to_user_logic_xhdl0
      );
   
END ARCHITECTURE trans;


