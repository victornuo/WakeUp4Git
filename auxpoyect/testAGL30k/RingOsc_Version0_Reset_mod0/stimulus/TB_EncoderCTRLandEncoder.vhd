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
 
ENTITY TB_ctrlAndEnc IS
END TB_ctrlAndEnc;
 
ARCHITECTURE MEI_parity OF TB_ctrlAndEnc IS 
 
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
    
	
	COMPONENT manchester_encoder_ctrl
	port (
		din : in std_logic_vector (1 downto 0);
		load_din : in std_logic;
		nextHopAddress : in std_logic_vector (ADDRESSLENGTH-1 downto 0);
		Encoderfree : in std_logic;
		start : in std_logic;
		loadEncoder : out std_logic;
		enableEncoder : out std_logic;
		dout : out std_logic_vector (MEILENGTH-1 downto 0);
		addParity : out std_logic;
		d_hk : out std_logic;
		clk : in std_logic;
		rstn : in std_logic
    );
	END COMPONENT;
	
   --Inputs
	signal commandIn : std_logic_vector (1 downto 0):= "00";
   	signal	load_din :  std_logic := '0';
	signal	nextHopAddress :  std_logic_vector (ADDRESSLENGTH-1 downto 0) := "11001100";
	signal	start :  std_logic := '0';
	signal	d_hk_ctrl :  std_logic := '0';

    signal din : std_logic_vector (MEILENGTH-1 downto 0):= "00000000";
   signal load : std_logic := '0';
   signal enable : std_logic := '0';
   signal addparity : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
 	
	--Outputs
   signal TXbuff_free : std_logic;
   signal d_hk_enc : std_logic;
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
          d_hk => d_hk_enc,
          dout => dout,
          clk => clk,
          rstn => rst
        );
		
	manchester_encoder_ctrl_0 :
	manchester_encoder_ctrl port map (
		din => commandIn, -- : in std_logic_vector (1 downto 0);
		load_din => load_din, -- : in std_logic;
		nextHopAddress => nextHopAddress, --: in std_logic_vector (ADDRESSLENGTH-1 downto 0);
		Encoderfree => TXbuff_free,-- : in std_logic;
		start => start, -- : in std_logic;
		loadEncoder => load, --: out std_logic;
		enableEncoder => enable,-- : out std_logic;
		dout => din, --: out std_logic_vector (MEILENGTH-1 downto 0);
		addParity => addparity, --: out std_logic;
		d_hk => d_hk_ctrl,--: out std_logic;
		clk => clk,--: in std_logic;
		rstn => rst --: in std_logic
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
			commandIn <= "10";
		when 1 => 
			commandIn <= "00";
		when others =>
			commandIn <= "00";

	end case;
	
	wait for clk_period*5;
	load_din <= '1';
	wait for clk_period*5;
	load_din <= '0';
	wait for clk_period;
	start <= '1';

-- insert stimulus here 

	wait until rising_edge (d_hk_ctrl);
	start <= '0';
	wait for 2000 us;
	count := count + 1;
	
	
	wait for clk_period*10;
	
	if  (count = 2) then
		
		wait;
	end if;	
	
   end process;

END;
