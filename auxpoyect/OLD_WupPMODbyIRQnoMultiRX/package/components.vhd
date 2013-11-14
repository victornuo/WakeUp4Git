library ieee;
use IEEE.STD_logic_1164.all;
package ZBHandler_COREUART_0_componentS is

component ZBHandler_COREUART_0_CoreUARTAPB
generic (rx_legACY_MODE: INTEGER := 0;
family: INTEGER := 15;
TX_fifo: integer := 0;
rx_fifo: inteGER := 0;
BAUd_value: integer := 0;
fixedmoDE: INTEGER := 0;
prg_bIT8: INTEGER := 0;
PRG_parity: integeR := 0;
BAUD_VAl_frctn: integer := 0;
BAUD_VAl_frctn_en: INTEGER := 0);
port (pclk: in STD_logic;
PRESetn: in std_logic;
PADDR: in std_logic_vectOR(4 downto 0);
psel: in std_logIC;
PENABLE: in STD_LOGic;
pwrite: in std_logic;
pWDATA: in STD_LOGIc_vector(7 downto 0);
PRDATA: out std_logic_vectoR(7 downto 0);
pready: out STD_LOGIC;
PSlverr: out STd_logic;
TXRDY: out STD_Logic;
rxrDY: out std_logiC;
FRAMING_err: out std_logiC;
pariTY_ERR: out STD_LOGIC;
overfloW: out std_logIC;
RX: in STd_logic;
TX: out std_LOGIC);
end component;
end ZBHandler_COREUART_0_COMPONEnts;
