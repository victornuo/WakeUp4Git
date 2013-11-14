-- manchester_encoder4WuR.vhd
-- paraidad par el numero total de unos trnsmitido es par (incluido el bit de paridad)
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

-- library wupu_lib;
-- use wupu_lib.wupu_pck.all;
use work.wupu_pck.all;

entity manchester_encoder is
--generic (DIVIDER : integer := 829*2); -- --2400/2 para 48 MHZ |||||   553 para 11.0592 |||| 553*3 para IR a 11.0592 ||| 829*2 para 150 us para starbit (300 para data bit)

port (
    clk 		: in std_logic;
    rstn 		: in std_logic;
	din 		: in std_logic_vector (MEILENGTH-1 downto 0); --data to transmit
    load 		: in std_logic; -- read the data in din 
	enable 		: in std_logic; -- enable manchester encoding
	addparity 	: in std_logic; -- if '1' a extra bit is added to the curret din data as parity bit, the parity is generated in the encoder
    TXbuff_free : out std_logic; -- if '1' TX buffer empty
	--data_end 	: out std_logic; -- if '1' tx buffer is empty
    dout 		: out std_logic; -- manchester data encoded 
    d_hk 		: out std_logic -- done housekeeping
    
    );
end manchester_encoder;

architecture rtl of manchester_encoder is

signal symbol_t : integer range 0 to ENCODER_REF;

signal manchesterRef : std_logic;
signal bit_count : integer range 0 to MEILENGTH; --MSGLENGTH-1; -- Preamble + starrsequence + 2 msg type + 16 bits + parity
signal rsr : std_logic_vector (MEILENGTH-1 downto 0);
-- signal tx_bit : std_logic;
signal active_bit : std_logic;

signal tc : std_logic;
signal last_bit : std_logic;
signal last_bit_sent : std_logic;
signal bit_end : std_logic; -- Cout_half xor Cout

signal before_last_bit : std_logic; -- Cout_half xor Cout
signal TXBufferEmpty : std_logic; -- Cout_half xor Cout

signal encoder_busy : std_logic; -- activa por nivel alto (1 mientras envio)
--signal encoder_busy: std_logic;
signal Enable_freqref: std_logic;
signal rstn_freqRef: std_logic;
signal parityBit:std_logic;
signal parityBit_reg:std_logic;
signal mdo: std_logic;
signal parity_flag : std_logic;

signal loadactivebit : std_logic;
signal regload : std_logic;

signal continueFlag : std_logic;



