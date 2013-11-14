--#####################################################################
-- component FFCtrl_wrapper
-- port ( 
--     Flash_Freeze_N:in std_logic;
--     RST_N:in std_logic;
--     CLK:in std_logic;
--     AUX_CLK:in std_logic_vector(1-1 downto 0);
--     Wait_Housekeeping:out std_logic;
--     Done_Housekeeping:in std_logic;
--     CLK_GATED:out std_logic;
--     AUX_CLK_GATED:out std_logic_vector(1-1 downto 0);
--     Flash_Freeze_Enabled:out std_logic
--      );
-- end component;

--U0:FFCtrl_wrapper
--port map(
--         Flash_Freeze_N=>  ;
--         RST_N=>  ;
--         CLK=>  ;
--         AUX_CLK=>  ;
--         Wait_Housekeeping=>  ;
--         Done_Housekeeping=>  ;
--         CLK_GATED=>  ;
--         AUX_CLK_GATED=>  ;
--         Flash_Freeze_Enabled=>  
--        );
--#####################################################################


library IEEE ;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FFCtrl_wrapper is  
port ( 
     Flash_Freeze_N:in std_logic;
     RST_N:in std_logic;
     CLK:in std_logic;
     AUX_CLK:in std_logic_vector(1-1 downto 0);
     Wait_Housekeeping:out std_logic;
     Done_Housekeeping:in std_logic;
     CLK_GATED:out std_logic;
     AUX_CLK_GATED:out std_logic_vector(1-1 downto 0);
     Flash_Freeze_Enabled:out std_logic
     );
end FFCtrl_wrapper;

architecture DEF_ARCH of FFCtrl_wrapper is

component FlashFreeze_Managment

generic(
     NUMBER_OF_ADDITIONAL_CLOCKS:integer
        );
port(
     Flash_Freeze_N:in std_logic;
     RST_N:in std_logic;
     CLK:in std_logic;
     AUX_CLK:in std_logic_vector(NUMBER_OF_ADDITIONAL_CLOCKS-1 downto 0);
     Wait_Housekeeping:out std_logic;
     Done_Housekeeping:in std_logic;
     CLK_GATED:out std_logic;
     AUX_CLK_GATED:out std_logic_vector(NUMBER_OF_ADDITIONAL_CLOCKS-1 downto 0);
     Flash_Freeze_Enabled:out std_logic
     );
end component;

begin

U0:FlashFreeze_Managment
generic map(
             NUMBER_OF_ADDITIONAL_CLOCKS=>1
           )

port map(
         Flash_Freeze_N=>Flash_Freeze_N,
         RST_N=>RST_N,
         CLK=>CLK,
         AUX_CLK=>AUX_CLK,
         Wait_Housekeeping=>Wait_Housekeeping,
         Done_Housekeeping=>Done_Housekeeping,
         CLK_GATED=>CLK_GATED,
         AUX_CLK_GATED=>AUX_CLK_GATED,
         Flash_Freeze_Enabled=>Flash_Freeze_Enabled
        );
end DEF_ARCH;
