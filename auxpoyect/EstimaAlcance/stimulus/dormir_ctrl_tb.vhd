-- dormir_ctrl_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library igloo;
use igloo.all;
 
entity dormir_ctrl_tb is
end dormir_ctrl_tb;
 
architecture behavior of dormir_ctrl_tb is 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component dormir_ctrl
    port(
         rst : in  std_logic;
         clk_m : in  std_logic;
         FF_levanta : in  std_logic;
         dout : out  std_logic_vector(7 downto 0);
         data_rdy : out  std_logic
        );
    end component;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk_m : std_logic := '0';
	signal FF_levanta : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal data_rdy : std_logic;

   -- Clock period definitions
   constant CLK_M_PERIOD : time := 1us;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dormir_ctrl port map (
          rst => rst,
          clk_m => clk_m,
          FF_levanta => FF_levanta,
          dout => dout,
          data_rdy => data_rdy
        );

   -- Clock process definitions
   clk_m_process :process
   begin
		clk_m <= '0';
		wait for CLK_M_PERIOD/2;
		clk_m <= '1';
		wait for CLK_M_PERIOD/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for CLK_M_PERIOD*10;

      -- insert stimulus here 

      wait;
   end process;

end;