begin

	
	Enable_freqref <= enable or encoder_busy; -- deadTimeElapsed and enable;
	-- hay q hacerlo con un for
	-- parityBit <= NextHopAddress (15) xor NextHopAddress (14) xor NextHopAddress (13) xor NextHopAddress (12) xor NextHopAddress (11) xor NextHopAddress (10)
					-- xor NextHopAddress (9) xor NextHopAddress (8) xor NextHopAddress (7) xor NextHopAddress (6) xor NextHopAddress (5) xor NextHopAddress (4)
					-- xor NextHopAddress (3) xor NextHopAddress (2) xor NextHopAddress (1) xor NextHopAddress (0);
	
	parityBit_gen: process (din)				
	variable parityBit_aux: std_logic;
	begin
		parityBit_aux := din (0);
		for i in 1 to MEILENGTH-1 loop
			parityBit_aux := parityBit_aux xor din (i); --- parityBit
		end loop;
		
		parityBit <= not parityBit_aux; -- para paraidad par con '0' 
	end process;
	
	parityBit_flag_p: process (clk, rstn)
	begin
		if rstn = '0' then
			parity_flag <= '0';			
		elsif clk'event and clk = '1' then
			if bit_end = '1' then
				parity_flag <= '0';	
			elsif load = '1' and addparity = '1' then
				parity_flag <= '1';				
			end if;
		end if;
	end process;
	
	parityBit_reg_p: process (clk, rstn)
	begin
		if rstn = '0' then
			parityBit_reg <= '0';
		elsif clk'event and clk = '1' then
			if last_bit_sent = '0' then
				parityBit_reg <= '0';	
			elsif load = '1' and addparity = '1' then
				parityBit_reg <= parityBit;			
			end if;
		end if;
	end process;
	
	ContinueFlag_p: process (clk, rstn)
	begin
		if rstn = '0' then
			continueFlag <= '0';
		elsif clk'event and clk = '1' then
			if TXBufferEmpty = '1' then
				continueFlag <= '0';	
			elsif load = '1' then
				continueFlag <= '1';			
			end if;
		end if;
	end process;
	
	-- genero la señal de referencia de ENCODER_REF ciclos
    process (clk, rstn)
    begin
        if rstn = '0' then
            symbol_t <= 0;
            manchesterRef <= '0';

        elsif clk'event and clk = '1' then
            if encoder_busy = '0'  then
				symbol_t <= 0;
				manchesterRef <= '0';

			elsif encoder_busy = '1' and load = '0' then --elsif enable = '1' and load = '0' then
				if symbol_t = ENCODER_REF then
             		manchesterRef <= not manchesterRef;
					symbol_t <= 0;
				else
                    symbol_t <= symbol_t + 1;
                end if;
            end if;
        end if;
    end process;
	
		process (symbol_t, manchesterRef)
    begin
        if symbol_t = ENCODER_REF and manchesterRef = '1' then
            tc <= '1';
        else
            tc <= '0';
        end if;
	end process;
	
	
	bit_end <= tc and manchesterRef;

    -- control del flag encoder-busy q indica q el encoder esta funcionando
	process (clk, rstn)
    begin
        if rstn = '0' then
            encoder_busy <= '0';
        elsif clk'event and clk = '1' then
            if loadactivebit = '1'  then
                encoder_busy <= '1' ;
            elsif last_bit_sent = '1' and continueFlag = '0' then
                encoder_busy <= '0' ;
            end if;
        end if;
    end process;
	
	process (clk, rstn)
    begin
        if rstn = '0' then
            regload <= '0';
        elsif clk'event and clk = '1' then
            regload <= load;
        end if;
    end process;
	
	loadactivebit <= regload and (not load);
	
	d_hk <= not encoder_busy;
	last_bit_sent <= last_bit and bit_end;
	
    load_rsr_p: process (clk, rstn)
    begin
        if rstn = '0' then
            rsr <= (others => '0');
		elsif clk'event and clk = '1' then
            if  load = '1' then
				rsr <= din ;
			elsif bit_end = '1' or (loadactivebit = '1' and encoder_busy = '0')then
				rsr <= rsr (MEILENGTH-2 downto 0) & parityBit_reg; 
			end if;
        end if;
   end process;
    
	
	process (clk, rstn)
    begin
        if rstn = '0' then
            active_bit <= '0';
		elsif clk'event and clk = '1' then
			if bit_end = '1' or (loadactivebit = '1' and encoder_busy = '0') then
				active_bit <= rsr (MEILENGTH-1);
			end if;
        end if;
   end process;
   
   	process (clk, rstn)
    begin
        if rstn = '0' then
            TXbuff_free <= '1';
		elsif clk'event and clk = '1' then
			if TXBufferEmpty = '1' then
				TXbuff_free <= '1' ;
			elsif load = '1' then
				TXbuff_free <= '0';
			end if;
        end if;
   end process;
	TXBufferEmpty <= before_last_bit and bit_end;
	
	last_bit <= '1' when bit_count = 0 else '0';
	before_last_bit <= '1' when bit_count = 1 else '0';
	
	bit_counter_p : process (clk, rstn)
    begin
        if rstn = '0' then
			bit_count <= 0; --18			
        elsif clk'event and clk = '1' then
			if load = '1' and encoder_busy = '0' then
				bit_count <= MEILENGTH-1; --7--tamaño minimo
		
			elsif encoder_busy = '1' and bit_end = '1' and parity_flag = '0'then  -- elsif enable = '1' and bit_end = '1' and parity_flag = '0'then 
				if bit_count = 0 then
					bit_count <= MEILENGTH-1;
				else
					bit_count <= bit_count - 1;
				end if;

			end if;
		end if;
	end process;
	mdo <= (manchesterRef xor active_bit) and encoder_busy;
	dout <= mdo;
	 
	-- mdo_p : process (clk, rstn)
    -- begin
        -- if rstn = '0' then
            -- mdo <= '0';
        -- elsif clk'event and clk = '1' then
            -- if encoder_busy = '0' then
				-- mdo <= '0';
			-- elsif enable = '1' then -- and deadTimeElapsed = '1' and load = '0' then
				-- mdo <= manchesterRef xor active_bit;
			-- end if;
        -- end if;

    -- end process;

	
end;