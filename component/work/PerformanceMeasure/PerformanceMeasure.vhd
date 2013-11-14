----------------------------------------------------------------------
-- Created by SmartDesign Tue Nov 12 18:53:08 2013
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
-- PerformanceMeasure entity declaration
----------------------------------------------------------------------
entity PerformanceMeasure is
    -- Port list
    port(
        -- Inputs
        ClearPerformData : in  std_logic;
        CntTX            : in  std_logic;
        MsgType          : in  std_logic;
        NewMsg           : in  std_logic;
        RaisePMFlag      : in  std_logic;
        clk              : in  std_logic;
        rstn             : in  std_logic;
        -- Outputs
        PM_DataReady     : out std_logic;
        PM_TXCounter     : out std_logic_vector(2 downto 0);
        PM_msgType       : out std_logic;
        d_hk             : out std_logic
        );
end PerformanceMeasure;
----------------------------------------------------------------------
-- PerformanceMeasure architecture body
----------------------------------------------------------------------
architecture RTL of PerformanceMeasure is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AND2A
component AND2A
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- CuentaEnvios
component CuentaEnvios
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(2 downto 0)
        );
end component;
-- DFN1E1C0
component DFN1E1C0
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        CLR : in  std_logic;
        D   : in  std_logic;
        E   : in  std_logic;
        -- Outputs
        Q   : out std_logic
        );
end component;
-- edgedetector
component edgedetector
    -- Port list
    port(
        -- Inputs
        clk  : in  std_logic;
        rstn : in  std_logic;
        sin  : in  std_logic;
        -- Outputs
        edge : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AND2A_0_Y           : std_logic;
signal edgedetector_0_edge : std_logic;
signal edgedetector_1_edge : std_logic;
signal PM_DataReady_net_0  : std_logic;
signal PM_msgType_net_0    : std_logic;
signal PM_TXCounter_net_0  : std_logic_vector(2 downto 0);
signal PM_msgType_net_1    : std_logic;
signal PM_DataReady_net_1  : std_logic;
signal PM_TXCounter_net_1  : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net             : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal PM_DataReady_net_2  : std_logic;
signal d_hk_OUT_PRE_INV0_0 : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 PM_DataReady_net_2 <= NOT d_hk_OUT_PRE_INV0_0;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 PM_msgType_net_1         <= PM_msgType_net_0;
 PM_msgType               <= PM_msgType_net_1;
 PM_DataReady_net_1       <= PM_DataReady_net_0;
 PM_DataReady             <= PM_DataReady_net_1;
 d_hk_OUT_PRE_INV0_0      <= PM_DataReady_net_0;
 d_hk                     <= PM_DataReady_net_2;
 PM_TXCounter_net_1       <= PM_TXCounter_net_0;
 PM_TXCounter(2 downto 0) <= PM_TXCounter_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2A_0
AND2A_0 : AND2A
    port map( 
        -- Inputs
        A => ClearPerformData,
        B => rstn,
        -- Outputs
        Y => AND2A_0_Y 
        );
-- CuentaEnvios_0
CuentaEnvios_0 : CuentaEnvios
    port map( 
        -- Inputs
        Aclr   => AND2A_0_Y,
        Clock  => clk,
        Enable => edgedetector_0_edge,
        -- Outputs
        Q      => PM_TXCounter_net_0 
        );
-- DFN1E1C0_0
DFN1E1C0_0 : DFN1E1C0
    port map( 
        -- Inputs
        D   => VCC_net,
        CLK => clk,
        CLR => AND2A_0_Y,
        E   => RaisePMFlag,
        -- Outputs
        Q   => PM_DataReady_net_0 
        );
-- DFN1E1C0_1
DFN1E1C0_1 : DFN1E1C0
    port map( 
        -- Inputs
        D   => MsgType,
        CLK => clk,
        CLR => AND2A_0_Y,
        E   => edgedetector_1_edge,
        -- Outputs
        Q   => PM_msgType_net_0 
        );
-- edgedetector_0
edgedetector_0 : edgedetector
    port map( 
        -- Inputs
        sin  => CntTX,
        clk  => clk,
        rstn => rstn,
        -- Outputs
        edge => edgedetector_0_edge 
        );
-- edgedetector_1
edgedetector_1 : edgedetector
    port map( 
        -- Inputs
        sin  => NewMsg,
        clk  => clk,
        rstn => rstn,
        -- Outputs
        edge => edgedetector_1_edge 
        );

end RTL;
