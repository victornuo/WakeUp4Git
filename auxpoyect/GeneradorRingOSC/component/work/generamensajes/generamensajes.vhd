----------------------------------------------------------------------
-- Created by SmartDesign Fri Oct 11 13:32:50 2013
-- Version: v11.1 SP3 11.1.3.1
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library igloo;
use igloo.all;
----------------------------------------------------------------------
-- generamensajes entity declaration
----------------------------------------------------------------------
entity generamensajes is
    -- Port list
    port(
        -- Inputs
        EN            : in  std_logic;
        MSB_A_B       : in  std_logic;
        RXI           : in  std_logic;
        Reset         : in  std_logic;
        Sel0          : in  std_logic;
        Sel1          : in  std_logic;
        TXI           : in  std_logic;
        adress1       : in  std_logic;
        adress2       : in  std_logic;
        adress3       : in  std_logic;
        adress4       : in  std_logic;
        b_msg         : in  std_logic;
        din           : in  std_logic;
        extern_msg    : in  std_logic;
        -- Outputs
        CLK_OUT       : out std_logic;
        NewMsgTrigger : out std_logic;
        RXO           : out std_logic;
        TXO           : out std_logic;
        TX_Active     : out std_logic;
        dout          : out std_logic;
        led5          : out std_logic;
        led6          : out std_logic;
        led7          : out std_logic;
        led8          : out std_logic;
        led9          : out std_logic;
        leddin0       : out std_logic;
        leddin1       : out std_logic;
        sel0o         : out std_logic;
        sel1o         : out std_logic
        );
end generamensajes;
----------------------------------------------------------------------
-- generamensajes architecture body
----------------------------------------------------------------------
architecture RTL of generamensajes is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- contador
component contador
    -- Port list
    port(
        -- Inputs
        Clk              : in  std_logic;
        EN               : in  std_logic;
        rstn             : in  std_logic;
        -- Outputs
        milisegundos10   : out std_logic;
        milisegundos100  : out std_logic;
        milisegundos1000 : out std_logic
        );
end component;
-- control
component control
    -- Port list
    port(
        -- Inputs
        MSB_A_B        : in  std_logic;
        TX_active      : in  std_logic;
        adress0        : in  std_logic;
        adress1        : in  std_logic;
        adress2        : in  std_logic;
        adress3        : in  std_logic;
        clk            : in  std_logic;
        din            : in  std_logic;
        rstn           : in  std_logic;
        sendMsg        : in  std_logic;
        -- Outputs
        dout           : out std_logic_vector(1 downto 0);
        led5           : out std_logic;
        led6           : out std_logic;
        led7           : out std_logic;
        led8           : out std_logic;
        led9           : out std_logic;
        leddin0        : out std_logic;
        leddin1        : out std_logic;
        load_TX        : out std_logic;
        nextHopeAdress : out std_logic_vector(7 downto 0);
        start_TX       : out std_logic
        );
end component;
-- detectorflanco
component detectorflanco
    -- Port list
    port(
        -- Inputs
        Clk      : in  std_logic;
        b_msg    : in  std_logic;
        ext_trig : in  std_logic;
        rstn     : in  std_logic;
        -- Outputs
        edge     : out std_logic
        );
end component;
-- INBUF
component INBUF
    -- Port list
    port(
        -- Inputs
        PAD : in  std_logic;
        -- Outputs
        Y   : out std_logic
        );
end component;
-- manchesterEncoderComplete
component manchesterEncoderComplete
    -- Port list
    port(
        -- Inputs
        clk            : in  std_logic;
        din            : in  std_logic_vector(1 downto 0);
        load_din       : in  std_logic;
        nextHopAddress : in  std_logic_vector(7 downto 0);
        rstn           : in  std_logic;
        start          : in  std_logic;
        -- Outputs
        TX_Active      : out std_logic;
        d_hk           : out std_logic;
        dout           : out std_logic
        );
end component;
-- muxRefTime
component muxRefTime
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic;
        Data1_port : in  std_logic;
        Data2_port : in  std_logic;
        Data3_port : in  std_logic;
        Sel0       : in  std_logic;
        Sel1       : in  std_logic;
        -- Outputs
        Result     : out std_logic
        );
