----------------------------------------------------------------------
-- Created by SmartDesign Mon Jul 01 18:42:19 2013
-- Version: v11.1 11.1.0.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library igloo;
use igloo.all;
----------------------------------------------------------------------
-- manchesterEncoderComplete entity declaration
----------------------------------------------------------------------
entity manchesterEncoderComplete is
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
end manchesterEncoderComplete;
----------------------------------------------------------------------
-- manchesterEncoderComplete architecture body
----------------------------------------------------------------------
architecture RTL of manchesterEncoderComplete is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AND2
component AND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- manchester_encoder
component manchester_encoder
    -- Port list
    port(
        -- Inputs
        addparity   : in  std_logic;
        clk         : in  std_logic;
        din         : in  std_logic_vector(7 downto 0);
        load        : in  std_logic;
        rstn        : in  std_logic;
        -- Outputs
        TXbuff_free : out std_logic;
        d_hk        : out std_logic;
        dout        : out std_logic
        );
end component;
-- manchester_encoder_ctrl
component manchester_encoder_ctrl
    -- Port list
    port(
        -- Inputs
        Encoderfree    : in  std_logic;
        clk            : in  std_logic;
        din            : in  std_logic_vector(1 downto 0);
        load_din       : in  std_logic;
        nextHopAddress : in  std_logic_vector(7 downto 0);
        rstn           : in  std_logic;
        start          : in  std_logic;
        -- Outputs
        addParity      : out std_logic;
        d_hk           : out std_logic;
        dout           : out std_logic_vector(7 downto 0);
        loadEncoder    : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal d_hk_net_0                            : std_logic;
signal dout_net_0                            : std_logic;
signal manchester_encoder_0_TXbuff_free      : std_logic;
signal manchester_encoder_ctrl_0_addParity   : std_logic;
signal manchester_encoder_ctrl_0_d_hk        : std_logic;
signal manchester_encoder_ctrl_0_dout        : std_logic_vector(7 downto 0);
signal manchester_encoder_ctrl_0_loadEncoder : std_logic;
signal TX_Active_net_0                       : std_logic;
signal dout_net_1                            : std_logic;
signal d_hk_net_1                            : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal TX_Active_net_1                       : std_logic;
signal TX_Active_OUT_PRE_INV0_0              : std_logic;

begin
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 TX_Active_net_1 <= NOT TX_Active_OUT_PRE_INV0_0;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 dout_net_1               <= dout_net_0;
 dout                     <= dout_net_1;
 d_hk_net_1               <= d_hk_net_0;
 d_hk                     <= d_hk_net_1;
 TX_Active_OUT_PRE_INV0_0 <= TX_Active_net_0;
 TX_Active                <= TX_Active_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => TX_Active_net_0,
        B => manchester_encoder_ctrl_0_d_hk,
        -- Outputs
        Y => d_hk_net_0 
        );
-- manchester_encoder_0
manchester_encoder_0 : manchester_encoder
    port map( 
        -- Inputs
        clk         => clk,
        rstn        => rstn,
        load        => manchester_encoder_ctrl_0_loadEncoder,
        addparity   => manchester_encoder_ctrl_0_addParity,
        din         => manchester_encoder_ctrl_0_dout,
        -- Outputs
        TXbuff_free => manchester_encoder_0_TXbuff_free,
        dout        => dout_net_0,
        d_hk        => TX_Active_net_0 
        );
-- manchester_encoder_ctrl_0
manchester_encoder_ctrl_0 : manchester_encoder_ctrl
    port map( 
        -- Inputs
        load_din       => load_din,
        Encoderfree    => manchester_encoder_0_TXbuff_free,
        start          => start,
        clk            => clk,
        rstn           => rstn,
        din            => din,
        nextHopAddress => nextHopAddress,
        -- Outputs
        loadEncoder    => manchester_encoder_ctrl_0_loadEncoder,
        addParity      => manchester_encoder_ctrl_0_addParity,
        d_hk           => manchester_encoder_ctrl_0_d_hk,
        dout           => manchester_encoder_ctrl_0_dout 
        );

end RTL;
