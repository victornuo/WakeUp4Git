--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:49:25 07/21/2011
-- Design Name:   
-- Module Name:   C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/manchester_enc/TB_manchester_enc.vhd
-- Project Name:  manchester_enc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: manchester_encoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
use work.wupu_pck.all;
 
ENTITY TB_manchester_enc_MEI_parity IS
END TB_manchester_enc_MEI_parity;
 
ARCHITECTURE MEI_parity OF TB_manchester_enc_MEI_parity IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT manchester_encoder
	port (
		clk 		: in std_logic;
		rstn 		: in std_logic;
		din 		: in std_logic_vector (MEILENGTH-1 downto 0); --data to transmit
		load 		: in std_logic; 
		enable 		: in std_logic; -- enable manchester encoding
		addparity 	: in std_logic; -- if '1' a extra bit is added to the curret din data as parity bit, the parity is generated in the encoder
		TXbuff_free : out std_logic; -- if '1' TX buffer empty
		--data_end 	: out std_logic; -- if '1' tx buffer is empty
		dout 		: out std_logic; -- manchester data encoded 
		d_hk 		: out std_logic -- done housekeeping
		
    );

    END COMPONENT;
    
   --Inputs
   signal din : std_logic_vector (MEILENGTH-1 downto 0):= "00000000";
   signal load : std_logic := '0';
   signal enable : std_logic := '0';
   signal addparity : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal TXbuff_free : std_logic;
   signal d_hk : std_logic;
   signal dout : std_logic;

   -- Clock period definitions
	constant clk_period : time := 90.42 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   manchester_enc_0: 
	manchester_encoder PORT MAP (
          din => din ,
          load => load,
          enable => enable,
		  addparity => addparity,
          TXbuff_free => TXbuff_free,
          d_hk => d_hk,
          dout => dout,
          clk => clk,
          rstn => rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   variable count : integer range 0 to 3 := 0;
   begin		
	
	if count = 0 then
		rst <= '0';-- hold reset state for 100ms.
		wait for 0.01 us;	
		rst <= '1';
	end if;
	
	case count is
		when 0 =>
			din <= "10101010";
			addparity <= '0';
		when 1 => 
			din <= "11111111";
			addparity <= '0';
		when 2 =>
			din <= "00110011";
			addparity <= '1';
		when others =>
			din <= "00";
			addparity <= '0';
	end case;
	
	wait for clk_period*5;
	load <= '1';
	wait for clk_period;
	load <= '0';
	wait for clk_period;
	enable <= '1';

	wait for clk_period*5;

	-- insert stimulus here 

	wait until rising_edge (TXbuff_free);
	count := count + 1;
	wait for clk_period;
	if  (count = 3) then
		wait until rising_edge (d_hk);
		enable <= '0';
		wait for clk_period;
		wait;
	end if;	
	
   end process;

END;