end component;
-- RingOscillator
component RingOscillator
    -- Port list
    port(
        -- Inputs
        RESET   : in  std_logic;
        -- Outputs
        CLK_OUT : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_OUT_net_0               : std_logic;
signal contador_0_milisegundos10   : std_logic;
signal contador_0_milisegundos100  : std_logic;
signal contador_0_milisegundos1000 : std_logic;
signal control_0_dout              : std_logic_vector(1 downto 0);
signal control_0_load_TX           : std_logic;
signal control_0_nextHopeAdress_0  : std_logic_vector(7 downto 0);
signal control_0_start_TX          : std_logic;
signal detectorflanco_0_edge       : std_logic;
signal dout_net_0                  : std_logic;
signal INBUF_0_Y                   : std_logic;
signal led5_net_0                  : std_logic;
signal led6_net_0                  : std_logic;
signal led7_net_0                  : std_logic;
signal led8_net_0                  : std_logic;
signal led9_net_0                  : std_logic;
signal leddin0_net_0               : std_logic;
signal leddin1_net_0               : std_logic;
signal NewMsgTrigger_net_0         : std_logic;
signal TX_Active_net_0             : std_logic;
signal dout_net_1                  : std_logic;
signal leddin1_net_1               : std_logic;
signal leddin0_net_1               : std_logic;
signal TX_Active_net_1             : std_logic;
signal sel0o_net_0                 : std_logic;
signal sel1o_net_0                 : std_logic;
signal CLK_OUT_net_1               : std_logic;
signal NewMsgTrigger_net_1         : std_logic;
signal led6_net_1                  : std_logic;
signal led7_net_1                  : std_logic;
signal led5_net_1                  : std_logic;
signal led8_net_1                  : std_logic;
signal led9_net_1                  : std_logic;
signal TXO_net_0                   : std_logic;
signal RXI_net_0                   : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 dout_net_1          <= dout_net_0;
 dout                <= dout_net_1;
 leddin1_net_1       <= leddin1_net_0;
 leddin1             <= leddin1_net_1;
 leddin0_net_1       <= leddin0_net_0;
 leddin0             <= leddin0_net_1;
 TX_Active_net_1     <= TX_Active_net_0;
 TX_Active           <= TX_Active_net_1;
 sel0o_net_0         <= Sel0;
 sel0o               <= sel0o_net_0;
 sel1o_net_0         <= Sel1;
 sel1o               <= sel1o_net_0;
 CLK_OUT_net_1       <= CLK_OUT_net_0;
 CLK_OUT             <= CLK_OUT_net_1;
 NewMsgTrigger_net_1 <= NewMsgTrigger_net_0;
 NewMsgTrigger       <= NewMsgTrigger_net_1;
 led6_net_1          <= led6_net_0;
 led6                <= led6_net_1;
 led7_net_1          <= led7_net_0;
 led7                <= led7_net_1;
 led5_net_1          <= led5_net_0;
 led5                <= led5_net_1;
 led8_net_1          <= led8_net_0;
 led8                <= led8_net_1;
 led9_net_1          <= led9_net_0;
 led9                <= led9_net_1;
 TXO_net_0           <= TXI;
 TXO                 <= TXO_net_0;
 RXI_net_0           <= RXI;
 RXO                 <= RXI_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- contador_0
contador_0 : contador
    port map( 
        -- Inputs
        rstn             => INBUF_0_Y,
        Clk              => CLK_OUT_net_0,
        EN               => EN,
        -- Outputs
        milisegundos10   => contador_0_milisegundos10,
        milisegundos100  => contador_0_milisegundos100,
        milisegundos1000 => contador_0_milisegundos1000 
        );
-- control_0
control_0 : control
    port map( 
        -- Inputs
        clk            => CLK_OUT_net_0,
        din            => din,
        TX_active      => TX_Active_net_0,
        rstn           => INBUF_0_Y,
        sendMsg        => NewMsgTrigger_net_0,
        MSB_A_B        => MSB_A_B,
        adress3        => adress4,
        adress2        => adress3,
        adress1        => adress2,
        adress0        => adress1,
        -- Outputs
        led5           => led5_net_0,
        led6           => led6_net_0,
        led7           => led7_net_0,
        led8           => led8_net_0,
        led9           => led9_net_0,
        leddin1        => leddin1_net_0,
        leddin0        => leddin0_net_0,
        load_TX        => control_0_load_TX,
        start_TX       => control_0_start_TX,
        dout           => control_0_dout,
        nextHopeAdress => control_0_nextHopeAdress_0 
        );
-- detectorflanco_0
detectorflanco_0 : detectorflanco
    port map( 
        -- Inputs
        rstn     => INBUF_0_Y,
        Clk      => CLK_OUT_net_0,
        b_msg    => b_msg,
        ext_trig => extern_msg,
        -- Outputs
        edge     => detectorflanco_0_edge 
        );
-- INBUF_0
INBUF_0 : INBUF
    port map( 
        -- Inputs
        PAD => Reset,
        -- Outputs
        Y   => INBUF_0_Y 
        );
-- manchesterEncoderComplete_0
manchesterEncoderComplete_0 : manchesterEncoderComplete
    port map( 
        -- Inputs
        load_din       => control_0_load_TX,
        start          => control_0_start_TX,
        clk            => CLK_OUT_net_0,
        rstn           => INBUF_0_Y,
        din            => control_0_dout,
        nextHopAddress => control_0_nextHopeAdress_0,
        -- Outputs
        dout           => dout_net_0,
        d_hk           => OPEN,
        TX_Active      => TX_Active_net_0 
        );
-- muxRefTime_0
muxRefTime_0 : muxRefTime
    port map( 
        -- Inputs
        Data0_port => detectorflanco_0_edge,
        Data1_port => contador_0_milisegundos10,
        Data2_port => contador_0_milisegundos100,
        Data3_port => contador_0_milisegundos1000,
        Sel0       => Sel0,
        Sel1       => Sel1,
        -- Outputs
        Result     => NewMsgTrigger_net_0 
        );
-- RingOscillator_0
RingOscillator_0 : RingOscillator
    port map( 
        -- Inputs
        RESET   => INBUF_0_Y,
        -- Outputs
        CLK_OUT => CLK_OUT_net_0 
        );

end RTL;
