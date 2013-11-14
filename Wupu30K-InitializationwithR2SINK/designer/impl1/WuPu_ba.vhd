-- Version: v11.1 SP3 11.1.3.1
-- File used only for Simulation

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity WuPu is

    port( NWKrRouteTimeout : in    std_logic;
          R2SINKTimeout    : in    std_logic;
          RST              : in    std_logic;
          RX               : in    std_logic;
          Wakeup           : in    std_logic;
          selAdd           : in    std_logic_vector(2 downto 0);
          selExp           : in    std_logic_vector(1 downto 0);
          uC_commandReady  : in    std_logic;
          uC_commandType   : in    std_logic;
          AddOKflag        : out   std_logic;
          CLK_GATED        : out   std_logic;
          CTRL1_Enab       : out   std_logic;
          CommandReady2ZB  : out   std_logic;
          CommandType2ZB   : out   std_logic;
          Decoder_hk       : out   std_logic;
          IRQ0             : out   std_logic;
          IRQ1             : out   std_logic;
          IRQ2             : out   std_logic;
          IRQ3             : out   std_logic;
          LedMochila       : out   std_logic;
          MoMstateLed      : out   std_logic_vector(2 downto 0);
          RESETZB          : out   std_logic;
          RX_OUT           : out   std_logic;
          TX               : out   std_logic;
          f32              : out   std_logic;
          f59              : out   std_logic;
          CTRL1            : inout std_logic := 'Z'
        );

end WuPu;

architecture DEF_ARCH of WuPu is 

  component NOR3A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR3B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO14
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component XNOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NOR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOTRI_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component IOPAD_TRI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component DFN1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component OR2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component DFN0E1C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component NOR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOIN_IB
    port( YIN : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component AO1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1D
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OR2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component OR3A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_TRI_D
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component OR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1E0C0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component OR3B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OA1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO1D
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_IN_D
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component AX1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component XA1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OA1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OA1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_TRI_U
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component OA1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component ULSICC_INT
    port( USTDBY : in    std_logic := 'U';
          LPENA  : in    std_logic := 'U'
        );
  end component;

  component XA1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XO1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1P0
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          PRE : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component OR3C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AOI1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XA1A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOBI_IB_OB_EB
    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          YIN  : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic;
          Y    : out   std_logic
        );
  end component;

  component XOR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1E
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AO1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component NAND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2A
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XO1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DLN0
    port( D : in    std_logic := 'U';
          G : in    std_logic := 'U';
          Q : out   std_logic
        );
  end component;

  component OAI1
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1B
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AX1C
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component XNOR3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_BI
    port( D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic;
          PAD : inout   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal bit_error_1, command_process_0_newMsg, 
        \command_process_0_msgType_0[0]\, 
        \command_process_0_msgType_0[1]\, AddOKflag_0, 
        LowpoerM_hk, MoM_unit_0_d_hk, 
        InintialMsgInjector_0_NewMsgInjector, 
        RingOscillator_0_CLK_OUT, 
        \MoM_unit_0_commandToEncoder[1]\, \ZBControl_0.N_4\, 
        \MoM_unit_0.state[4]\, \MoM_unit_0.N_19\, 
        \md_v4_0.receiving\, \md_v4_0.mdi2\, 
        \md_v4_0.dataFiltered\, \md_v4_0.newDataEdgeAux\, 
        manchesterEncoderComplete_0_TX_Active, 
        \command_process_0.state[1]\, 
        \command_process_0.state[9]\, NWKrRouteTimeout_c, 
        R2SINKTimeout_c, \selAdd_c[0]\, \selAdd_c[1]\, 
        \selAdd_c[2]\, \selExp_c[0]\, \selExp_c[1]\, 
        uC_commandReady_c, uC_commandType_c, AddOKflag_c, 
        CLK_GATED_c, CommandReady2ZB_c, CommandType2ZB_c, 
        IRQ1_c_c, IRQ3_c, LedMochila_c, \MoMstateLed_c[0]\, 
        \MoMstateLed_c[1]\, \MoMstateLed_c[2]\, RESETZB_c, RX_c_c, 
        TX_c, \command_process_0.N_150\, md_v4_0_new_data, 
        MoM_unit_0_RX_processed, \command_process_0.N_76\, 
        md_v4_0_RX_end, MoM_unit_0_TX_load, 
        \addressingData_0_NextHopAddress_0[3]\, 
        \addressingData_0_NodeAddress_0[0]\, 
        \addressingData_0.N_58\, 
        \addressingData_0.un6_msb_nexthopaddress_2\, 
        \addressingData_0.un3_msb_nexthopaddress\, 
        \addressingData_0_NextHopAddress_0[0]\, 
        \addressingData_0_NextHopAddress_0[1]\, 
        \addressingData_0_NextHopAddress_0[2]\, 
        CommandType2ZB_c_i, \MoM_unit_0_commandToEncoder_i[1]\, 
        INBUF_0, Encoder_hk, \command_process_0.N_148\, 
        \command_process_0.N_435\, \command_process_0.N_108\, 
        \housekeepingCheck_0.Result_5\, 
        \command_process_0.un2_dataclean_5_i_a9_1_0\, 
        \command_process_0.un1_commProc_busy_1_0_a2_0_1\, 
        \MoM_unit_0.N_17\, \MoM_unit_0.N_98\, 
        \MoM_unit_0.un2_contentiontimeexpired\, 
        \command_process_0/bitCounterlde_0_0\, 
        \command_process_0/bitCounterlde_0_a9_1_1\, 
        \command_process_0/N_59\, \command_process_0/N_121\, 
        \command_process_0/ParityRX_2_0_0\, 
        \command_process_0/ParityRX_net_1\, 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, 
        \command_process_0/N_1\, 
        \command_process_0/un1_commProc_busy_1_0_a9_0\, 
        \command_process_0/N_181\, \command_process_0/N_67\, 
        \command_process_0/state_ns_0_a9_2_0[0]\, 
        \command_process_0/state[0]_net_1\, 
        \command_process_0/un2_address_end_0_a2_2_o4_1\, 
        \command_process_0/bitCounter[2]_net_1\, 
        \command_process_0/bitCounter[0]_net_1\, 
        \command_process_0/un2_address_end_0_a2_2_o4_0\, 
        \command_process_0/bitCounter[3]_net_1\, 
        \command_process_0/bitCounter[1]_net_1\, 
        \command_process_0/bitCounterlde_0_a9_1_0\, 
        \command_process_0/reg_command_error_net_1\, 
        \command_process_0/reg_short_command_net_1\, 
        \command_process_0/un2_dataclean_1_i_o4_1\, 
        \command_process_0/state[5]_net_1\, 
        \command_process_0/state[2]_net_1\, 
        \command_process_0/un2_dataclean_1_i_o4_0\, 
        \command_process_0/state[4]_net_1\, 
        \command_process_0/state[3]_net_1\, 
        \command_process_0/N_2_0\, 
        \command_process_0/reg_long_command_2\, 
        \command_process_0/commandRX[2]_net_1\, 
        \command_process_0/reg_short_command_3_2\, 
        \command_process_0/commandRX[0]_net_1\, 
        \command_process_0/reg_short_command_3\, 
        \command_process_0/N_133\, 
        \command_process_0/un10_reg_set_newmessage\, 
        \command_process_0/N_134\, 
        \command_process_0/addressRX_3[2]\, 
        \command_process_0/addressRX[1]_net_1\, 
        \command_process_0/addressRX_3[4]\, 
        \command_process_0/addressRX[3]_net_1\, 
        \command_process_0/addressRX_3[5]\, 
        \command_process_0/addressRX[4]_net_1\, 
        \command_process_0/addressRX_3[7]\, 
        \command_process_0/addressRX[6]_net_1\, 
        \command_process_0/N_55\, 
        \command_process_0/addressRX[5]_net_1\, 
        \command_process_0/N_10\, \command_process_0/N_149\, 
        \command_process_0/N_69\, 
        \command_process_0/reg_long_command_net_1\, 
        \command_process_0/N_118\, \command_process_0/N_167\, 
        \command_process_0/un1_dataclean\, 
        \command_process_0/N_23\, 
        \command_process_0/commandRX_3[0]\, 
        \command_process_0/addressRX_3[1]\, 
        \command_process_0/addressRX[0]_net_1\, 
        \command_process_0/addressRX_3[3]\, 
        \command_process_0/addressRX[2]_net_1\, 
        \command_process_0/commandRX_3[1]\, 
        \command_process_0/commandRX_3[2]\, 
        \command_process_0/commandRX[1]_net_1\, 
        \command_process_0/commandRX_3[3]\, 
        \command_process_0/commandRX[3]_net_1\, 
        \command_process_0/N_5\, \command_process_0/N_105\, 
        \command_process_0/un1_commProc_busy_1_0_0_0\, 
        \command_process_0/un2_dataclean_5_i_1\, 
        \command_process_0/un2_dataclean_5_i_a9_0_0\, 
        \command_process_0/N_58\, \command_process_0/N_110\, 
        \command_process_0/un2_dataclean_5_i_0\, 
        \command_process_0/N_111\, 
        \command_process_0/state_ns_0_2[0]\, 
        \command_process_0/state_ns_0_0[0]\, 
        \command_process_0/N_130\, 
        \command_process_0/bitCounterlde_0_o2_0\, 
        \command_process_0/N_146\, \command_process_0/N_14\, 
        \command_process_0/ParityRX_2\, 
        \command_process_0/state_RNO[4]_net_1\, 
        \command_process_0/N_100\, \command_process_0/N_78\, 
        \command_process_0/bitCountere\, 
        \command_process_0/N_122\, \command_process_0/N_39\, 
        \command_process_0/bitCounter_n2_i_0\, 
        \command_process_0/N_37\, 
        \command_process_0/bitCounter_n1_i_0\, 
        \command_process_0/state[8]_net_1\, 
        \command_process_0/state[6]_net_1\, 
        \command_process_0/state[7]_net_1\, 
        \command_process_0/state_ns[0]\, 
        \command_process_0/N_102\, \command_process_0/N_62\, 
        \command_process_0/state_RNO[8]_net_1\, 
        \command_process_0/N_147\, 
        \command_process_0/state_RNO[5]_net_1\, 
        \command_process_0/N_124\, 
        \command_process_0/state_RNO[6]_net_1\, 
        \command_process_0/N_96\, 
        \command_process_0/state_RNO[7]_net_1\, 
        \command_process_0/N_95\, \command_process_0/N_184\, 
        \command_process_0/N_127\, \command_process_0/N_41\, 
        \command_process_0/N_90_i\, \command_process_0/N_70\, 
        \command_process_0/state_ns_0_a9_1_0[0]\, 
        \command_process_0/state_ns_i_0_a9_0_0[9]\, 
        \command_process_0/addok_NE_0_4\, 
        \command_process_0/addok_NE_0_1\, 
        \command_process_0/addok_NE_0_3\, 
        \command_process_0/N_86_i\, 
        \command_process_0/addok_NE_0_2\, 
        \command_process_0/N_88_i\, 
        \command_process_0/addressRX[7]_net_1\, 
        \command_process_0/reg_set_newMessage_net_1\, 
        \command_process_0/addok_NE\, \command_process_0/N_126\, 
        \command_process_0/state_RNO[0]_net_1\, 
        \command_process_0/N_125\, 
        \command_process_0/set_newMessage\, 
        \command_process_0/set_newMessage_0_0_a9_0_0\, 
        \command_process_0/set_newMessage_0_0_a9_0\, 
        \command_process_0/msgType_3[1]\, 
        \command_process_0/AddOKflag_2\, 
        \command_process_0/addOK_reg_net_1\, 
        \command_process_0/N_80\, \command_process_0/N_99\, 
        \command_process_0/N_98_0\, \command_process_0/N_97\, 
        \command_process_0/state_RNO[1]_net_1\, 
        \command_process_0/state_RNO[2]_net_1\, 
        \command_process_0/state_RNO[3]_net_1\, 
        \command_process_0/msgType_3[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        \manchesterEncoderComplete_0/state[3]\, 
        \manchesterEncoderComplete_0/cuentaEnvios[0]\, 
        \manchesterEncoderComplete_0/cuentaEnvios[1]\, 
        \manchesterEncoderComplete_0/cuentaEnvios[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[4]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[0]\, 
        \manchesterEncoderComplete_0/loadEncoder_i_a3_0_a3_0\, 
        \manchesterEncoderComplete_0/load_i_1\, 
        \manchesterEncoderComplete_0/N_27\, 
        \manchesterEncoderComplete_0/N_29\, 
        \manchesterEncoderComplete_0/N_6\, 
        \manchesterEncoderComplete_0/N_243\, 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_53\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_i_0[3]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[1]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_0[1]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[6]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_57\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_0_0[1]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_82\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_59\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_0[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0_0[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_n1_i_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0[4]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_0_0[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_1_0[3]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvioslde_i_i_o2_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_65\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[3]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_63\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_64\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_20\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_88\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_70\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_33\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[4]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_52\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_73\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_72\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_83\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_15\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_i_a3_0_0[5]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_39\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_77\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_35\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_45_i\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_46\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_66\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[1]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[3]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_pog_array_1[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12_1[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_TMP[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_i\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_encoder_busy_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa_1_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_1_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_2\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[5]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_2_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_65_i\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[5]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_encoder_busy_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[4]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[1]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_last_bit_sent\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit_sent_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/loadactivebit\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_23\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_22\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_117\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_7_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[1]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[0]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[2]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[1]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[3]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[2]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[4]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[3]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[5]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[4]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[6]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[5]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[7]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[6]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_116\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_115\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_counte\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_load\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un10_load\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un6_bit_end\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un4_bit_end\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/regload_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_4\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_3\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_2\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_0\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/continueFlag_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_3\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/active_bit_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_load\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[7]_net_1\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_partial_sum[0]\, 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_21\, 
        \housekeepingCheck_0/Result_5_4_net_1\, 
        \housekeepingCheck_0/Result_5_2_net_1\, 
        \housekeepingCheck_0/Result_5_1_net_1\, 
        \InintialMsgInjector_0/aux5_RNO_net_1\, 
        \InintialMsgInjector_0/aux5_net_1\, 
        \InintialMsgInjector_0/aux5_i\, 
        \InintialMsgInjector_0/aux2_2\, 
        \InintialMsgInjector_0/aux1_net_1\, 
        \InintialMsgInjector_0/aux3_2\, 
        \InintialMsgInjector_0/aux2_net_1\, 
        \InintialMsgInjector_0/aux4_2\, 
        \InintialMsgInjector_0/aux3_net_1\, 
        \addressingData_0/un6_msb_nexthopaddress_net_1\, 
        \addressingData_0/un3_msb_nexthopaddress_1_net_1\, 
        \ZBControl_0/N_17\, \ZBControl_0/state_i_0[1]\, 
        \ZBControl_0/state[0]_net_1\, 
        \ZBControl_0/state_ns_0_i_0[1]\, \ZBControl_0/N_8\, 
        \ZBControl_0/N_9\, \ZBControl_0/commandTypeIN_net_1\, 
        \ZBControl_0/N_14\, \MoM_unit_0/un13_timeoutack_0_o2_4\, 
        \MoM_unit_0/aux_timeOut[5]_net_1\, 
        \MoM_unit_0/aux_timeOut[7]_net_1\, 
        \MoM_unit_0/un13_timeoutack_0_o2_2\, 
        \MoM_unit_0/un13_timeoutack_0_o2_3\, 
        \MoM_unit_0/aux_timeOut[12]_net_1\, 
        \MoM_unit_0/aux_timeOut[10]_net_1\, 
        \MoM_unit_0/un13_timeoutack_0_o2_1\, 
        \MoM_unit_0/aux_timeOut[8]_net_1\, 
        \MoM_unit_0/aux_timeOut[9]_net_1\, 
        \MoM_unit_0/aux_timeOut[1]_net_1\, 
        \MoM_unit_0/aux_timeOut[11]_net_1\, 
        \MoM_unit_0/aux_timeOut[2]_net_1\, 
        \MoM_unit_0/aux_timeOut_c7_0_o2_0\, \MoM_unit_0/N_76\, 
        \MoM_unit_0/N_64\, \MoM_unit_0/N_36\, 
        \MoM_unit_0/aux_timeOut_n7_i_1\, \MoM_unit_0/N_85\, 
        \MoM_unit_0/N_301_tz\, \MoM_unit_0/N_116_1\, 
        \MoM_unit_0/un26_commandreceived\, 
        \MoM_unit_0/aux_timeOut_n2\, 
        \MoM_unit_0/aux_timeOut_n2_tz\, 
        \MoM_unit_0/aux_timeOut_n3\, 
        \MoM_unit_0/aux_timeOut_n3_tz\, 
        \MoM_unit_0/aux_timeOut_n4\, 
        \MoM_unit_0/aux_timeOut_n4_tz\, 
        \MoM_unit_0/aux_timeOut_n5\, 
        \MoM_unit_0/aux_timeOut_n5_tz\, 
        \MoM_unit_0/aux_timeOut_n6\, 
        \MoM_unit_0/aux_timeOut_n6_tz\, 
        \MoM_unit_0/aux_timeOut_n12\, 
        \MoM_unit_0/aux_timeOut_58_0\, 
        \MoM_unit_0/aux_timeOut_n11\, 
        \MoM_unit_0/aux_timeOut_c10\, 
        \MoM_unit_0/aux_timeOut_n10\, \MoM_unit_0/aux_timeOut_c9\, 
        \MoM_unit_0/aux_timeOut_n9\, \MoM_unit_0/aux_timeOut_c8\, 
        \MoM_unit_0/N_74\, \MoM_unit_0/aux_timeOut_n0\, 
        \MoM_unit_0/aux_timeOut[0]_net_1\, 
        \MoM_unit_0/aux_timeOut_n1\, \MoM_unit_0/N_38\, 
        \MoM_unit_0/N_91_i\, \MoM_unit_0/N_63\, 
        \MoM_unit_0/aux_timeOut[3]_net_1\, 
        \MoM_unit_0/aux_timeOut[4]_net_1\, 
        \MoM_unit_0/aux_timeOut[6]_net_1\, \MoM_unit_0/N_65\, 
        \MoM_unit_0/N_11\, 
        \MoM_unit_0/DWACT_ADD_CI_0_partial_sum[0]\, 
        \MoM_unit_0/N_119\, \MoM_unit_0/NACKCnt_5_i_1_0[1]\, 
        \MoM_unit_0/N_13\, \MoM_unit_0/un1_NACKCnt[0]\, 
        \MoM_unit_0/un17_waitingackenab\, 
        \MoM_unit_0/state[2]_net_1\, 
        \MoM_unit_0/NACKCnt[1]_net_1\, 
        \MoM_unit_0/DWACT_ADD_CI_0_TMP[0]\, 
        \MoM_unit_0/NACKCnt[0]_net_1\, 
        \MoM_unit_0/un12_contentionenab_0_a2_0\, 
        \MoM_unit_0/un2_contentiontimeexpired_3\, 
        \MoM_unit_0/Contention_int[2]_net_1\, 
        \MoM_unit_0/Contention_int[1]_net_1\, 
        \MoM_unit_0/Contention_int[0]_net_1\, 
        \MoM_unit_0/un2_contentiontimeexpired_2\, 
        \MoM_unit_0/Contention_int[3]_net_1\, 
        \MoM_unit_0/Contention_int[4]_net_1\, 
        \MoM_unit_0/un2_contentiontimeexpired_1\, 
        \MoM_unit_0/Contention_int[5]_net_1\, 
        \MoM_unit_0/Contention_int[6]_net_1\, 
        \MoM_unit_0/RX_processed_0_a2_0_0\, \MoM_unit_0/N_113\, 
        \MoM_unit_0/N_78\, \MoM_unit_0/un19_commandreceived\, 
        \MoM_unit_0/state[6]_net_1\, 
        \MoM_unit_0/un12_contentionenab\, \MoM_unit_0/N_77\, 
        \MoM_unit_0/N_125\, \MoM_unit_0/N_21\, 
        \MoM_unit_0/Contention_intlde_i_a2_0_1\, 
        \MoM_unit_0/N_120\, \MoM_unit_0/state_ns_e[0]\, 
        \MoM_unit_0/N_86\, \MoM_unit_0/N_92\, 
        \MoM_unit_0/un7_tx_active\, 
        \MoM_unit_0/commandReceived_net_1\, \MoM_unit_0/N_123\, 
        \MoM_unit_0/state[0]_net_1\, 
        \MoM_unit_0/state_ns_0_0_o2_0[2]\, \MoM_unit_0/N_118\, 
        \MoM_unit_0/state_ns_0_0[1]\, \MoM_unit_0/state_tr1_13\, 
        \MoM_unit_0/N_328\, \MoM_unit_0/state_ns_0_0_o2_1[4]\, 
        \MoM_unit_0/state_tr1_10\, \MoM_unit_0/state_tr1_9\, 
        \MoM_unit_0/state_tr1_11\, \MoM_unit_0/state_tr1_1\, 
        \MoM_unit_0/state_tr1_8\, \MoM_unit_0/N_68\, 
        \MoM_unit_0/state_tr1_6\, \MoM_unit_0/state_tr1_4\, 
        \MoM_unit_0/un3_tx_active_0\, \MoM_unit_0/N_101\, 
        \MoM_unit_0/N_121\, \MoM_unit_0/ChannelFreeTime_net_1\, 
        \MoM_unit_0/N_59\, \MoM_unit_0/state_ns[1]\, 
        \MoM_unit_0/N_60\, \MoM_unit_0/N_6\, \MoM_unit_0/N_8\, 
        \MoM_unit_0/N_351\, \MoM_unit_0/N_10\, \MoM_unit_0/N_18\, 
        \MoM_unit_0/N_12\, \MoM_unit_0/N_352\, \MoM_unit_0/N_14\, 
        \MoM_unit_0/N_20\, \MoM_unit_0/N_16\, \MoM_unit_0/N_353\, 
        \MoM_unit_0/N_62\, \MoM_unit_0/aux_timeOut_c4\, 
        \MoM_unit_0/state[3]_net_1\, \MoM_unit_0/N_107_1\, 
        \MoM_unit_0/N_22\, \MoM_unit_0/state_ns[4]\, 
        \MoM_unit_0/N_107\, \MoM_unit_0/un4_commandreceived\, 
        \MoM_unit_0/un22_commandreceived\, 
        \MoM_unit_0/commandType[0]\, \MoM_unit_0/commandType[1]\, 
        \MoM_unit_0/state_ns[2]\, \MoM_unit_0/N_323\, 
        \MoM_unit_0/state_ns[5]\, \MoM_unit_0/N_335\, 
        \MoM_unit_0/N_327\, \LowPowerManagement_0/N_FlashFreeze\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/control_user_clock_net\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/clock_to_user_logic_temp\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_two\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_one\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_N_6\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_0\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_1_2_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_1_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_2\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_2_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/d_N_3_mux\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_housekeeping_request_0_sqmuxa\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_58\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_0_sqmuxa\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[3]\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[4]\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_0_sqmuxa\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[2]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_FlashFreeze_i\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[3]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[1]\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[2]\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[4]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_ff_current_state\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[5]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_i_0[0]\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[0]_net_1\, 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_net_1\, 
        \RingOscillator_0/AO14_8_Y\, \RingOscillator_0/NAND2_0_Y\, 
        \RingOscillator_0/AO14_15_Y\, 
        \RingOscillator_0/AO14_23_Y\, \GND\, 
        \RingOscillator_0/AO14_11_Y\, 
        \RingOscillator_0/AO14_22_Y\, 
        \RingOscillator_0/AO14_21_Y\, 
        \RingOscillator_0/AO14_20_Y\, 
        \RingOscillator_0/AO14_19_Y\, 
        \RingOscillator_0/AO14_18_Y\, 
        \RingOscillator_0/AO14_17_Y\, \RingOscillator_0/AO14_5_Y\, 
        \RingOscillator_0/AO14_16_Y\, 
        \RingOscillator_0/AO14_13_Y\, 
        \RingOscillator_0/AO14_14_Y\, 
        \RingOscillator_0/AO14_12_Y\, \RingOscillator_0/AO14_2_Y\, 
        \RingOscillator_0/AO14_10_Y\, \RingOscillator_0/AO14_9_Y\, 
        \RingOscillator_0/AO14_7_Y\, \RingOscillator_0/AO14_6_Y\, 
        \RingOscillator_0/AO14_4_Y\, \RingOscillator_0/AO14_3_Y\, 
        \RingOscillator_0/AO14_1_Y\, \RingOscillator_0/AO14_0_Y\, 
        \RingOscillator_0/muxSwitcthRing_0_Result\, 
        \RingOscillator_0/ringO_cnt_0/RingOscillator_0_CLK_OUT_i\, 
        \RingOscillator_0/ringO_cnt_0/NU_0_1_2\, 
        \RingOscillator_0/ringO_cnt_0/NU_0\, 
        \RingOscillator_0/ringO_cnt_0/NU_1\, 
        \RingOscillator_0/ringO_cnt_0/NU_2\, 
        \RingOscillator_0/ringO_cnt_0/INV_2_Y\, 
        \RingOscillator_0/ringO_cnt_0/INV_1_Y\, 
        \RingOscillator_0/ringO_cnt_0/XOR2_0_Y\, 
        \RingOscillator_0/ringO_cnt_0/AND2_0_Y\, 
        \md_v4_0/un14_mdisync_0_0\, \md_v4_0/mdiSync_net_1\, 
        \md_v4_0/N_36_i\, \md_v4_0/un1_error_happens_0_a3_0\, 
        \md_v4_0/error_counter[3]_net_1\, 
        \md_v4_0/error_counter[2]_net_1\, \md_v4_0/N_22\, 
        \md_v4_0/ctd2_net_1\, \md_v4_0/N_54\, \md_v4_0/N_24\, 
        \md_v4_0/N_43\, \md_v4_0/N_33\, 
        \md_v4_0/un1_error_happens\, \md_v4_0/error_countere_1\, 
        \md_v4_0/error_counter_n2_i_0\, \md_v4_0/N_31\, 
        \md_v4_0/error_counter_n1_i_0\, \md_v4_0/N_59\, 
        \md_v4_0/un14_mdisync\, \md_v4_0/error_type_1\, 
        \md_v4_0/error_type_net_1\, \md_v4_0/mdi2_2\, 
        \md_v4_0/mdi1_net_1\, \md_v4_0/N_55\, 
        \md_v4_0/error_counter[0]_net_1\, 
        \md_v4_0/error_counter[1]_net_1\, \md_v4_0/N_16\, 
        \md_v4_0/N_35\, \md_v4_0/N_40_i\, \md_v4_0/ctd0_net_1\, 
        \md_v4_0/N_37\, \md_v4_0/N_26\, \md_v4_0/ctd1_net_1\, 
        \md_v4_0/N_46\, \md_v4_0/N_47\, \md_v4_0/un2_mdi\, 
        \md_v4_0/ctd1_2\, \md_v4_0/newDataEdgeAux_2\, 
        \md_v4_0/error_countere\, \md_v4_0/un1_ref_clk\, 
        \md_v4_0/fre_ref_0/Ref_clk\, \md_v4_0/fre_ref_0/q_n1_i_0\, 
        \md_v4_0/fre_ref_0/q[1]_net_1\, 
        \md_v4_0/fre_ref_0/q_i_0[0]\, 
        \md_v4_0/fre_ref_0/q_n2_i_0\, 
        \md_v4_0/fre_ref_0/q_i_0[2]\, \md_v4_0/fre_ref_0/N_6\, 
        \md_v4_0/fre_ref_0/N_11\, \md_v4_0/fre_ref_0/N_10\, 
        \md_v4_0/fre_ref_0/N_28\, \md_v4_0/fre_ref_0/N_26\, 
        \md_v4_0/fre_ref_0/N_8\, \md_v4_0/fre_ref_0/CEO_4\, 
        \md_v4_0/fre_ref_0/q[3]_net_1\, \md_v4_0/fre_ref_0/N_27\, 
        \md_v4_0/fre_ref_0/q_n0\, \VCC\, \IRQ3_pad/U0/NET1\, 
        \IRQ3_pad/U0/NET2\, \RESETZB_pad/U0/NET1\, 
        \RESETZB_pad/U0/NET2\, \f32_pad/U0/NET1\, 
        \f32_pad/U0/NET2\, \MoMstateLed_pad[2]/U0/NET1\, 
        \MoMstateLed_pad[2]/U0/NET2\, \LedMochila_pad/U0/NET1\, 
        \LedMochila_pad/U0/NET2\, \BIBUF_0/U0/NET1\, 
        \BIBUF_0/U0/NET2\, \BIBUF_0/U0/NET3\, 
        \CommandType2ZB_pad/U0/NET1\, 
        \CommandType2ZB_pad/U0/NET2\, 
        \uC_commandType_pad/U0/NET1\, \TX_pad/U0/NET1\, 
        \TX_pad/U0/NET2\, \INBUF_0/U0/NET1\, 
        \MoMstateLed_pad[0]/U0/NET1\, 
        \MoMstateLed_pad[0]/U0/NET2\, \RX_OUT_pad/U0/NET1\, 
        \RX_OUT_pad/U0/NET2\, \selExp_pad[0]/U0/NET1\, 
        \CLK_GATED_pad/U0/NET1\, \CLK_GATED_pad/U0/NET2\, 
        \selAdd_pad[0]/U0/NET1\, \RX_pad/U0/NET1\, 
        \uC_commandReady_pad/U0/NET1\, \selExp_pad[1]/U0/NET1\, 
        \IRQ0_pad/U0/NET1\, \IRQ0_pad/U0/NET2\, 
        \selAdd_pad[2]/U0/NET1\, \Decoder_hk_pad/U0/NET1\, 
        \Decoder_hk_pad/U0/NET2\, \R2SINKTimeout_pad/U0/NET1\, 
        \AddOKflag_pad/U0/NET1\, \AddOKflag_pad/U0/NET2\, 
        \f59_pad/U0/NET1\, \f59_pad/U0/NET2\, \IRQ2_pad/U0/NET1\, 
        \IRQ2_pad/U0/NET2\, \NWKrRouteTimeout_pad/U0/NET1\, 
        \CommandReady2ZB_pad/U0/NET1\, 
        \CommandReady2ZB_pad/U0/NET2\, \selAdd_pad[1]/U0/NET1\, 
        \CTRL1_Enab_pad/U0/NET1\, \CTRL1_Enab_pad/U0/NET2\, 
        \LowPowerManagement_0/FlashFreeze_Inbuf/U0/NET1\, 
        \MoMstateLed_pad[1]/U0/NET1\, 
        \MoMstateLed_pad[1]/U0/NET2\, \IRQ1_pad/U0/NET1\, 
        \IRQ1_pad/U0/NET2\, AFLSDF_VCC, AFLSDF_GND, 
        \AFLSDF_INV_0\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

begin 

    AFLSDF_GND <= GND_power_net1;
    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    \MoM_unit_0/aux_timeOut_RNIDV534[8]\ : NOR3A
      port map(A => \MoM_unit_0/aux_timeOut[8]_net_1\, B => 
        \MoM_unit_0/N_74\, C => 
        \MoM_unit_0/aux_timeOut_c7_0_o2_0\, Y => 
        \MoM_unit_0/aux_timeOut_c8\);
    
    \MoM_unit_0/state_RNIV7A[3]\ : NOR2
      port map(A => \MoM_unit_0/state[3]_net_1\, B => 
        \MoM_unit_0/state[0]_net_1\, Y => \MoMstateLed_c[2]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNO[5]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_encoder_busy_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[5]\);
    
    \command_process_0/state_RNO[4]\ : NOR3B
      port map(A => \command_process_0/N_100\, B => 
        \command_process_0/N_78\, C => bit_error_1, Y => 
        \command_process_0/state_RNO[4]_net_1\);
    
    \command_process_0/state_RNO[7]\ : NOR3A
      port map(A => \command_process_0/N_95\, B => bit_error_1, C
         => \command_process_0.N_435\, Y => 
        \command_process_0/state_RNO[7]_net_1\);
    
    \command_process_0/state_RNIKQKB2[9]\ : NOR2B
      port map(A => 
        \command_process_0.un1_commProc_busy_1_0_a2_0_1\, B => 
        \command_process_0/N_59\, Y => \command_process_0/N_146\);
    
    \RingOscillator_0/AO14_14\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_23_Y\, Y => 
        \RingOscillator_0/AO14_14_Y\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[0]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[0]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[0]_net_1\);
    
    \md_v4_0/error_counter_RNO_0[1]\ : XNOR2
      port map(A => \md_v4_0/error_counter[0]_net_1\, B => 
        \md_v4_0/error_counter[1]_net_1\, Y => 
        \md_v4_0/error_counter_n1_i_0\);
    
    \MoM_unit_0/state_RNO_9[5]\ : NOR3B
      port map(A => \MoM_unit_0/NACKCnt[1]_net_1\, B => 
        \MoM_unit_0/state[2]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[2]_net_1\, Y => 
        \MoM_unit_0/state_tr1_8\);
    
    \command_process_0/addOK_reg_RNO\ : NOR3
      port map(A => \command_process_0/addok_NE_0_3\, B => 
        \command_process_0/addok_NE_0_2\, C => 
        \command_process_0/addok_NE_0_4\, Y => 
        \command_process_0/addok_NE\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_load\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_net_1\);
    
    \MoMstateLed_pad[1]/U0/U1\ : IOTRI_OB_EB
      port map(D => \MoMstateLed_c[1]\, E => \VCC\, DOUT => 
        \MoMstateLed_pad[1]/U0/NET1\, EOUT => 
        \MoMstateLed_pad[1]/U0/NET2\);
    
    \IRQ0_pad/U0/U0\ : IOPAD_TRI
      port map(D => \IRQ0_pad/U0/NET1\, E => \IRQ0_pad/U0/NET2\, 
        PAD => IRQ0);
    
    \command_process_0/state[3]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[3]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[3]_net_1\);
    
    \md_v4_0/fre_ref_0/q_RNO[0]\ : OR2B
      port map(A => \md_v4_0/fre_ref_0/q_i_0[0]\, B => 
        \md_v4_0.receiving\, Y => \md_v4_0/fre_ref_0/q_n0\);
    
    \IRQ1_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => IRQ1_c_c, E => \VCC\, DOUT => 
        \IRQ1_pad/U0/NET1\, EOUT => \IRQ1_pad/U0/NET2\);
    
    \selAdd_pad[0]/U0/U0\ : IOPAD_IN
      port map(PAD => selAdd(0), Y => \selAdd_pad[0]/U0/NET1\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[5]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[5]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[5]_net_1\);
    
    \command_process_0/commandRX[2]\ : DFN0E1C0
      port map(D => \command_process_0/commandRX_3[2]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_5\, Q => 
        \command_process_0/commandRX[2]_net_1\);
    
    \RingOscillator_0/AO14_5\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_4_Y\, Y => 
        \RingOscillator_0/AO14_5_Y\);
    
    \ZBControl_0/state[0]\ : DFN1C0
      port map(D => IRQ3_c, CLK => CLK_GATED_c, CLR => RESETZB_c, 
        Q => \ZBControl_0/state[0]_net_1\);
    
    \housekeepingCheck_0/Result_5_4\ : NOR3C
      port map(A => \housekeepingCheck_0/Result_5_2_net_1\, B => 
        \housekeepingCheck_0/Result_5_1_net_1\, C => Encoder_hk, 
        Y => \housekeepingCheck_0/Result_5_4_net_1\);
    
    \command_process_0/state_RNO_1[8]\ : OR2B
      port map(A => \command_process_0.state[9]\, B => 
        \md_v4_0.mdi2\, Y => \command_process_0/N_62\);
    
    \md_v4_0/fre_ref_0/q_RNINLUB[3]\ : NOR3A
      port map(A => \md_v4_0/fre_ref_0/q[3]_net_1\, B => 
        \md_v4_0/fre_ref_0/q_i_0[0]\, C => 
        \md_v4_0/fre_ref_0/q_i_0[2]\, Y => 
        \md_v4_0/fre_ref_0/N_27\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_23\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_23\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[2]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[1]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[2]\, 
        S => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[2]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_23\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[2]\ : 
        NOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_66\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[2]_net_1\);
    
    \command_process_0/state_RNO_0[1]\ : MX2
      port map(A => \command_process_0.state[1]\, B => 
        \command_process_0/state[2]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_99\);
    
    \command_process_0/state_RNO_0[9]\ : OR3
      port map(A => \command_process_0/state_ns_0_0[0]\, B => 
        \command_process_0/N_133\, C => \command_process_0/N_130\, 
        Y => \command_process_0/state_ns_0_2[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNIIHAL1\ : 
        NOR3B
      port map(A => 
        \manchesterEncoderComplete_0/loadEncoder_i_a3_0_a3_0\, B
         => manchesterEncoderComplete_0_TX_Active, C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_1_0\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa_1_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIG8E21[6]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_83\);
    
    \command_process_0/reg_command_error_RNO\ : NOR3A
      port map(A => \command_process_0/state[2]_net_1\, B => 
        \command_process_0/N_69\, C => \command_process_0/N_118\, 
        Y => \command_process_0/N_23\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[0]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[0]\);
    
    \selAdd_pad[0]/U0/U1\ : IOIN_IB
      port map(YIN => \selAdd_pad[0]/U0/NET1\, Y => \selAdd_c[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNO\ : 
        AO1A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit_sent_0\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/loadactivebit\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_last_bit_sent\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[8]\ : AX1D
      port map(A => \MoM_unit_0/N_74\, B => 
        \MoM_unit_0/aux_timeOut_c7_0_o2_0\, C => 
        \MoM_unit_0/aux_timeOut[8]_net_1\, Y => 
        \MoM_unit_0/N_91_i\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[4]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[4]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[4]_net_1\);
    
    \command_process_0/ParityRX_RNO_4\ : NOR2A
      port map(A => \command_process_0.N_150\, B => 
        \command_process_0.state[1]\, Y => 
        \command_process_0/un2_dataclean_5_i_a9_0_0\);
    
    \InintialMsgInjector_0/aux5_RNO\ : OR2A
      port map(A => \MoM_unit_0.N_17\, B => 
        \InintialMsgInjector_0/aux5_net_1\, Y => 
        \InintialMsgInjector_0/aux5_RNO_net_1\);
    
    \ZBControl_0/commandTypeIN\ : DFN1E1P0
      port map(D => CommandType2ZB_c, CLK => CLK_GATED_c, PRE => 
        RESETZB_c, E => CommandReady2ZB_c, Q => 
        \ZBControl_0/commandTypeIN_net_1\);
    
    \command_process_0/ParityRX_RNO_6\ : NOR3C
      port map(A => \command_process_0.N_150\, B => 
        \command_process_0.un2_dataclean_5_i_a9_1_0\, C => 
        \command_process_0.N_435\, Y => \command_process_0/N_110\);
    
    \md_v4_0/error_counter[3]\ : DFN0E1C0
      port map(D => \md_v4_0/N_35\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/error_countere\, Q => 
        \md_v4_0/error_counter[3]_net_1\);
    
    \command_process_0/ParityRX_RNO_3\ : OR2A
      port map(A => \command_process_0/ParityRX_net_1\, B => 
        MoM_unit_0_RX_processed, Y => 
        \command_process_0/ParityRX_2_0_0\);
    
    \RingOscillator_0/AO14_23\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_11_Y\, Y => 
        \RingOscillator_0/AO14_23_Y\);
    
    \MoM_unit_0/state_RNO_0[2]\ : OR3A
      port map(A => \MoM_unit_0/state[2]_net_1\, B => 
        \MoM_unit_0/un26_commandreceived\, C => 
        \MoM_unit_0/un19_commandreceived\, Y => 
        \MoM_unit_0/state_ns_0_0_o2_1[4]\);
    
    \RingOscillator_0/AO14_13\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_12_Y\, Y => 
        \RingOscillator_0/AO14_13_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_15\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/regload_RNIRF1D2\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/regload_net_1\, 
        B => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/loadactivebit\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIBVH25[4]\ : 
        OR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_57\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_88\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_70\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_20\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_1_2\ : 
        NOR3A
      port map(A => 
        \command_process_0.un1_commProc_busy_1_0_a2_0_1\, B => 
        \command_process_0.N_76\, C => 
        \command_process_0.state[9]\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_1_2_net_1\);
    
    \command_process_0/state_RNO[3]\ : NOR2
      port map(A => \command_process_0/N_97\, B => bit_error_1, Y
         => \command_process_0/state_RNO[3]_net_1\);
    
    \MoMstateLed_pad[0]/U0/U1\ : IOTRI_OB_EB
      port map(D => \MoMstateLed_c[0]\, E => \VCC\, DOUT => 
        \MoMstateLed_pad[0]/U0/NET1\, EOUT => 
        \MoMstateLed_pad[0]/U0/NET2\);
    
    \f59_pad/U0/U0\ : IOPAD_TRI_D
      port map(D => \f59_pad/U0/NET1\, E => \f59_pad/U0/NET2\, 
        PAD => f59);
    
    \f32_pad/U0/U0\ : IOPAD_TRI_D
      port map(D => \f32_pad/U0/NET1\, E => \f32_pad/U0/NET2\, 
        PAD => f32);
    
    \R2SINKTimeout_pad/U0/U1\ : IOIN_IB
      port map(YIN => \R2SINKTimeout_pad/U0/NET1\, Y => 
        R2SINKTimeout_c);
    
    \command_process_0/reg_short_command_RNIOFUD2\ : NOR2A
      port map(A => \command_process_0/N_181\, B => 
        \command_process_0/N_67\, Y => 
        \command_process_0/un1_commProc_busy_1_0_a9_0\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[5]\ : XOR2
      port map(A => \MoM_unit_0/aux_timeOut[5]_net_1\, B => 
        \MoM_unit_0/aux_timeOut_c4\, Y => 
        \MoM_unit_0/aux_timeOut_n5_tz\);
    
    \command_process_0/reg_set_newMessage\ : DFN1C0
      port map(D => \command_process_0/set_newMessage\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/reg_set_newMessage_net_1\);
    
    \MoMstateLed_pad[1]/U0/U0\ : IOPAD_TRI
      port map(D => \MoMstateLed_pad[1]/U0/NET1\, E => 
        \MoMstateLed_pad[1]/U0/NET2\, PAD => MoMstateLed(1));
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_22\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_22\);
    
    \MoM_unit_0/aux_timeOut_RNIMCEN2[6]\ : OR2
      port map(A => \MoM_unit_0/N_64\, B => \MoM_unit_0/N_65\, Y
         => \MoM_unit_0/N_74\);
    
    \LowPowerManagement_0/FlashFreeze_Inbuf/U0/U1\ : IOIN_IB
      port map(YIN => 
        \LowPowerManagement_0/FlashFreeze_Inbuf/U0/NET1\, Y => 
        \LowPowerManagement_0/N_FlashFreeze\);
    
    \command_process_0/state_RNO_0[6]\ : MX2
      port map(A => \command_process_0/state[6]_net_1\, B => 
        \command_process_0/state[7]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_96\);
    
    \RX_pad/U0/U1\ : IOIN_IB
      port map(YIN => \RX_pad/U0/NET1\, Y => RX_c_c);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[4]\ : 
        DFN1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[1]\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[4]_net_1\);
    
    \command_process_0/state_RNO_1[9]\ : AO1
      port map(A => \command_process_0/state_ns_0_a9_1_0[0]\, B
         => md_v4_0_new_data, C => bit_error_1, Y => 
        \command_process_0/state_ns_0_0[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/continueFlag_RNO\ : 
        INV
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_i\);
    
    \md_v4_0/receiving\ : DFN1E0C0
      port map(D => md_v4_0_RX_end, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/N_47\, Q => \md_v4_0.receiving\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_27\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12[0]\);
    
    \command_process_0/addOK_reg_RNO_5\ : OR3B
      port map(A => \command_process_0/addressRX[5]_net_1\, B => 
        \command_process_0/addressRX[7]_net_1\, C => 
        \command_process_0/addressRX[6]_net_1\, Y => 
        \command_process_0/addok_NE_0_1\);
    
    \MoM_unit_0/aux_timeOut_RNIGQCK4[12]\ : OR3
      port map(A => \MoM_unit_0/un13_timeoutack_0_o2_4\, B => 
        \MoM_unit_0/un13_timeoutack_0_o2_3\, C => 
        \MoM_unit_0/N_64\, Y => \MoM_unit_0/N_76\);
    
    \MoM_unit_0/state_RNO_5[5]\ : NOR3B
      port map(A => \MoM_unit_0/state_tr1_1\, B => 
        \MoM_unit_0/state_tr1_8\, C => \MoM_unit_0/N_68\, Y => 
        \MoM_unit_0/state_tr1_11\);
    
    \command_process_0/commandRX_RNO[2]\ : NOR3A
      port map(A => \command_process_0/commandRX[1]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/commandRX_3[2]\);
    
    \MoM_unit_0/state_RNIGDF[0]\ : OR3
      port map(A => CommandReady2ZB_c, B => 
        \MoM_unit_0/state[0]_net_1\, C => MoM_unit_0_d_hk, Y => 
        \MoM_unit_0/NACKCnt_5_i_1_0[1]\);
    
    \MoM_unit_0/ChannelFreeTime_RNO\ : OR2
      port map(A => \MoM_unit_0/un12_contentionenab\, B => 
        manchesterEncoderComplete_0_TX_Active, Y => 
        \MoM_unit_0/un7_tx_active\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[2]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[2]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[2]_net_1\);
    
    
        \MoM_unit_0/ChannelFree_contention.un12_contentionenab_0_a2_0\ : 
        NOR2
      port map(A => RX_c_c, B => md_v4_0_RX_end, Y => 
        \MoM_unit_0/un12_contentionenab_0_a2_0\);
    
    \MoM_unit_0/state[1]\ : DFN1E1C0
      port map(D => \MoM_unit_0/state_ns[5]\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => RESETZB_c, Q => CommandReady2ZB_c);
    
    INBUF_0_RNI3ULF : CLKINT
      port map(A => INBUF_0, Y => RESETZB_c);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_RNO\ : 
        OR2
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_58\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_0_sqmuxa\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_housekeeping_request_0_sqmuxa\);
    
    \md_v4_0/receiving_RNO\ : NOR2A
      port map(A => md_v4_0_RX_end, B => RX_c_c, Y => 
        \md_v4_0/N_47\);
    
    \selExp_pad[1]/U0/U0\ : IOPAD_IN
      port map(PAD => selExp(1), Y => \selExp_pad[1]/U0/NET1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI8OUM[0]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvioslde_i_i_o2_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa_a1\ : 
        OA1A
      port map(A => \manchesterEncoderComplete_0/cuentaEnvios[0]\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[1]\, C => 
        \manchesterEncoderComplete_0/state[3]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_2_1\);
    
    \ZBControl_0/state_RNO_0[1]\ : AO1D
      port map(A => NWKrRouteTimeout_c, B => R2SINKTimeout_c, C
         => \ZBControl_0/N_17\, Y => 
        \ZBControl_0/state_ns_0_i_0[1]\);
    
    \uC_commandType_pad/U0/U0\ : IOPAD_IN_D
      port map(PAD => uC_commandType, Y => 
        \uC_commandType_pad/U0/NET1\);
    
    \md_v4_0/fre_ref_0/q_RNO_0[2]\ : AX1
      port map(A => \md_v4_0/fre_ref_0/q_i_0[0]\, B => 
        \md_v4_0/fre_ref_0/q[1]_net_1\, C => 
        \md_v4_0/fre_ref_0/q_i_0[2]\, Y => 
        \md_v4_0/fre_ref_0/q_n2_i_0\);
    
    \md_v4_0/mdiSync_RNO\ : NOR2B
      port map(A => RX_c_c, B => md_v4_0_RX_end, Y => 
        \md_v4_0/un2_mdi\);
    
    \InintialMsgInjector_0/aux5\ : DFN1C0
      port map(D => \InintialMsgInjector_0/aux5_RNO_net_1\, CLK
         => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \InintialMsgInjector_0/aux5_net_1\);
    
    \command_process_0/bitCounter_RNO_0[3]\ : AX1A
      port map(A => \command_process_0/N_70\, B => 
        \command_process_0/bitCounter[2]_net_1\, C => 
        \command_process_0/bitCounter[3]_net_1\, Y => 
        \command_process_0/N_90_i\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/Register_For_Clock_Gating\ : 
        DFN1
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/control_user_clock_net\, 
        CLK => RingOscillator_0_CLK_OUT, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_one\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[3]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[3]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[3]_net_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_o6_0\ : 
        OR2B
      port map(A => md_v4_0_new_data, B => 
        \command_process_0.state[9]\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_N_6\);
    
    \command_process_0/state_RNINNLD1[2]\ : NOR3B
      port map(A => \command_process_0/state[2]_net_1\, B => 
        \command_process_0/N_167\, C => \command_process_0/N_69\, 
        Y => \command_process_0/reg_short_command_3_2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[2]_net_1\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_24\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[1]\);
    
    \command_process_0/ParityRX_RNO_1\ : AO1
      port map(A => \command_process_0/un2_dataclean_5_i_a9_0_0\, 
        B => \command_process_0/N_58\, C => 
        \command_process_0/N_110\, Y => 
        \command_process_0/un2_dataclean_5_i_1\);
    
    \RingOscillator_0/ringO_cnt_0/DFN1E1C0_NU_3_RNIFSD1\ : CLKINT
      port map(A => 
        \RingOscillator_0/ringO_cnt_0/RingOscillator_0_CLK_OUT_i\, 
        Y => RingOscillator_0_CLK_OUT);
    
    \MoM_unit_0/aux_timeOut_RNO_0[3]\ : AX1
      port map(A => \MoM_unit_0/N_65\, B => 
        \MoM_unit_0/aux_timeOut[0]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[3]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_n3_tz\);
    
    \InintialMsgInjector_0/aux1_RNO\ : INV
      port map(A => \InintialMsgInjector_0/aux5_net_1\, Y => 
        \InintialMsgInjector_0/aux5_i\);
    
    \MoMstateLed_pad[0]/U0/U0\ : IOPAD_TRI
      port map(D => \MoMstateLed_pad[0]/U0/NET1\, E => 
        \MoMstateLed_pad[0]/U0/NET2\, PAD => MoMstateLed(0));
    
    \MoM_unit_0/state_RNO_0[1]\ : OA1A
      port map(A => \MoM_unit_0/un3_tx_active_0\, B => 
        CommandType2ZB_c, C => \MoM_unit_0/N_107_1\, Y => 
        \MoM_unit_0/N_335\);
    
    \MoM_unit_0/Contention_int[0]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_22\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[0]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNIUBQQ1[2]\ : 
        AO1A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0_0[2]\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_0[2]\);
    
    \RingOscillator_0/ringO_cnt_0/DFN1E1C0_NU_1\ : DFN1E1C0
      port map(D => \RingOscillator_0/ringO_cnt_0/INV_2_Y\, CLK
         => \RingOscillator_0/AO14_15_Y\, CLR => RESETZB_c, E => 
        \RingOscillator_0/ringO_cnt_0/NU_0\, Q => 
        \RingOscillator_0/ringO_cnt_0/NU_1\);
    
    \uC_commandReady_pad/U0/U0\ : IOPAD_IN_D
      port map(PAD => uC_commandReady, Y => 
        \uC_commandReady_pad/U0/NET1\);
    
    \command_process_0/state_RNO[1]\ : NOR2A
      port map(A => \command_process_0/N_99\, B => bit_error_1, Y
         => \command_process_0/state_RNO[1]_net_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_1\ : 
        OA1A
      port map(A => \command_process_0.state[1]\, B => 
        \command_process_0.un2_dataclean_5_i_a9_1_0\, C => 
        \command_process_0.N_435\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_1_net_1\);
    
    \command_process_0/addressRX_RNO[6]\ : NOR3A
      port map(A => \command_process_0/addressRX[5]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/N_55\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[3]\ : 
        DFN1E1C0
      port map(D => \MoM_unit_0_commandToEncoder_i[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => MoM_unit_0_TX_load, Q
         => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[3]_net_1\);
    
    \f59_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => \f59_pad/U0/NET1\, 
        EOUT => \f59_pad/U0/NET2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]\ : 
        DFN1E1C0
      port map(D => CommandType2ZB_c, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => MoM_unit_0_TX_load, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\);
    
    \addressingData_0/LSB_NextHopAddress[2]\ : MX2
      port map(A => \addressingData_0.un3_msb_nexthopaddress\, B
         => \selAdd_c[0]\, S => 
        \addressingData_0_NextHopAddress_0[0]\, Y => 
        \addressingData_0_NextHopAddress_0[2]\);
    
    \MoM_unit_0/state_RNO_7[5]\ : NOR2
      port map(A => \MoM_unit_0/aux_timeOut[7]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[1]_net_1\, Y => 
        \MoM_unit_0/state_tr1_4\);
    
    \command_process_0/bitCounter[0]\ : DFN1E1C0
      port map(D => \command_process_0/N_127\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/bitCountere\, Q
         => \command_process_0/bitCounter[0]_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNO[1]\ : XA1B
      port map(A => \MoM_unit_0/aux_timeOut[1]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[0]_net_1\, C => \MoM_unit_0/N_85\, 
        Y => \MoM_unit_0/aux_timeOut_n1\);
    
    \RingOscillator_0/AO14_17\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_5_Y\, Y => 
        \RingOscillator_0/AO14_17_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNICPR22[1]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_46\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\, 
        Y => \manchesterEncoderComplete_0/N_243\);
    
    \MoM_unit_0/state_RNI0VHK4[2]\ : OR2B
      port map(A => \MoM_unit_0/N_76\, B => 
        \MoM_unit_0/state[2]_net_1\, Y => \MoM_unit_0/N_85\);
    
    \IRQ0_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => IRQ1_c_c, E => \VCC\, DOUT => 
        \IRQ0_pad/U0/NET1\, EOUT => \IRQ0_pad/U0/NET2\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_1_0\ : 
        NOR3A
      port map(A => \md_v4_0.newDataEdgeAux\, B => 
        \md_v4_0.dataFiltered\, C => \md_v4_0.mdi2\, Y => 
        \command_process_0.N_435\);
    
    \AddOKflag_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => AddOKflag_c, E => \VCC\, DOUT => 
        \AddOKflag_pad/U0/NET1\, EOUT => \AddOKflag_pad/U0/NET2\);
    
    \command_process_0/bitCounter_RNI3RJT[1]\ : OR2B
      port map(A => \command_process_0/bitCounter[1]_net_1\, B
         => \command_process_0/bitCounter[0]_net_1\, Y => 
        \command_process_0/N_70\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNO[4]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[1]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_encoder_busy_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[4]\);
    
    \MoM_unit_0/state_RNIUS531[4]\ : MX2
      port map(A => CommandReady2ZB_c, B => 
        \MoM_unit_0.un2_contentiontimeexpired\, S => 
        \MoM_unit_0.state[4]\, Y => \MoM_unit_0/N_92\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNIP5S06[3]\ : 
        OR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_53\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_i_0[3]\, 
        Y => \manchesterEncoderComplete_0/N_29\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[2]\ : 
        DFN1E1C0
      port map(D => CommandType2ZB_c_i, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => MoM_unit_0_TX_load, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[2]_net_1\);
    
    \MoM_unit_0/state_RNIN6RF[6]\ : OR2B
      port map(A => \MoM_unit_0/state[6]_net_1\, B => RESETZB_c, 
        Y => \MoM_unit_0/N_86\);
    
    \IRQ2_pad/U0/U0\ : IOPAD_TRI_D
      port map(D => \IRQ2_pad/U0/NET1\, E => \IRQ2_pad/U0/NET2\, 
        PAD => IRQ2);
    
    \MoM_unit_0/state_RNO_10[5]\ : OR2B
      port map(A => \MoM_unit_0/aux_timeOut[9]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[8]_net_1\, Y => \MoM_unit_0/N_68\);
    
    \command_process_0/state_RNIJKBJ3[0]\ : OA1B
      port map(A => \command_process_0/N_181\, B => 
        \command_process_0/N_149\, C => \command_process_0/N_69\, 
        Y => \command_process_0/N_121\);
    
    \uC_commandType_pad/U0/U1\ : IOIN_IB
      port map(YIN => \uC_commandType_pad/U0/NET1\, Y => 
        uC_commandType_c);
    
    \MoM_unit_0/state_RNO_4[4]\ : OR2A
      port map(A => MoM_unit_0_d_hk, B => \MoM_unit_0/N_123\, Y
         => \MoM_unit_0/N_78\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[1]\ : 
        OA1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_i_a3_0_0[5]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_15\);
    
    \md_v4_0/error_counter[0]\ : DFN0E1C0
      port map(D => \md_v4_0/N_55\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/error_countere\, Q => 
        \md_v4_0/error_counter[0]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNI9L0A5\ : 
        OR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un4_bit_end\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un6_bit_end\);
    
    \command_process_0/state[2]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[2]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[2]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_26\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12_1[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t[0]\);
    
    \command_process_0/addressRX[3]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[3]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[3]_net_1\);
    
    \command_process_0/state_RNO_0[4]\ : MX2
      port map(A => \command_process_0/state[4]_net_1\, B => 
        \command_process_0/state[5]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_100\);
    
    \MoM_unit_0/state_RNIO61J1_0[4]\ : AO1C
      port map(A => \MoM_unit_0.state[4]\, B => 
        \MoM_unit_0/state_ns_e[0]\, C => \MoM_unit_0/N_77\, Y => 
        MoM_unit_0_TX_load);
    
    \command_process_0/addressRX[4]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[4]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[4]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_1[3]\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_39\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_63\);
    
    \md_v4_0/ctd0_RNO\ : NOR3A
      port map(A => md_v4_0_RX_end, B => \md_v4_0/ctd2_net_1\, C
         => \md_v4_0/N_54\, Y => \md_v4_0/N_22\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNO[1]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_n1_i_0\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_33\);
    
    \command_process_0/bitCounter_RNO[1]\ : NOR3
      port map(A => \command_process_0.N_148\, B => 
        \command_process_0/un1_commProc_busy_1_0_0_0\, C => 
        \command_process_0/bitCounter_n1_i_0\, Y => 
        \command_process_0/N_37\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_3\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_encoder_busy_1\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNI88653[2]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty\);
    
    \MoM_unit_0/NACKCnt[1]\ : DFN1C0
      port map(D => \MoM_unit_0/N_13\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, Q => \MoM_unit_0/NACKCnt[1]_net_1\);
    
    \MoM_unit_0/command2ZB_proc.un4_commandreceived\ : NOR2A
      port map(A => \command_process_0_msgType_0[0]\, B => 
        \command_process_0_msgType_0[1]\, Y => 
        \MoM_unit_0/un4_commandreceived\);
    
    \command_process_0/reg_command_error_RNI2PI01\ : NOR3B
      port map(A => \command_process_0/reg_command_error_net_1\, 
        B => md_v4_0_new_data, C => 
        \command_process_0/reg_short_command_net_1\, Y => 
        \command_process_0/bitCounterlde_0_a9_1_0\);
    
    \command_process_0/bitCounter[3]\ : DFN1E1C0
      port map(D => \command_process_0/N_41\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/bitCountere\, Q
         => \command_process_0/bitCounter[3]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_RNO_2\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[2]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_4\);
    
    \MoM_unit_0/ChannelFreeTime_RNI3T7S2\ : OA1
      port map(A => \MoM_unit_0/N_77\, B => 
        \MoM_unit_0/Contention_intlde_i_a2_0_1\, C => 
        \MoM_unit_0/N_120\, Y => \MoM_unit_0/N_21\);
    
    \MoM_unit_0/aux_timeOut[5]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n5\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[5]_net_1\);
    
    \RESETZB_pad/U0/U0\ : IOPAD_TRI_U
      port map(D => \RESETZB_pad/U0/NET1\, E => 
        \RESETZB_pad/U0/NET2\, PAD => RESETZB);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_31\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_TMP[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_1[0]\);
    
    \command_process_0/state_RNID9Q8[3]\ : OR2
      port map(A => \command_process_0/state[4]_net_1\, B => 
        \command_process_0/state[3]_net_1\, Y => 
        \command_process_0/un2_dataclean_1_i_o4_0\);
    
    \command_process_0/addressRX_RNO[2]\ : NOR3A
      port map(A => \command_process_0/addressRX[1]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[2]\);
    
    \MoM_unit_0/aux_timeOut[4]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n4\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[4]_net_1\);
    
    \command_process_0/commandRX[0]\ : DFN0E1C0
      port map(D => \command_process_0/commandRX_3[0]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_5\, Q => 
        \command_process_0/commandRX[0]_net_1\);
    
    \MoM_unit_0/Contention_int[5]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_14\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[5]_net_1\);
    
    \command_process_0/state_RNO[5]\ : NOR3
      port map(A => bit_error_1, B => \command_process_0.N_435\, 
        C => \command_process_0/N_124\, Y => 
        \command_process_0/state_RNO[5]_net_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNI6G4N[1]\ : 
        NOR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_0_sqmuxa\);
    
    \InintialMsgInjector_0/aux1\ : DFN1C0
      port map(D => \InintialMsgInjector_0/aux5_i\, CLK => 
        RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \InintialMsgInjector_0/aux1_net_1\);
    
    \command_process_0/state_RNO_0[7]\ : MX2
      port map(A => \command_process_0/state[7]_net_1\, B => 
        \command_process_0/state[8]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_95\);
    
    \MoM_unit_0/state_RNISD4B1[5]\ : NOR3C
      port map(A => \MoM_unit_0/RX_processed_0_a2_0_0\, B => 
        command_process_0_newMsg, C => \MoM_unit_0/N_125\, Y => 
        \MoM_unit_0.N_98\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/loadactivebit\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_last_bit_sent\, 
        Q => manchesterEncoderComplete_0_TX_Active);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/regload\ : 
        DFN1C0
      port map(D => \manchesterEncoderComplete_0/load_i_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/regload_net_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_2\ : 
        OA1
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_1_2_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_1_net_1\, 
        C => \command_process_0.N_150\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_2_net_1\);
    
    \md_v4_0/mdi2_RNO\ : NOR2B
      port map(A => \md_v4_0/mdi1_net_1\, B => md_v4_0_RX_end, Y
         => \md_v4_0/mdi2_2\);
    
    \md_v4_0/fre_ref_0/CEO_RNI5H3K1\ : OR2
      port map(A => \md_v4_0/fre_ref_0/Ref_clk\, B => 
        \md_v4_0/error_countere_1\, Y => \md_v4_0/error_countere\);
    
    \command_process_0/ParityRX_RNO_5\ : AO1D
      port map(A => \command_process_0.N_76\, B => 
        md_v4_0_new_data, C => \command_process_0.N_435\, Y => 
        \command_process_0/N_58\);
    
    \MoM_unit_0/state_RNI694Q1[6]\ : OA1C
      port map(A => MoM_unit_0_d_hk, B => \MoM_unit_0/N_60\, C
         => \MoM_unit_0/state[6]_net_1\, Y => \MoM_unit_0/N_118\);
    
    \md_v4_0/ctd1\ : DFN1E1C0
      port map(D => \md_v4_0/ctd1_2\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0/ctd1_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[7]\ : AX1A
      port map(A => \MoM_unit_0/N_74\, B => 
        \MoM_unit_0/aux_timeOut[5]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[7]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_n7_i_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNIIJ20D[2]\ : 
        MX2
      port map(A => \command_process_0.N_108\, B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/d_N_3_mux\, 
        S => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_2\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65\);
    
    \command_process_0/state_RNIUO7D[6]\ : OR3
      port map(A => \command_process_0/state[8]_net_1\, B => 
        \command_process_0/state[6]_net_1\, C => 
        \command_process_0/state[7]_net_1\, Y => 
        \command_process_0.N_76\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_RNI63P63\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_encoder_busy_0\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_65_i\);
    
    \command_process_0/state_RNIA1T93[1]\ : NOR2B
      port map(A => \command_process_0/N_184\, B => 
        \command_process_0.N_150\, Y => \command_process_0/N_122\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[0]\ : 
        OR2A
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[0]_net_1\);
    
    \command_process_0/bitCounter_RNO_0[2]\ : XOR2
      port map(A => \command_process_0/bitCounter[2]_net_1\, B
         => \command_process_0/N_70\, Y => 
        \command_process_0/bitCounter_n2_i_0\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[5]\ : 
        MX2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[4]_net_1\, 
        B => \manchesterEncoderComplete_0/N_6\, S => 
        \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[5]\);
    
    \command_process_0/ParityRX_RNO_2\ : OR2
      port map(A => \command_process_0/N_111\, B => 
        MoM_unit_0_RX_processed, Y => 
        \command_process_0/un2_dataclean_5_i_0\);
    
    \md_v4_0/fre_ref_0/q_RNO[3]\ : NOR3
      port map(A => \md_v4_0/fre_ref_0/N_28\, B => 
        \md_v4_0/fre_ref_0/N_26\, C => \md_v4_0/fre_ref_0/N_11\, 
        Y => \md_v4_0/fre_ref_0/N_10\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_RNO_1\ : 
        XNOR2
      port map(A => \manchesterEncoderComplete_0/N_27\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_0\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_2\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ULSICC_INSTANCE_0\ : 
        ULSICC_INT
      port map(USTDBY => \GND\, LPENA => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_net_1\);
    
    \command_process_0/reg_short_command_RNIELMI\ : NOR3B
      port map(A => \command_process_0.state[1]\, B => 
        \command_process_0/reg_long_command_net_1\, C => 
        \command_process_0/reg_short_command_net_1\, Y => 
        \command_process_0/N_181\);
    
    \md_v4_0/ctd2_RNI62A6\ : OR2
      port map(A => \md_v4_0/ctd2_net_1\, B => 
        \md_v4_0/ctd0_net_1\, Y => \md_v4_0/N_43\);
    
    \MoM_unit_0/Contention_int_RNI2MSO[4]\ : OR2A
      port map(A => \MoM_unit_0/Contention_int[4]_net_1\, B => 
        \MoM_unit_0/N_352\, Y => \MoM_unit_0/N_20\);
    
    \MoM_unit_0/state_RNO_2[4]\ : AO1A
      port map(A => \MoM_unit_0/state[2]_net_1\, B => 
        \MoM_unit_0/N_118\, C => \MoM_unit_0/N_113\, Y => 
        \MoM_unit_0/state_ns_0_0_o2_0[2]\);
    
    \MoM_unit_0/ChannelFreeTime_RNIETJ91\ : NOR3
      port map(A => \MoM_unit_0/NACKCnt[1]_net_1\, B => 
        \MoM_unit_0/ChannelFreeTime_net_1\, C => 
        \MoM_unit_0/NACKCnt[0]_net_1\, Y => 
        \MoM_unit_0/Contention_intlde_i_a2_0_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNIF2TQ[0]\ : 
        NOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_2\);
    
    \md_v4_0/error_counter_RNO[3]\ : NOR3
      port map(A => \md_v4_0/un1_error_happens\, B => 
        \md_v4_0/error_countere_1\, C => \md_v4_0/N_40_i\, Y => 
        \md_v4_0/N_35\);
    
    \command_process_0/state_RNO_2[0]\ : NOR2A
      port map(A => md_v4_0_new_data, B => 
        \command_process_0.state[1]\, Y => 
        \command_process_0/state_ns_i_0_a9_0_0[9]\);
    
    \command_process_0/addOK_reg\ : DFN1E0C0
      port map(D => \command_process_0/addok_NE\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_67\, Q => 
        \command_process_0/addOK_reg_net_1\);
    
    \command_process_0/state_RNO[6]\ : NOR3A
      port map(A => \command_process_0/N_96\, B => bit_error_1, C
         => \command_process_0.N_435\, Y => 
        \command_process_0/state_RNO[6]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNIPJNG2[0]\ : 
        NOR3C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_0\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_2\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy\);
    
    \MoM_unit_0/Contention_int_RNO[1]\ : XA1
      port map(A => \MoM_unit_0/Contention_int[0]_net_1\, B => 
        \MoM_unit_0/Contention_int[1]_net_1\, C => 
        \MoM_unit_0/N_120\, Y => \MoM_unit_0/N_6\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6\ : 
        NOR3C
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_N_6\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_net_1\, 
        C => \command_process_0.N_150\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_net_1\);
    
    \command_process_0/state_RNO_0[2]\ : MX2C
      port map(A => \command_process_0/state[2]_net_1\, B => 
        \command_process_0/state[3]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_98_0\);
    
    \MoM_unit_0/Contention_int_RNO_0[6]\ : OR2A
      port map(A => \MoM_unit_0/Contention_int[5]_net_1\, B => 
        \MoM_unit_0/N_20\, Y => \MoM_unit_0/N_353\);
    
    \MoM_unit_0/aux_timeOut[1]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n1\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[1]_net_1\);
    
    \MoM_unit_0/NEXT_STATE_DECODE.un22_commandreceived\ : NOR2
      port map(A => uC_commandType_c, B => 
        command_process_0_newMsg, Y => 
        \MoM_unit_0/un22_commandreceived\);
    
    \MoM_unit_0/state_RNI3TBF2[4]\ : AO1
      port map(A => \MoM_unit_0/N_92\, B => 
        command_process_0_newMsg, C => \MoM_unit_0.N_98\, Y => 
        MoM_unit_0_RX_processed);
    
    \MoM_unit_0/state_RNIIFF[1]\ : NOR2A
      port map(A => \MoM_unit_0/N_121\, B => CommandReady2ZB_c, Y
         => \MoMstateLed_c[0]\);
    
    \command_process_0/state_RNIDDRJ2[1]\ : OA1B
      port map(A => \command_process_0.N_435\, B => 
        \command_process_0/bitCounterlde_0_o2_0\, C => 
        \command_process_0.state[1]\, Y => 
        \command_process_0/N_184\);
    
    \md_v4_0/ctd1_RNO\ : NOR2B
      port map(A => \md_v4_0/ctd0_net_1\, B => md_v4_0_RX_end, Y
         => \md_v4_0/ctd1_2\);
    
    \command_process_0/reg_set_newMessage_RNO\ : OA1B
      port map(A => \command_process_0/set_newMessage_0_0_a9_0_0\, 
        B => \command_process_0/set_newMessage_0_0_a9_0\, C => 
        \command_process_0/N_69\, Y => 
        \command_process_0/set_newMessage\);
    
    \RingOscillator_0/ringO_cnt_0/DFN1C0_NU_0\ : DFN1C0
      port map(D => \RingOscillator_0/ringO_cnt_0/INV_1_Y\, CLK
         => \RingOscillator_0/AO14_15_Y\, CLR => RESETZB_c, Q => 
        \RingOscillator_0/ringO_cnt_0/NU_0\);
    
    \MoM_unit_0/state_RNO[5]\ : AO1
      port map(A => \MoM_unit_0/N_60\, B => MoM_unit_0_d_hk, C
         => \MoM_unit_0/state_ns_0_0[1]\, Y => 
        \MoM_unit_0/state_ns[1]\);
    
    \command_process_0/state_RNIV8896[9]\ : AO1
      port map(A => \command_process_0/bitCounterlde_0_a9_1_1\, B
         => \command_process_0/N_59\, C => 
        \command_process_0/N_121\, Y => 
        \command_process_0/bitCounterlde_0_0\);
    
    \RingOscillator_0/AO14_7\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_6_Y\, Y => 
        \RingOscillator_0/AO14_7_Y\);
    
    \md_v4_0/dataFiltered\ : DFN1E1C0
      port map(D => \md_v4_0/N_24\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0.dataFiltered\);
    
    \command_process_0/state_RNIOKN91[3]\ : OA1
      port map(A => \command_process_0/un2_dataclean_1_i_o4_0\, B
         => \command_process_0/un2_dataclean_1_i_o4_1\, C => 
        md_v4_0_new_data, Y => \command_process_0/N_105\);
    
    \MoM_unit_0/state_RNI3CA[3]\ : NOR2
      port map(A => \MoM_unit_0/state[3]_net_1\, B => 
        \MoM_unit_0.state[4]\, Y => \MoM_unit_0/N_121\);
    
    \InintialMsgInjector_0/aux3_RNO\ : NOR2A
      port map(A => \InintialMsgInjector_0/aux2_net_1\, B => 
        \InintialMsgInjector_0/aux5_net_1\, Y => 
        \InintialMsgInjector_0/aux3_2\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[1]\ : 
        MX2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[0]_net_1\, 
        B => \manchesterEncoderComplete_0/N_27\, S => 
        \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[1]\);
    
    \MoM_unit_0/aux_timeOut_RNO[11]\ : XA1B
      port map(A => \MoM_unit_0/aux_timeOut_c10\, B => 
        \MoM_unit_0/aux_timeOut[11]_net_1\, C => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n11\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[4]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[3]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[4]\, 
        S => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[4]\);
    
    \md_v4_0/ctd2_RNO\ : NOR3C
      port map(A => \md_v4_0/N_43\, B => \md_v4_0/ctd1_net_1\, C
         => md_v4_0_RX_end, Y => \md_v4_0/N_26\);
    
    \MoM_unit_0/state[0]\ : DFN1E1C0
      port map(D => \MoM_unit_0/N_327\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => RESETZB_c, Q => 
        \MoM_unit_0/state[0]_net_1\);
    
    \MoM_unit_0/NACKCnt[0]\ : DFN1C0
      port map(D => \MoM_unit_0/N_11\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, Q => \MoM_unit_0/NACKCnt[0]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNO[2]\ : 
        XO1A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_7_0\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_117\);
    
    \MoM_unit_0/state[6]\ : DFN1P0
      port map(D => \MoM_unit_0/state_ns_e[0]\, CLK => 
        CLK_GATED_c, PRE => RESETZB_c, Q => 
        \MoM_unit_0/state[6]_net_1\);
    
    \command_process_0/addressRX_RNO[3]\ : NOR3A
      port map(A => \command_process_0/addressRX[2]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[3]\);
    
    \md_v4_0/fre_ref_0/q_RNIABLG[3]\ : OR2A
      port map(A => \md_v4_0.receiving\, B => 
        \md_v4_0/fre_ref_0/N_27\, Y => \md_v4_0/fre_ref_0/N_11\);
    
    \md_v4_0/mdi1_RNI10QC1\ : OR2A
      port map(A => md_v4_0_RX_end, B => \md_v4_0/N_36_i\, Y => 
        \md_v4_0/error_countere_1\);
    
    \command_process_0/reg_short_command\ : DFN1E1C0
      port map(D => \command_process_0/reg_short_command_3\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/un1_dataclean\, Q => 
        \command_process_0/reg_short_command_net_1\);
    
    \InintialMsgInjector_0/aux4\ : DFN1C0
      port map(D => \InintialMsgInjector_0/aux4_2\, CLK => 
        RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        InintialMsgInjector_0_NewMsgInjector);
    
    \addressingData_0/MSB_NextHopAddress_0_a3[1]\ : NOR2
      port map(A => 
        \addressingData_0/un6_msb_nexthopaddress_net_1\, B => 
        \addressingData_0.N_58\, Y => 
        \addressingData_0_NextHopAddress_0[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[1]\ : 
        DFN1E1C0
      port map(D => \MoM_unit_0_commandToEncoder[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => MoM_unit_0_TX_load, Q
         => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[1]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNO[0]\ : 
        OR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_115\);
    
    \MoM_unit_0/aux_timeOut_RNINIOH4[9]\ : NOR2B
      port map(A => \MoM_unit_0/aux_timeOut_c8\, B => 
        \MoM_unit_0/aux_timeOut[9]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_c9\);
    
    \MoM_unit_0/aux_timeOut[10]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n10\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[10]_net_1\);
    
    \command_process_0/reg_long_command_RNO\ : NOR3B
      port map(A => \command_process_0/commandRX[2]_net_1\, B => 
        \command_process_0/reg_short_command_3_2\, C => 
        \command_process_0/commandRX[0]_net_1\, Y => 
        \command_process_0/reg_long_command_2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_15\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_partial_sum[0]\);
    
    \MoM_unit_0/state_RNO[4]\ : AO1C
      port map(A => manchesterEncoderComplete_0_TX_Active, B => 
        \MoM_unit_0.state[4]\, C => \MoM_unit_0/N_59\, Y => 
        \MoM_unit_0/state_ns[2]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI1K424[6]\ : 
        AO1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_83\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[4]\);
    
    \command_process_0/addressRX[5]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[5]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[5]_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNIA5NB1[4]\ : OR3C
      port map(A => \MoM_unit_0/aux_timeOut[0]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[3]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[4]_net_1\, Y => \MoM_unit_0/N_63\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[5]\ : 
        AOI1
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_i_0[0]\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        C => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[5]_net_1\);
    
    \CTRL1_Enab_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CTRL1_Enab_pad/U0/NET1\, E => 
        \CTRL1_Enab_pad/U0/NET2\, PAD => CTRL1_Enab);
    
    \selAdd_pad[2]/U0/U0\ : IOPAD_IN
      port map(PAD => selAdd(2), Y => \selAdd_pad[2]/U0/NET1\);
    
    \MoM_unit_0/state_RNO_0[5]\ : AO1A
      port map(A => \MoM_unit_0/un19_commandreceived\, B => 
        \MoM_unit_0/state_tr1_13\, C => \MoM_unit_0/N_328\, Y => 
        \MoM_unit_0/state_ns_0_0[1]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNIEEFT[2]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[2]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_82\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[5]\ : 
        AO1A
      port map(A => \MoM_unit_0.N_17\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_0[1]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[1]\);
    
    \INBUF_0/U0/U0\ : IOPAD_IN
      port map(PAD => RST, Y => \INBUF_0/U0/NET1\);
    
    \command_process_0/newMessage\ : DFN1E1C0
      port map(D => \command_process_0/N_134\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => 
        \command_process_0/un10_reg_set_newmessage\, Q => 
        command_process_0_newMsg);
    
    \command_process_0/addOK_reg_RNO_3\ : AX1A
      port map(A => \selAdd_c[1]\, B => \selAdd_c[0]\, C => 
        \command_process_0/addressRX[2]_net_1\, Y => 
        \command_process_0/N_86_i\);
    
    \md_v4_0/error_type\ : DFN1E1C0
      port map(D => \md_v4_0/error_type_1\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \md_v4_0/un14_mdisync\, Q => 
        \md_v4_0/error_type_net_1\);
    
    \RingOscillator_0/AO14_18\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_17_Y\, Y => 
        \RingOscillator_0/AO14_18_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_33\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_1[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_pog_array_1[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_2[0]\);
    
    \IRQ2_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \ZBControl_0.N_4\, E => \VCC\, DOUT => 
        \IRQ2_pad/U0/NET1\, EOUT => \IRQ2_pad/U0/NET2\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[0]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[0]\, 
        S => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_partial_sum[0]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]_net_1\);
    
    \MoM_unit_0/Contention_int_RNINOU9[3]\ : NOR2B
      port map(A => \MoM_unit_0/Contention_int[3]_net_1\, B => 
        \MoM_unit_0/Contention_int[4]_net_1\, Y => 
        \MoM_unit_0/un2_contentiontimeexpired_2\);
    
    \command_process_0/newMessage_RNIBCRC6\ : OR3
      port map(A => \command_process_0/N_2_0\, B => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, C => 
        \command_process_0/N_121\, Y => \command_process_0/N_10\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[7]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[7]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[7]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNO[0]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        C => \manchesterEncoderComplete_0/cuentaEnvios[0]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_77\);
    
    \MoM_unit_0/aux_timeOut_RNIFSR82[4]\ : NOR2
      port map(A => \MoM_unit_0/N_63\, B => \MoM_unit_0/N_65\, Y
         => \MoM_unit_0/aux_timeOut_c4\);
    
    \RX_OUT_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => RX_c_c, E => \VCC\, DOUT => 
        \RX_OUT_pad/U0/NET1\, EOUT => \RX_OUT_pad/U0/NET2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_115\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_counte\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\);
    
    \MoM_unit_0/command2send_RNI97D9[1]\ : INV
      port map(A => \MoM_unit_0_commandToEncoder[1]\, Y => 
        \MoM_unit_0_commandToEncoder_i[1]\);
    
    \md_v4_0/error_counter_RNO[1]\ : NOR3
      port map(A => \md_v4_0/un1_error_happens\, B => 
        \md_v4_0/error_countere_1\, C => 
        \md_v4_0/error_counter_n1_i_0\, Y => \md_v4_0/N_31\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNIDAR31[0]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_73\);
    
    \MoMstateLed_pad[2]/U0/U1\ : IOTRI_OB_EB
      port map(D => \MoMstateLed_c[2]\, E => \VCC\, DOUT => 
        \MoMstateLed_pad[2]/U0/NET1\, EOUT => 
        \MoMstateLed_pad[2]/U0/NET2\);
    
    \md_v4_0/newDataEdgeAux_RNIU13O\ : NOR2A
      port map(A => \md_v4_0.newDataEdgeAux\, B => 
        \md_v4_0.dataFiltered\, Y => md_v4_0_new_data);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNI8I4N[3]\ : 
        NOR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[3]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_0_sqmuxa\);
    
    \command_process_0/addressRX[0]\ : DFN0E1C0
      port map(D => \command_process_0/commandRX_3[0]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[0]_net_1\);
    
    \selAdd_pad[2]/U0/U1\ : IOIN_IB
      port map(YIN => \selAdd_pad[2]/U0/NET1\, Y => \selAdd_c[2]\);
    
    \addressingData_0/LSB_NodeAddress_i_a2[1]\ : NOR2
      port map(A => \selAdd_c[1]\, B => \selAdd_c[0]\, Y => 
        \addressingData_0.N_58\);
    
    \ZBControl_0/state_RNIB1I71[0]\ : AO1A
      port map(A => \ZBControl_0/N_9\, B => 
        \ZBControl_0/state[0]_net_1\, C => \ZBControl_0/N_14\, Y
         => IRQ3_c);
    
    \selExp_pad[0]/U0/U1\ : IOIN_IB
      port map(YIN => \selExp_pad[0]/U0/NET1\, Y => \selExp_c[0]\);
    
    \TX_pad/U0/U0\ : IOPAD_TRI_D
      port map(D => \TX_pad/U0/NET1\, E => \TX_pad/U0/NET2\, PAD
         => TX);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]\ : 
        DFN1P0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[5]_net_1\, 
        CLK => RingOscillator_0_CLK_OUT, PRE => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\);
    
    \CommandReady2ZB_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CommandReady2ZB_pad/U0/NET1\, E => 
        \CommandReady2ZB_pad/U0/NET2\, PAD => CommandReady2ZB);
    
    \md_v4_0/error_counter_RNO[0]\ : NOR3
      port map(A => \md_v4_0/un1_error_happens\, B => 
        \md_v4_0/error_countere_1\, C => 
        \md_v4_0/error_counter[0]_net_1\, Y => \md_v4_0/N_55\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNI8LSC[2]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0_0[2]\);
    
    \command_process_0/bitCounter[2]\ : DFN1E1C0
      port map(D => \command_process_0/N_39\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/bitCountere\, Q
         => \command_process_0/bitCounter[2]_net_1\);
    
    \command_process_0/state_RNO_4[9]\ : NOR2A
      port map(A => \command_process_0.state[1]\, B => 
        \command_process_0/reg_long_command_net_1\, Y => 
        \command_process_0/state_ns_0_a9_1_0[0]\);
    
    \f32_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => \f32_pad/U0/NET1\, 
        EOUT => \f32_pad/U0/NET2\);
    
    \command_process_0/state_RNIFODN1[5]\ : OA1A
      port map(A => md_v4_0_new_data, B => 
        \command_process_0/N_147\, C => bit_error_1, Y => 
        \command_process_0.N_108\);
    
    \MoM_unit_0/state_RNO_1[5]\ : NOR3C
      port map(A => \MoM_unit_0/state_tr1_10\, B => 
        \MoM_unit_0/state_tr1_9\, C => \MoM_unit_0/state_tr1_11\, 
        Y => \MoM_unit_0/state_tr1_13\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[1]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[1]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[1]_net_1\);
    
    \RingOscillator_0/AO14_2\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_1_Y\, Y => 
        \RingOscillator_0/AO14_2_Y\);
    
    \RingOscillator_0/AO14_1\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_0_Y\, Y => 
        \RingOscillator_0/AO14_1_Y\);
    
    \MoM_unit_0/NEXT_STATE_DECODE.un26_commandreceived\ : OA1
      port map(A => \MoM_unit_0/un4_commandreceived\, B => 
        \MoM_unit_0/un22_commandreceived\, C => 
        \MoM_unit_0/commandReceived_net_1\, Y => 
        \MoM_unit_0/un26_commandreceived\);
    
    \MoM_unit_0/command2send_RNIG2LO3[1]\ : OA1B
      port map(A => \addressingData_0_NextHopAddress_0[0]\, B => 
        \addressingData_0.un3_msb_nexthopaddress\, C => 
        \MoM_unit_0_commandToEncoder[1]\, Y => 
        \MoM_unit_0/un3_tx_active_0\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[3]\ : 
        MX2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[2]_net_1\, 
        B => \manchesterEncoderComplete_0/N_29\, S => 
        \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[3]\);
    
    \command_process_0/state[6]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[6]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[6]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNI2VTC_0[2]\ : 
        NOR3
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]_net_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit\);
    
    \MoM_unit_0/state_RNIKGL31[6]\ : NOR2A
      port map(A => \MoM_unit_0/N_77\, B => \MoM_unit_0/N_101\, Y
         => \MoM_unit_0.N_19\);
    
    \command_process_0/ParityRX_RNO_0\ : OR3
      port map(A => \command_process_0/un2_dataclean_5_i_1\, B
         => \command_process_0/un2_dataclean_5_i_0\, C => 
        \command_process_0.N_108\, Y => \command_process_0/N_14\);
    
    \RingOscillator_0/AO14_20\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_8_Y\, Y => 
        \RingOscillator_0/AO14_20_Y\);
    
    \RingOscillator_0/AO14_10\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_9_Y\, Y => 
        \RingOscillator_0/AO14_10_Y\);
    
    \command_process_0/newMessage_RNI0CDL1\ : OR3
      port map(A => \command_process_0/N_1\, B => bit_error_1, C
         => \MoM_unit_0.N_98\, Y => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\);
    
    \command_process_0/addressRX_RNO[5]\ : NOR3A
      port map(A => \command_process_0/addressRX[4]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[5]\);
    
    \MoM_unit_0/aux_timeOut_RNO[4]\ : NOR2A
      port map(A => \MoM_unit_0/aux_timeOut_n4_tz\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n4\);
    
    \MoM_unit_0/command2send_RNO[0]\ : MX2
      port map(A => uC_commandType_c, B => 
        \command_process_0_msgType_0[0]\, S => 
        command_process_0_newMsg, Y => 
        \MoM_unit_0/commandType[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_3[3]\ : 
        NOR3B
      port map(A => \manchesterEncoderComplete_0/cuentaEnvios[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        C => \manchesterEncoderComplete_0/cuentaEnvios[1]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_1_0[3]\);
    
    \md_v4_0/error_type_RNISNJH\ : OR2A
      port map(A => bit_error_1, B => \md_v4_0/error_type_net_1\, 
        Y => md_v4_0_RX_end);
    
    \command_process_0/state_RNO[8]\ : NOR2
      port map(A => \command_process_0/N_102\, B => bit_error_1, 
        Y => \command_process_0/state_RNO[8]_net_1\);
    
    \command_process_0/reg_set_newMessage_RNO_0\ : NOR2A
      port map(A => \command_process_0/state[0]_net_1\, B => 
        \command_process_0/N_67\, Y => 
        \command_process_0/set_newMessage_0_0_a9_0_0\);
    
    \command_process_0/reg_set_newMessage_RNINVAB\ : NOR3B
      port map(A => \command_process_0/ParityRX_net_1\, B => 
        \command_process_0/reg_set_newMessage_net_1\, C => 
        command_process_0_newMsg, Y => \command_process_0/N_134\);
    
    \MoM_unit_0/un1_NACKCnt_I_1\ : AND2
      port map(A => \MoM_unit_0/NACKCnt[0]_net_1\, B => 
        \MoM_unit_0/un17_waitingackenab\, Y => 
        \MoM_unit_0/DWACT_ADD_CI_0_TMP[0]\);
    
    \housekeepingCheck_0/Result_5_1\ : NOR3A
      port map(A => LowpoerM_hk, B => RX_c_c, C => 
        \md_v4_0.receiving\, Y => 
        \housekeepingCheck_0/Result_5_1_net_1\);
    
    \R2SINKTimeout_pad/U0/U0\ : IOPAD_IN_D
      port map(PAD => R2SINKTimeout, Y => 
        \R2SINKTimeout_pad/U0/NET1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[0]\ : 
        DFN1P0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[0]_net_1\, 
        CLK => RingOscillator_0_CLK_OUT, PRE => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_i_0[0]\);
    
    \command_process_0/AddOKflag_RNO\ : NOR2B
      port map(A => \command_process_0/addOK_reg_net_1\, B => 
        \command_process_0/N_134\, Y => 
        \command_process_0/AddOKflag_2\);
    
    \md_v4_0/fre_ref_0/q_RNO_0[3]\ : OA1B
      port map(A => \md_v4_0/fre_ref_0/q_i_0[0]\, B => 
        \md_v4_0/fre_ref_0/q_i_0[2]\, C => 
        \md_v4_0/fre_ref_0/q[3]_net_1\, Y => 
        \md_v4_0/fre_ref_0/N_26\);
    
    \md_v4_0/fre_ref_0/q[0]\ : DFN1P0
      port map(D => \md_v4_0/fre_ref_0/q_n0\, CLK => CLK_GATED_c, 
        PRE => RESETZB_c, Q => \md_v4_0/fre_ref_0/q_i_0[0]\);
    
    \RESETZB_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => RESETZB_c, E => \VCC\, DOUT => 
        \RESETZB_pad/U0/NET1\, EOUT => \RESETZB_pad/U0/NET2\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[3]\ : 
        NOR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[4]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[2]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/TXbuff_free\ : 
        DFN1E1P0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty\, 
        CLK => CLK_GATED_c, PRE => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un10_load\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\);
    
    \MoMstateLed_pad[2]/U0/U0\ : IOPAD_TRI
      port map(D => \MoMstateLed_pad[2]/U0/NET1\, E => 
        \MoMstateLed_pad[2]/U0/NET2\, PAD => MoMstateLed(2));
    
    \InintialMsgInjector_0/aux4_RNO\ : NOR2A
      port map(A => \InintialMsgInjector_0/aux3_net_1\, B => 
        \InintialMsgInjector_0/aux5_net_1\, Y => 
        \InintialMsgInjector_0/aux4_2\);
    
    \command_process_0/state_RNO_3[0]\ : OR2B
      port map(A => \command_process_0/reg_long_command_net_1\, B
         => \command_process_0.state[1]\, Y => 
        \command_process_0/N_80\);
    
    \command_process_0/state_RNO_2[9]\ : NOR2A
      port map(A => \command_process_0/state_ns_0_a9_2_0[0]\, B
         => \command_process_0/N_67\, Y => 
        \command_process_0/N_133\);
    
    \MoM_unit_0/aux_timeOut_RNO[3]\ : NOR2A
      port map(A => \MoM_unit_0/aux_timeOut_n3_tz\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n3\);
    
    \command_process_0/commandRX_RNO[3]\ : NOR3A
      port map(A => \command_process_0/commandRX[2]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/commandRX_3[3]\);
    
    \command_process_0/addressRX[2]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[2]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[2]_net_1\);
    
    \MoM_unit_0/state_RNO[1]\ : AO1
      port map(A => \MoM_unit_0/un19_commandreceived\, B => 
        \MoM_unit_0/state[2]_net_1\, C => \MoM_unit_0/N_335\, Y
         => \MoM_unit_0/state_ns[5]\);
    
    \MoM_unit_0/aux_timeOut_RNILGNB1[8]\ : OR3B
      port map(A => \MoM_unit_0/aux_timeOut[8]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[9]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[1]_net_1\, Y => 
        \MoM_unit_0/un13_timeoutack_0_o2_2\);
    
    \command_process_0/addressRX_RNO[1]\ : NOR3A
      port map(A => \command_process_0/addressRX[0]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[1]\);
    
    \RingOscillator_0/muxSwitcthRing_0/MX2_Result\ : MX2
      port map(A => \RingOscillator_0/NAND2_0_Y\, B => \GND\, S
         => LedMochila_c, Y => 
        \RingOscillator_0/muxSwitcthRing_0_Result\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_34\ : 
        AND2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_pog_array_1[0]\);
    
    \command_process_0/state_RNITJ1M[0]\ : NOR3
      port map(A => \command_process_0/un2_dataclean_1_i_o4_0\, B
         => \command_process_0/un2_dataclean_1_i_o4_1\, C => 
        \command_process_0/state[0]_net_1\, Y => 
        \command_process_0.N_150\);
    
    \md_v4_0/mdi1_RNO\ : NOR2B
      port map(A => \md_v4_0/mdiSync_net_1\, B => md_v4_0_RX_end, 
        Y => \md_v4_0/N_16\);
    
    \CTRL1_Enab_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \MoM_unit_0.N_19\, E => \VCC\, DOUT => 
        \CTRL1_Enab_pad/U0/NET1\, EOUT => 
        \CTRL1_Enab_pad/U0/NET2\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_RNO\ : 
        OR2
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_ff_current_state\);
    
    \selAdd_pad[1]/U0/U0\ : IOPAD_IN
      port map(PAD => selAdd(1), Y => \selAdd_pad[1]/U0/NET1\);
    
    \CommandReady2ZB_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => CommandReady2ZB_c, E => \VCC\, DOUT => 
        \CommandReady2ZB_pad/U0/NET1\, EOUT => 
        \CommandReady2ZB_pad/U0/NET2\);
    
    \command_process_0/addressRX[6]\ : DFN0E1C0
      port map(D => \command_process_0/N_55\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[6]_net_1\);
    
    \MoM_unit_0/Contention_int_RNO[3]\ : XA1A
      port map(A => \MoM_unit_0/Contention_int[3]_net_1\, B => 
        \MoM_unit_0/N_18\, C => \MoM_unit_0/N_120\, Y => 
        \MoM_unit_0/N_10\);
    
    \md_v4_0/error_flag\ : DFN1E1C0
      port map(D => \md_v4_0/un1_error_happens\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \md_v4_0/un14_mdisync\, Q => bit_error_1);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNIMK0J4[1]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[1]_net_1\, 
        B => \addressingData_0_NextHopAddress_0[1]\, S => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_52\);
    
    \command_process_0/state[1]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[1]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0.state[1]\);
    
    \command_process_0/state[9]\ : DFN1P0
      port map(D => \command_process_0/state_ns[0]\, CLK => 
        CLK_GATED_c, PRE => RESETZB_c, Q => 
        \command_process_0.state[9]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNI8DCN1[0]\ : 
        OR3C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        B => \manchesterEncoderComplete_0/state[3]\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_46\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request\ : 
        DFN1E1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_0_sqmuxa\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, E => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_housekeeping_request_0_sqmuxa\, 
        Q => LowpoerM_hk);
    
    \MoM_unit_0/state_RNIFP031[4]\ : OR2A
      port map(A => \MoM_unit_0.state[4]\, B => 
        \MoM_unit_0.un2_contentiontimeexpired\, Y => 
        \MoM_unit_0/N_77\);
    
    \md_v4_0/newDataEdgeAux\ : DFN1E0C0
      port map(D => \md_v4_0/newDataEdgeAux_2\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => \md_v4_0/N_46\, Q => 
        \md_v4_0.newDataEdgeAux\);
    
    \md_v4_0/receiving_RNIFDAM\ : NOR2A
      port map(A => md_v4_0_RX_end, B => \md_v4_0.receiving\, Y
         => \md_v4_0/N_46\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr[6]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[6]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[6]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNI3COH2\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/loadactivebit\, 
        B => manchesterEncoderComplete_0_TX_Active, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un4_bit_end\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg\ : 
        DFN1P0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_FlashFreeze_i\, 
        CLK => RingOscillator_0_CLK_OUT, PRE => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\);
    
    \command_process_0/msgType[1]\ : DFN1E1C0
      port map(D => \command_process_0/msgType_3[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/un10_reg_set_newmessage\, Q => 
        \command_process_0_msgType_0[1]\);
    
    \RX_pad/U0/U0\ : IOPAD_IN
      port map(PAD => RX, Y => \RX_pad/U0/NET1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNI5TFA1[2]\ : 
        OR3B
      port map(A => \manchesterEncoderComplete_0/cuentaEnvios[0]\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[2]\, C => 
        \manchesterEncoderComplete_0/cuentaEnvios[1]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\);
    
    \md_v4_0/fre_ref_0/q_RNO_0[1]\ : XOR2
      port map(A => \md_v4_0/fre_ref_0/q[1]_net_1\, B => 
        \md_v4_0/fre_ref_0/q_i_0[0]\, Y => 
        \md_v4_0/fre_ref_0/q_n1_i_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_21\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]_net_1\);
    
    \selAdd_pad[1]/U0/U1\ : IOIN_IB
      port map(YIN => \selAdd_pad[1]/U0/NET1\, Y => \selAdd_c[1]\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_1_2_1\ : 
        NOR2B
      port map(A => \command_process_0.un2_dataclean_5_i_a9_1_0\, 
        B => md_v4_0_new_data, Y => 
        \command_process_0.un1_commProc_busy_1_0_a2_0_1\);
    
    \md_v4_0/error_counter_RNI633A[1]\ : NOR2B
      port map(A => \md_v4_0/un1_error_happens_0_a3_0\, B => 
        \md_v4_0/N_59\, Y => \md_v4_0/un1_error_happens\);
    
    \command_process_0/state_RNIO2JAB[1]\ : OR3
      port map(A => \command_process_0/N_122\, B => 
        \command_process_0/bitCounterlde_0_0\, C => 
        \command_process_0.N_108\, Y => 
        \command_process_0/bitCountere\);
    
    \selExp_pad[0]/U0/U0\ : IOPAD_IN
      port map(PAD => selExp(0), Y => \selExp_pad[0]/U0/NET1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIUDTN6[6]\ : 
        AO1
      port map(A => \addressingData_0_NextHopAddress_0[2]\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_83\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_0[2]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[2]\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]\ : 
        DFN1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[4]\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[1]_net_1\);
    
    \command_process_0/state_RNO[2]\ : NOR2
      port map(A => \command_process_0/N_98_0\, B => bit_error_1, 
        Y => \command_process_0/state_RNO[2]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[5]\ : 
        AO1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_0_0[1]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_82\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_59\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_0[1]\);
    
    \CommandType2ZB_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => CommandType2ZB_c, E => \VCC\, DOUT => 
        \CommandType2ZB_pad/U0/NET1\, EOUT => 
        \CommandType2ZB_pad/U0/NET2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNI1LDU4[3]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[3]_net_1\, 
        B => \addressingData_0_NextHopAddress_0[3]\, S => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_53\);
    
    \InintialMsgInjector_0/aux2\ : DFN1C0
      port map(D => \InintialMsgInjector_0/aux2_2\, CLK => 
        RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \InintialMsgInjector_0/aux2_net_1\);
    
    \MoM_unit_0/state[4]\ : DFN1E1C0
      port map(D => \MoM_unit_0/state_ns[2]\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => RESETZB_c, Q => 
        \MoM_unit_0.state[4]\);
    
    \MoM_unit_0/aux_timeOut_RNO[2]\ : NOR2A
      port map(A => \MoM_unit_0/aux_timeOut_n2_tz\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNICSUM[5]\ : 
        NOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/loadEncoder_i_a3_0_a3_0\);
    
    \RingOscillator_0/AO14_22\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_21_Y\, Y => 
        \RingOscillator_0/AO14_22_Y\);
    
    \RingOscillator_0/AO14_12\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_2_Y\, Y => 
        \RingOscillator_0/AO14_12_Y\);
    
    \BIBUF_0/U0/U1\ : IOBI_IB_OB_EB
      port map(D => \GND\, E => \MoM_unit_0.N_19\, YIN => 
        \BIBUF_0/U0/NET3\, DOUT => \BIBUF_0/U0/NET1\, EOUT => 
        \BIBUF_0/U0/NET2\, Y => OPEN);
    
    \RingOscillator_0/AO14_0\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/muxSwitcthRing_0_Result\, Y => 
        \RingOscillator_0/AO14_0_Y\);
    
    \MoM_unit_0/aux_timeOut[12]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n12\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[12]_net_1\);
    
    \command_process_0/commandRX[3]\ : DFN0E1C0
      port map(D => \command_process_0/commandRX_3[3]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_5\, Q => 
        \command_process_0/commandRX[3]_net_1\);
    
    \MoM_unit_0/state_RNO_0[4]\ : AO1
      port map(A => \MoM_unit_0/N_118\, B => 
        \MoM_unit_0/N_301_tz\, C => 
        \MoM_unit_0/state_ns_0_0_o2_0[2]\, Y => \MoM_unit_0/N_59\);
    
    \MoM_unit_0/aux_timeOut_RNO[5]\ : NOR2A
      port map(A => \MoM_unit_0/aux_timeOut_n5_tz\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n5\);
    
    \command_process_0/reg_short_command_RNO\ : NOR3B
      port map(A => \command_process_0/commandRX[0]_net_1\, B => 
        \command_process_0/reg_short_command_3_2\, C => 
        \command_process_0/commandRX[2]_net_1\, Y => 
        \command_process_0/reg_short_command_3\);
    
    \housekeepingCheck_0/Result_5_2\ : NOR2A
      port map(A => MoM_unit_0_d_hk, B => 
        command_process_0_newMsg, Y => 
        \housekeepingCheck_0/Result_5_2_net_1\);
    
    \MoM_unit_0/state_RNI5NK[6]\ : NOR3A
      port map(A => \MoM_unit_0/N_121\, B => 
        \MoM_unit_0/state[6]_net_1\, C => 
        \MoM_unit_0/state[0]_net_1\, Y => \MoM_unit_0/N_101\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/control_user_clock\ : 
        DFN1E1P0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\, 
        CLK => RingOscillator_0_CLK_OUT, PRE => RESETZB_c, E => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_58\, 
        Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/control_user_clock_net\);
    
    \command_process_0/msgType_RNO[0]\ : NOR2B
      port map(A => \command_process_0/N_134\, B => 
        \command_process_0/commandRX[0]_net_1\, Y => 
        \command_process_0/msgType_3[0]\);
    
    \MoM_unit_0/aux_timeOut_RNIE05T[7]\ : OR2B
      port map(A => \MoM_unit_0/aux_timeOut[7]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[5]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_c7_0_o2_0\);
    
    \RingOscillator_0/ringO_cnt_0/INV_1\ : INV
      port map(A => \RingOscillator_0/ringO_cnt_0/NU_0\, Y => 
        \RingOscillator_0/ringO_cnt_0/INV_1_Y\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0\ : 
        NOR2
      port map(A => \command_process_0.state[1]\, B => 
        \command_process_0.N_76\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_0_net_1\);
    
    \command_process_0/addressRX_RNO[7]\ : NOR3A
      port map(A => \command_process_0/addressRX[6]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[7]\);
    
    \command_process_0/addressRX[1]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[1]_net_1\);
    
    \command_process_0/reg_set_newMessage_RNO_1\ : NOR2B
      port map(A => \command_process_0/reg_short_command_net_1\, 
        B => \command_process_0.state[1]\, Y => 
        \command_process_0/set_newMessage_0_0_a9_0\);
    
    \addressingData_0/un6_msb_nexthopaddress\ : NOR3A
      port map(A => \selExp_c[1]\, B => \selAdd_c[0]\, C => 
        \selExp_c[0]\, Y => 
        \addressingData_0/un6_msb_nexthopaddress_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[3]\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_1_0[3]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_82\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_65\);
    
    \MoM_unit_0/Contention_int_RNO[6]\ : XA1A
      port map(A => \MoM_unit_0/Contention_int[6]_net_1\, B => 
        \MoM_unit_0/N_353\, C => \MoM_unit_0/N_120\, Y => 
        \MoM_unit_0/N_16\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNO[2]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_45_i\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_35\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIKSE12[3]\ : 
        OA1C
      port map(A => \manchesterEncoderComplete_0/state[3]\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_57\);
    
    \MoM_unit_0/command2send[1]\ : DFN1E0C0
      port map(D => \MoM_unit_0/commandType[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => \MoM_unit_0/N_60\, Q
         => \MoM_unit_0_commandToEncoder[1]\);
    
    \command_process_0/state_RNO_3[9]\ : NOR2B
      port map(A => \command_process_0.state[9]\, B => 
        \command_process_0/N_78\, Y => \command_process_0/N_130\);
    
    \command_process_0/reg_command_error\ : DFN1E1C0
      port map(D => \command_process_0/N_23\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/un1_dataclean\, 
        Q => \command_process_0/reg_command_error_net_1\);
    
    \command_process_0/state_RNO_5[9]\ : NOR2B
      port map(A => \command_process_0/state[0]_net_1\, B => 
        md_v4_0_new_data, Y => 
        \command_process_0/state_ns_0_a9_2_0[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNO[1]\ : 
        XO1A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_116\);
    
    \RingOscillator_0/ringO_cnt_0/DFN1E1C0_NU_3\ : DFN1E1C0
      port map(D => \AFLSDF_INV_0\, CLK => 
        \RingOscillator_0/AO14_15_Y\, CLR => RESETZB_c, E => 
        \RingOscillator_0/ringO_cnt_0/NU_0_1_2\, Q => 
        \RingOscillator_0/ringO_cnt_0/RingOscillator_0_CLK_OUT_i\);
    
    \md_v4_0/error_counter_RNILJ15[3]\ : NOR2B
      port map(A => \md_v4_0/error_counter[3]_net_1\, B => 
        \md_v4_0/error_counter[2]_net_1\, Y => 
        \md_v4_0/un1_error_happens_0_a3_0\);
    
    \command_process_0/state_ns_i_0_o4[5]\ : OR2B
      port map(A => \md_v4_0.mdi2\, B => md_v4_0_new_data, Y => 
        \command_process_0/N_78\);
    
    \addressingData_0/LSB_NodeAddress_0[0]\ : OR2B
      port map(A => \selAdd_c[1]\, B => \selAdd_c[0]\, Y => 
        \addressingData_0_NodeAddress_0[0]\);
    
    \command_process_0/state_RNO[9]\ : AO1
      port map(A => \command_process_0.N_76\, B => 
        \command_process_0.N_435\, C => 
        \command_process_0/state_ns_0_2[0]\, Y => 
        \command_process_0/state_ns[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[0]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]_net_1\);
    
    \md_v4_0/error_counter_RNO[2]\ : NOR3
      port map(A => \md_v4_0/un1_error_happens\, B => 
        \md_v4_0/error_countere_1\, C => 
        \md_v4_0/error_counter_n2_i_0\, Y => \md_v4_0/N_33\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_RNO\ : 
        INV
      port map(A => \LowPowerManagement_0/N_FlashFreeze\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_FlashFreeze_i\);
    
    \MoM_unit_0/state[5]\ : DFN1E1C0
      port map(D => \MoM_unit_0/state_ns[1]\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => RESETZB_c, Q => MoM_unit_0_d_hk);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc\ : 
        DFN1E1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_0_sqmuxa\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, E => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/un1_ff_current_state\, 
        Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/continueFlag\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_i\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un10_load\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/continueFlag_net_1\);
    
    \command_process_0/state_RNINKDM[5]\ : AOI1
      port map(A => \command_process_0.state[9]\, B => 
        \md_v4_0.mdi2\, C => \command_process_0/state[5]_net_1\, 
        Y => \command_process_0/N_147\);
    
    \addressingData_0/un3_msb_nexthopaddress_1\ : NOR2B
      port map(A => \selExp_c[0]\, B => \selAdd_c[2]\, Y => 
        \addressingData_0/un3_msb_nexthopaddress_1_net_1\);
    
    \MoM_unit_0/RX_processed_0_a2_1\ : NOR3
      port map(A => \command_process_0_msgType_0[1]\, B => 
        AddOKflag_0, C => \command_process_0_msgType_0[0]\, Y => 
        \MoM_unit_0/N_125\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[1]\ : 
        OR2
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/trigger_ulsicc_0_sqmuxa\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[4]\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNIV4GBD[5]\ : 
        OR2
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_58\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa_a0\ : 
        NOR2A
      port map(A => \manchesterEncoderComplete_0/state[3]\, B => 
        \manchesterEncoderComplete_0/cuentaEnvios[2]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_1_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI5QBO[0]\ : 
        AO1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_39\);
    
    \RingOscillator_0/AO14_16\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_13_Y\, Y => 
        \RingOscillator_0/AO14_16_Y\);
    
    \MoM_unit_0/Contention_int[3]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_10\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[3]_net_1\);
    
    \RingOscillator_0/ringO_cnt_0/AND2_0\ : AND2
      port map(A => \RingOscillator_0/ringO_cnt_0/NU_0\, B => 
        \RingOscillator_0/ringO_cnt_0/NU_1\, Y => 
        \RingOscillator_0/ringO_cnt_0/AND2_0_Y\);
    
    \command_process_0/newMessage_RNIRR273\ : NOR3
      port map(A => \command_process_0/N_2_0\, B => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, C => 
        \md_v4_0.mdi2\, Y => \command_process_0/commandRX_3[0]\);
    
    \md_v4_0/ctd0_RNO_0\ : NOR2
      port map(A => \md_v4_0/ctd0_net_1\, B => \md_v4_0/N_36_i\, 
        Y => \md_v4_0/N_54\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[3]\ : 
        DFN1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[2]\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[3]_net_1\);
    
    \MoM_unit_0/state_RNIP1S4[3]\ : NOR2A
      port map(A => \MoM_unit_0/state[3]_net_1\, B => 
        manchesterEncoderComplete_0_TX_Active, Y => 
        \MoM_unit_0/N_107_1\);
    
    \md_v4_0/error_counter_RNO_0[2]\ : XOR2
      port map(A => \md_v4_0/error_counter[2]_net_1\, B => 
        \md_v4_0/N_37\, Y => \md_v4_0/error_counter_n2_i_0\);
    
    \command_process_0/state[4]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[4]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[4]_net_1\);
    
    \command_process_0/newMessage_RNIGC734\ : OR3
      port map(A => \command_process_0/N_2_0\, B => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, C => 
        \command_process_0/N_105\, Y => \command_process_0/N_5\);
    
    \command_process_0/ParityRX_RNO_7\ : NOR3
      port map(A => \command_process_0.N_76\, B => 
        \command_process_0.state[9]\, C => 
        \command_process_0/N_78\, Y => \command_process_0/N_111\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[4]\ : 
        AO1C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_0_0[2]\);
    
    \md_v4_0/error_counter[2]\ : DFN0E1C0
      port map(D => \md_v4_0/N_33\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/error_countere\, Q => 
        \md_v4_0/error_counter[2]_net_1\);
    
    \ZBControl_0/state_RNO[1]\ : AO1A
      port map(A => \ZBControl_0/N_9\, B => 
        \ZBControl_0/state[0]_net_1\, C => 
        \ZBControl_0/state_ns_0_i_0[1]\, Y => \ZBControl_0/N_8\);
    
    \LedMochila_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => LedMochila_c, E => \VCC\, DOUT => 
        \LedMochila_pad/U0/NET1\, EOUT => 
        \LedMochila_pad/U0/NET2\);
    
    \md_v4_0/fre_ref_0/CEO\ : DFN1C0
      port map(D => \md_v4_0/fre_ref_0/CEO_4\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, Q => \md_v4_0/fre_ref_0/Ref_clk\);
    
    \md_v4_0/fre_ref_0/CEO_RNO\ : NOR3C
      port map(A => \md_v4_0.receiving\, B => 
        \md_v4_0/fre_ref_0/q[3]_net_1\, C => 
        \md_v4_0/fre_ref_0/N_28\, Y => \md_v4_0/fre_ref_0/CEO_4\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_RNO_0\ : 
        XOR3
      port map(A => \manchesterEncoderComplete_0/N_29\, B => 
        \manchesterEncoderComplete_0/N_6\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[4]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_3\);
    
    \MoM_unit_0/state_RNIN6RF_0[6]\ : NOR2A
      port map(A => \MoM_unit_0/state[6]_net_1\, B => RESETZB_c, 
        Y => \MoM_unit_0/state_ns_e[0]\);
    
    \command_process_0/msgType_RNO[1]\ : NOR2B
      port map(A => \command_process_0/commandRX[1]_net_1\, B => 
        \command_process_0/N_134\, Y => 
        \command_process_0/msgType_3[1]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_RNI698O2\ : 
        OR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNIVTU82_0[2]\ : 
        NOR2B
      port map(A => \housekeepingCheck_0.Result_5\, B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65_1\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/d_N_3_mux\);
    
    \INBUF_0/U0/U1\ : IOIN_IB
      port map(YIN => \INBUF_0/U0/NET1\, Y => INBUF_0);
    
    \MoM_unit_0/Contention_int_RNIBTTE[1]\ : NOR3
      port map(A => \MoM_unit_0/Contention_int[2]_net_1\, B => 
        \MoM_unit_0/Contention_int[1]_net_1\, C => 
        \MoM_unit_0/Contention_int[0]_net_1\, Y => 
        \MoM_unit_0/un2_contentiontimeexpired_3\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNIU5SD5\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa_1_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_2_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa\);
    
    \MoM_unit_0/NACKCnt_RNO[0]\ : NOR3A
      port map(A => \MoM_unit_0/DWACT_ADD_CI_0_partial_sum[0]\, B
         => \MoM_unit_0/N_119\, C => 
        \MoM_unit_0/NACKCnt_5_i_1_0[1]\, Y => \MoM_unit_0/N_11\);
    
    \MoM_unit_0/aux_timeOut[7]\ : DFN1C0
      port map(D => \MoM_unit_0/N_36\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, Q => \MoM_unit_0/aux_timeOut[7]_net_1\);
    
    \MoM_unit_0/ChannelFreeTime\ : DFN1E1C0
      port map(D => \MoM_unit_0/un12_contentionenab\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \MoM_unit_0/un7_tx_active\, Q => 
        \MoM_unit_0/ChannelFreeTime_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[4]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]_net_1\);
    
    \md_v4_0/ctd2\ : DFN1E1C0
      port map(D => \md_v4_0/N_26\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0/ctd2_net_1\);
    
    \command_process_0/newMessage_RNIOB241\ : NOR3C
      port map(A => command_process_0_newMsg, B => 
        \MoM_unit_0.state[4]\, C => 
        \MoM_unit_0.un2_contentiontimeexpired\, Y => 
        \command_process_0/N_2_0\);
    
    \MoM_unit_0/Contention_int_RNO[4]\ : XA1A
      port map(A => \MoM_unit_0/Contention_int[4]_net_1\, B => 
        \MoM_unit_0/N_352\, C => \MoM_unit_0/N_120\, Y => 
        \MoM_unit_0/N_12\);
    
    \MoM_unit_0/aux_timeOut_RNO_1[4]\ : OR2B
      port map(A => \MoM_unit_0/aux_timeOut[3]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[0]_net_1\, Y => \MoM_unit_0/N_62\);
    
    \command_process_0/addOK_reg_RNO_0\ : XO1A
      port map(A => \command_process_0/addressRX[1]_net_1\, B => 
        \addressingData_0.N_58\, C => \command_process_0/N_86_i\, 
        Y => \command_process_0/addok_NE_0_3\);
    
    \RX_OUT_pad/U0/U0\ : IOPAD_TRI
      port map(D => \RX_OUT_pad/U0/NET1\, E => 
        \RX_OUT_pad/U0/NET2\, PAD => RX_OUT);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNIVTU82[2]\ : 
        OR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65_1\, 
        B => \housekeepingCheck_0.Result_5\, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_0\);
    
    \command_process_0/bitCounter_RNIAQ7R1[2]\ : OR2
      port map(A => 
        \command_process_0/un2_address_end_0_a2_2_o4_1\, B => 
        \command_process_0/un2_address_end_0_a2_2_o4_0\, Y => 
        \command_process_0/N_67\);
    
    \MoM_unit_0/Contention_int_RNO[5]\ : XA1A
      port map(A => \MoM_unit_0/Contention_int[5]_net_1\, B => 
        \MoM_unit_0/N_20\, C => \MoM_unit_0/N_120\, Y => 
        \MoM_unit_0/N_14\);
    
    \addressingData_0/LSB_NextHopAddress[1]\ : MX2
      port map(A => \addressingData_0.un3_msb_nexthopaddress\, B
         => \selAdd_c[1]\, S => 
        \addressingData_0_NextHopAddress_0[0]\, Y => 
        \addressingData_0_NextHopAddress_0[1]\);
    
    \command_process_0/state_RNO[0]\ : NOR3
      port map(A => \command_process_0/N_126\, B => bit_error_1, 
        C => \command_process_0/N_125\, Y => 
        \command_process_0/state_RNO[0]_net_1\);
    
    \command_process_0/reg_long_command\ : DFN1E1C0
      port map(D => \command_process_0/reg_long_command_2\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/un1_dataclean\, Q => 
        \command_process_0/reg_long_command_net_1\);
    
    \RingOscillator_0/AO14_3\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_16_Y\, Y => 
        \RingOscillator_0/AO14_3_Y\);
    
    \MoM_unit_0/command2send[0]\ : DFN1E0C0
      port map(D => \MoM_unit_0/commandType[0]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => \MoM_unit_0/N_60\, Q
         => CommandType2ZB_c);
    
    \md_v4_0/error_counter_RNIHF15[1]\ : OR2B
      port map(A => \md_v4_0/error_counter[1]_net_1\, B => 
        \md_v4_0/error_counter[0]_net_1\, Y => \md_v4_0/N_37\);
    
    \CommandType2ZB_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CommandType2ZB_pad/U0/NET1\, E => 
        \CommandType2ZB_pad/U0/NET2\, PAD => CommandType2ZB);
    
    \addressingData_0/un3_msb_nexthopaddress\ : NOR3B
      port map(A => \selExp_c[1]\, B => 
        \addressingData_0/un3_msb_nexthopaddress_1_net_1\, C => 
        \selAdd_c[1]\, Y => 
        \addressingData_0.un3_msb_nexthopaddress\);
    
    \MoM_unit_0/NEXT_STATE_DECODE.un19_commandreceived_i_i_a2\ : 
        NOR2B
      port map(A => \MoM_unit_0/N_125\, B => 
        \MoM_unit_0/commandReceived_net_1\, Y => 
        \MoM_unit_0/un19_commandreceived\);
    
    \RingOscillator_0/AO14_9\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_22_Y\, Y => 
        \RingOscillator_0/AO14_9_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[4]\ : 
        OA1C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_82\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[1]\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_0_0[2]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[4]_net_1\);
    
    \AddOKflag_pad/U0/U0\ : IOPAD_TRI
      port map(D => \AddOKflag_pad/U0/NET1\, E => 
        \AddOKflag_pad/U0/NET2\, PAD => AddOKflag);
    
    \command_process_0/state_RNO_0[5]\ : AOI1
      port map(A => \command_process_0/state[6]_net_1\, B => 
        md_v4_0_new_data, C => \command_process_0/state[5]_net_1\, 
        Y => \command_process_0/N_124\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[5]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_4[5]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[5]_net_1\);
    
    \RingOscillator_0/AO14_19\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_18_Y\, Y => 
        \RingOscillator_0/AO14_19_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_1[5]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[1]\, C => 
        \manchesterEncoderComplete_0/cuentaEnvios[0]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_0_a3_0_0[1]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios[2]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_35\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_20\, 
        Q => \manchesterEncoderComplete_0/cuentaEnvios[2]\);
    
    \MoM_unit_0/un1_NACKCnt_I_8\ : XOR2
      port map(A => \MoM_unit_0/NACKCnt[0]_net_1\, B => 
        \MoM_unit_0/un17_waitingackenab\, Y => 
        \MoM_unit_0/DWACT_ADD_CI_0_partial_sum[0]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_116\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_counte\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIOGE21[6]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_i_0[3]\);
    
    \MoM_unit_0/aux_timeOut_RNI9KKI4[10]\ : NOR2B
      port map(A => \MoM_unit_0/aux_timeOut_c9\, B => 
        \MoM_unit_0/aux_timeOut[10]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_c10\);
    
    \InintialMsgInjector_0/aux3\ : DFN1C0
      port map(D => \InintialMsgInjector_0/aux3_2\, CLK => 
        RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \InintialMsgInjector_0/aux3_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[3]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[3]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/state[3]\);
    
    \MoM_unit_0/state_RNO_2[5]\ : NOR2B
      port map(A => IRQ1_c_c, B => \MoM_unit_0/state[0]_net_1\, Y
         => \MoM_unit_0/N_328\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[6]\ : 
        DFN1P0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[6]\, 
        CLK => CLK_GATED_c, PRE => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\);
    
    \ZBControl_0/state_RNIMKMG_0[1]\ : NOR2A
      port map(A => \ZBControl_0/N_17\, B => CommandReady2ZB_c, Y
         => IRQ1_c_c);
    
    \uC_commandReady_pad/U0/U1\ : IOIN_IB
      port map(YIN => \uC_commandReady_pad/U0/NET1\, Y => 
        uC_commandReady_c);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNIL8TQ[3]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[3]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_1\);
    
    \md_v4_0/mdiSync\ : DFN1E0C0
      port map(D => \md_v4_0/un2_mdi\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \md_v4_0/N_46\, Q => 
        \md_v4_0/mdiSync_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_RNI0QGE\ : 
        NOR2A
      port map(A => manchesterEncoderComplete_0_TX_Active, B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_encoder_busy_0\);
    
    \RingOscillator_0/AO14_6\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_19_Y\, Y => 
        \RingOscillator_0/AO14_6_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_RNID95C9\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_65_i\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_counte\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_2[3]\ : 
        NOR3C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        B => \manchesterEncoderComplete_0/state[3]\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_64\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNO_0[2]\ : 
        AX1E
      port map(A => \manchesterEncoderComplete_0/cuentaEnvios[1]\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[0]\, C => 
        \manchesterEncoderComplete_0/cuentaEnvios[2]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_45_i\);
    
    \md_v4_0/ctd0\ : DFN1E1C0
      port map(D => \md_v4_0/N_22\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0/ctd0_net_1\);
    
    \MoM_unit_0/commandReceived\ : OR2
      port map(A => uC_commandReady_c, B => 
        command_process_0_newMsg, Y => 
        \MoM_unit_0/commandReceived_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNO[10]\ : XA1B
      port map(A => \MoM_unit_0/aux_timeOut_c9\, B => 
        \MoM_unit_0/aux_timeOut[10]_net_1\, C => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n10\);
    
    \addressingData_0/LSB_NextHopAddress[3]\ : MX2
      port map(A => \addressingData_0.un3_msb_nexthopaddress\, B
         => \addressingData_0_NodeAddress_0[0]\, S => 
        \addressingData_0_NextHopAddress_0[0]\, Y => 
        \addressingData_0_NextHopAddress_0[3]\);
    
    \md_v4_0/fre_ref_0/CEO_RNI09TO\ : AO1A
      port map(A => \md_v4_0/error_type_net_1\, B => bit_error_1, 
        C => \md_v4_0/fre_ref_0/Ref_clk\, Y => 
        \md_v4_0/un1_ref_clk\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNI3UIQ4[0]\ : 
        OR3
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_73\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_72\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[0]\);
    
    \IRQ3_pad/U0/U0\ : IOPAD_TRI_D
      port map(D => \IRQ3_pad/U0/NET1\, E => \IRQ3_pad/U0/NET2\, 
        PAD => IRQ3);
    
    \RingOscillator_0/ringO_cnt_0/DFN1C0_NU_2\ : DFN1C0
      port map(D => \RingOscillator_0/ringO_cnt_0/XOR2_0_Y\, CLK
         => \RingOscillator_0/AO14_15_Y\, CLR => RESETZB_c, Q => 
        \RingOscillator_0/ringO_cnt_0/NU_2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios[1]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_33\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_20\, 
        Q => \manchesterEncoderComplete_0/cuentaEnvios[1]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIN7UC2[3]\ : 
        AO1B
      port map(A => \manchesterEncoderComplete_0/state[3]\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        C => 
        \manchesterEncoderComplete_0/loadEncoder_i_a3_0_a3_0\, Y
         => \manchesterEncoderComplete_0/load_i_1\);
    
    \md_v4_0/mdi1_RNI586R\ : XOR2
      port map(A => \md_v4_0/mdi1_net_1\, B => \md_v4_0.mdi2\, Y
         => \md_v4_0/N_36_i\);
    
    \RingOscillator_0/NAND2_0\ : NAND2
      port map(A => RESETZB_c, B => \RingOscillator_0/AO14_15_Y\, 
        Y => \RingOscillator_0/NAND2_0_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[3]\ : 
        OR3
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_65\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_63\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_64\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[3]\);
    
    \command_process_0/bitCounter_RNI4SJT[2]\ : OR2
      port map(A => \command_process_0/bitCounter[2]_net_1\, B
         => \command_process_0/bitCounter[0]_net_1\, Y => 
        \command_process_0/un2_address_end_0_a2_2_o4_1\);
    
    \command_process_0/msgType[0]\ : DFN1E1C0
      port map(D => \command_process_0/msgType_3[0]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/un10_reg_set_newmessage\, Q => 
        \command_process_0_msgType_0[0]\);
    
    \md_v4_0/fre_ref_0/q_RNO[2]\ : OR2
      port map(A => \md_v4_0/fre_ref_0/q_n2_i_0\, B => 
        \md_v4_0/fre_ref_0/N_11\, Y => \md_v4_0/fre_ref_0/N_8\);
    
    \command_process_0/state[0]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[0]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[0]_net_1\);
    
    \md_v4_0/mdiSync_RNIP6SJ1\ : OR2
      port map(A => \md_v4_0/un14_mdisync_0_0\, B => 
        \md_v4_0/un1_error_happens\, Y => \md_v4_0/un14_mdisync\);
    
    \command_process_0/state_RNO_0[0]\ : NOR2A
      port map(A => \command_process_0/state_ns_i_0_a9_0_0[9]\, B
         => \command_process_0/N_67\, Y => 
        \command_process_0/N_126\);
    
    \MoM_unit_0/state_RNO_3[4]\ : NOR3B
      port map(A => \MoM_unit_0/N_78\, B => 
        \MoM_unit_0/un19_commandreceived\, C => 
        \MoM_unit_0/state[6]_net_1\, Y => \MoM_unit_0/N_113\);
    
    \InintialMsgInjector_0/aux2_RNO\ : NOR2A
      port map(A => \InintialMsgInjector_0/aux1_net_1\, B => 
        \InintialMsgInjector_0/aux5_net_1\, Y => 
        \InintialMsgInjector_0/aux2_2\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/Gate_For_Clock_Gating\ : 
        AND2
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_two\, 
        B => RingOscillator_0_CLK_OUT, Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/clock_to_user_logic_temp\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[2]\ : 
        AOI1
      port map(A => \manchesterEncoderComplete_0/state[3]\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_38\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_66\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNIONC25\ : 
        AO1C
      port map(A => \manchesterEncoderComplete_0/load_i_1\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy\, 
        C => manchesterEncoderComplete_0_TX_Active, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_encoder_busy_1\);
    
    \MoM_unit_0/aux_timeOut_RNO[8]\ : NOR2
      port map(A => \MoM_unit_0/N_91_i\, B => \MoM_unit_0/N_85\, 
        Y => \MoM_unit_0/N_38\);
    
    \command_process_0/reg_command_error_RNO_0\ : XA1
      port map(A => \command_process_0/commandRX[0]_net_1\, B => 
        \command_process_0/commandRX[2]_net_1\, C => 
        \command_process_0/N_167\, Y => \command_process_0/N_118\);
    
    \command_process_0/state_RNO_0[8]\ : MX2A
      port map(A => \command_process_0/state[8]_net_1\, B => 
        \command_process_0/N_62\, S => md_v4_0_new_data, Y => 
        \command_process_0/N_102\);
    
    \MoM_unit_0/NACKCnt_RNIVPKV[1]\ : NOR2A
      port map(A => \MoM_unit_0/NACKCnt[1]_net_1\, B => 
        \MoM_unit_0/NACKCnt[0]_net_1\, Y => \MoM_unit_0/N_116_1\);
    
    \command_process_0/commandRX[1]\ : DFN0E1C0
      port map(D => \command_process_0/commandRX_3[1]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_5\, Q => 
        \command_process_0/commandRX[1]_net_1\);
    
    \command_process_0/reg_command_error_RNIVCKM1\ : NOR2B
      port map(A => \command_process_0/bitCounterlde_0_a9_1_0\, B
         => \command_process_0.N_150\, Y => 
        \command_process_0/bitCounterlde_0_a9_1_1\);
    
    \MoM_unit_0/Contention_int_RNO[0]\ : NOR2A
      port map(A => \MoM_unit_0/N_120\, B => 
        \MoM_unit_0/Contention_int[0]_net_1\, Y => 
        \MoM_unit_0/N_22\);
    
    \MoM_unit_0/Contention_int[6]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_16\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[6]_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNO[7]\ : NOR2
      port map(A => \MoM_unit_0/aux_timeOut_n7_i_1\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/N_36\);
    
    \RingOscillator_0/ringO_cnt_0/INV_2\ : INV
      port map(A => \RingOscillator_0/ringO_cnt_0/NU_1\, Y => 
        \RingOscillator_0/ringO_cnt_0/INV_2_Y\);
    
    \command_process_0/bitCounter_RNO[2]\ : NOR3
      port map(A => \command_process_0.N_148\, B => 
        \command_process_0/un1_commProc_busy_1_0_0_0\, C => 
        \command_process_0/bitCounter_n2_i_0\, Y => 
        \command_process_0/N_39\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI7KOV2[6]\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_83\, 
        B => \addressingData_0_NextHopAddress_0[0]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_72\);
    
    \command_process_0/state_RNO_1[0]\ : OA1C
      port map(A => md_v4_0_new_data, B => 
        \command_process_0/N_80\, C => 
        \command_process_0/state[0]_net_1\, Y => 
        \command_process_0/N_125\);
    
    AFLSDF_INV_0 : INV
      port map(A => RingOscillator_0_CLK_OUT, Y => \AFLSDF_INV_0\);
    
    \command_process_0/addOK_reg_RNO_1\ : XO1
      port map(A => \command_process_0/addressRX[0]_net_1\, B => 
        \addressingData_0_NodeAddress_0[0]\, C => 
        \command_process_0/N_88_i\, Y => 
        \command_process_0/addok_NE_0_2\);
    
    \command_process_0/ParityRX\ : DFN1E1P0
      port map(D => \command_process_0/ParityRX_2\, CLK => 
        CLK_GATED_c, PRE => RESETZB_c, E => 
        \command_process_0/N_14\, Q => 
        \command_process_0/ParityRX_net_1\);
    
    \MoM_unit_0/aux_timeOut[9]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n9\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[9]_net_1\);
    
    \command_process_0/state_RNI85O91[9]\ : AOI1
      port map(A => md_v4_0_new_data, B => 
        \command_process_0.state[9]\, C => 
        \command_process_0.N_76\, Y => 
        \command_process_0/bitCounterlde_0_o2_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0[4]\ : 
        NOR2B
      port map(A => \selAdd_c[2]\, B => 
        \addressingData_0_NextHopAddress_0[0]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_0_a3_0[4]_net_1\);
    
    \command_process_0/commandRX_RNO[1]\ : NOR3A
      port map(A => \command_process_0/commandRX[0]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/commandRX_3[1]\);
    
    \MoM_unit_0/Contention_int_RNIRSU9[6]\ : NOR2B
      port map(A => \MoM_unit_0/Contention_int[5]_net_1\, B => 
        \MoM_unit_0/Contention_int[6]_net_1\, Y => 
        \MoM_unit_0/un2_contentiontimeexpired_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/active_bit_RNIL0GI\ : 
        XA1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/active_bit_net_1\, 
        C => manchesterEncoderComplete_0_TX_Active, Y => TX_c);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/Gate_For_Clock_Gating_Clkint\ : 
        CLKINT
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/clock_to_user_logic_temp\, 
        Y => CLK_GATED_c);
    
    \MoM_unit_0/state_RNO_1[4]\ : MX2B
      port map(A => \MoM_unit_0/N_116_1\, B => 
        \MoM_unit_0/un26_commandreceived\, S => \MoM_unit_0/N_76\, 
        Y => \MoM_unit_0/N_301_tz\);
    
    \md_v4_0/dataFiltered_RNO\ : NOR3B
      port map(A => md_v4_0_RX_end, B => \md_v4_0/N_36_i\, C => 
        \md_v4_0/N_43\, Y => \md_v4_0/N_24\);
    
    \MoM_unit_0/aux_timeOut[11]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n11\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[11]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[4]_net_1\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\);
    
    \MoM_unit_0/state_RNO_8[5]\ : NOR2B
      port map(A => \MoM_unit_0/aux_timeOut[4]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[6]_net_1\, Y => 
        \MoM_unit_0/state_tr1_1\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[2]\ : 
        DFN1C0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[3]\, 
        CLK => RingOscillator_0_CLK_OUT, CLR => RESETZB_c, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[2]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg\ : 
        DFN1E0C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/N_243\, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_net_1\);
    
    \NWKrRouteTimeout_pad/U0/U0\ : IOPAD_IN_D
      port map(PAD => NWKrRouteTimeout, Y => 
        \NWKrRouteTimeout_pad/U0/NET1\);
    
    \command_process_0/state_RNO_0[3]\ : MX2C
      port map(A => \command_process_0/state[3]_net_1\, B => 
        \command_process_0/state[4]_net_1\, S => md_v4_0_new_data, 
        Y => \command_process_0/N_97\);
    
    \MoM_unit_0/aux_timeOut_RNIHL9Q1[6]\ : OR2A
      port map(A => \MoM_unit_0/aux_timeOut[6]_net_1\, B => 
        \MoM_unit_0/N_63\, Y => \MoM_unit_0/N_64\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios[0]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_77\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_20\, 
        Q => \manchesterEncoderComplete_0/cuentaEnvios[0]\);
    
    \LowPowerManagement_0/FlashFreeze_Inbuf/U0/U0\ : IOPAD_IN
      port map(PAD => Wakeup, Y => 
        \LowPowerManagement_0/FlashFreeze_Inbuf/U0/NET1\);
    
    \MoM_unit_0/aux_timeOut_RNO[6]\ : NOR2A
      port map(A => \MoM_unit_0/aux_timeOut_n6_tz\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n6\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/Latch_For_Clock_Gating\ : 
        DLN0
      port map(D => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_one\, 
        G => RingOscillator_0_CLK_OUT, Q => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/Primary_Filter_Instance/stop_stage_two\);
    
    \MoM_unit_0/Contention_int[4]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_12\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[4]_net_1\);
    
    \command_process_0/state_RNID78V[9]\ : OAI1
      port map(A => \command_process_0.N_76\, B => 
        \command_process_0.state[9]\, C => \md_v4_0.mdi2\, Y => 
        \command_process_0/N_59\);
    
    \command_process_0/reg_set_newMessage_RNIQSMQ2\ : OR2
      port map(A => \command_process_0/N_134\, B => 
        MoM_unit_0_RX_processed, Y => 
        \command_process_0/un10_reg_set_newmessage\);
    
    \MoM_unit_0/aux_timeOut_RNIMEEF[11]\ : OR2A
      port map(A => \MoM_unit_0/aux_timeOut[11]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[2]_net_1\, Y => 
        \MoM_unit_0/un13_timeoutack_0_o2_1\);
    
    OR2_0 : OR2
      port map(A => InintialMsgInjector_0_NewMsgInjector, B => 
        uC_commandReady_c, Y => AddOKflag_c);
    
    \Decoder_hk_pad/U0/U0\ : IOPAD_TRI
      port map(D => \Decoder_hk_pad/U0/NET1\, E => 
        \Decoder_hk_pad/U0/NET2\, PAD => Decoder_hk);
    
    \command_process_0/state[5]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[5]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[5]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNIVF4I5[2]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty\, 
        B => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un10_load\);
    
    \MoM_unit_0/un1_NACKCnt_I_10\ : XOR2
      port map(A => \MoM_unit_0/NACKCnt[1]_net_1\, B => 
        \MoM_unit_0/DWACT_ADD_CI_0_TMP[0]\, Y => 
        \MoM_unit_0/un1_NACKCnt[0]\);
    
    \MoM_unit_0/state_RNI5EA[5]\ : NOR2A
      port map(A => MoM_unit_0_d_hk, B => \MoM_unit_0.state[4]\, 
        Y => \MoM_unit_0/RX_processed_0_a2_0_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_1\ : 
        AND2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_1_sqmuxa\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_TMP[0]\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[7]\ : 
        MX2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[6]_net_1\, 
        B => \manchesterEncoderComplete_0/N_6\, S => 
        \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[7]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parity_flag_RNO\ : 
        OR2B
      port map(A => \manchesterEncoderComplete_0/N_243\, B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un21_symbol_t\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un3_load\);
    
    \RingOscillator_0/AO14_21\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_20_Y\, Y => 
        \RingOscillator_0/AO14_21_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNI0TUM7\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un6_bit_end\, 
        B => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un8_bit_end\);
    
    \RingOscillator_0/AO14_11\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_10_Y\, Y => 
        \RingOscillator_0/AO14_11_Y\);
    
    \command_process_0/reg_short_command_RNIVBC65\ : AO1A
      port map(A => \command_process_0/N_69\, B => 
        \command_process_0/un1_commProc_busy_1_0_a9_0\, C => 
        \command_process_0.N_108\, Y => 
        \command_process_0/un1_commProc_busy_1_0_0_0\);
    
    \MoM_unit_0/NACKCnt_RNIVO6K5[1]\ : NOR2B
      port map(A => \MoM_unit_0/N_116_1\, B => 
        \MoM_unit_0/un17_waitingackenab\, Y => \MoM_unit_0/N_119\);
    
    \MoM_unit_0/aux_timeOut_RNI5N4T[2]\ : OR2B
      port map(A => \MoM_unit_0/aux_timeOut[2]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[1]_net_1\, Y => \MoM_unit_0/N_65\);
    
    \RingOscillator_0/ringO_cnt_0/U_AND3_0_1_2\ : AND3
      port map(A => \RingOscillator_0/ringO_cnt_0/NU_0\, B => 
        \RingOscillator_0/ringO_cnt_0/NU_1\, C => 
        \RingOscillator_0/ringO_cnt_0/NU_2\, Y => 
        \RingOscillator_0/ringO_cnt_0/NU_0_1_2\);
    
    \md_v4_0/mdiSync_RNIJ3P91\ : OR2A
      port map(A => \md_v4_0/mdiSync_net_1\, B => 
        \md_v4_0/N_36_i\, Y => \md_v4_0/un14_mdisync_0_0\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNI7H4N[2]\ : 
        NOR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[2]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65_1\);
    
    \command_process_0/state[8]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[8]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[8]_net_1\);
    
    \command_process_0/addressRX[7]\ : DFN0E1C0
      port map(D => \command_process_0/addressRX_3[7]\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/N_10\, Q => 
        \command_process_0/addressRX[7]_net_1\);
    
    \MoM_unit_0/state_RNO_3[5]\ : NOR3B
      port map(A => \MoM_unit_0/aux_timeOut[0]_net_1\, B => 
        \MoM_unit_0/state_tr1_6\, C => 
        \MoM_unit_0/aux_timeOut[5]_net_1\, Y => 
        \MoM_unit_0/state_tr1_10\);
    
    \RingOscillator_0/AO14_8\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_7_Y\, Y => 
        \RingOscillator_0/AO14_8_Y\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_2[5]\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_59\);
    
    \command_process_0/state_RNIDRKV1[0]\ : NOR2B
      port map(A => \command_process_0/state[0]_net_1\, B => 
        \command_process_0/N_67\, Y => \command_process_0/N_149\);
    
    \MoM_unit_0/aux_timeOut_RNI3HS82[7]\ : OR3
      port map(A => \MoM_unit_0/aux_timeOut[5]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[7]_net_1\, C => 
        \MoM_unit_0/un13_timeoutack_0_o2_2\, Y => 
        \MoM_unit_0/un13_timeoutack_0_o2_4\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_RNO\ : 
        NOR2A
      port map(A => manchesterEncoderComplete_0_TX_Active, B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/manchesterRef_3\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[4]\ : AX1B
      port map(A => \MoM_unit_0/N_65\, B => \MoM_unit_0/N_62\, C
         => \MoM_unit_0/aux_timeOut[4]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_n4_tz\);
    
    \MoM_unit_0/Contention_int_RNITIR21[1]\ : NOR3C
      port map(A => \MoM_unit_0/un2_contentiontimeexpired_2\, B
         => \MoM_unit_0/un2_contentiontimeexpired_1\, C => 
        \MoM_unit_0/un2_contentiontimeexpired_3\, Y => 
        \MoM_unit_0.un2_contentiontimeexpired\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNILLTD1[4]\ : 
        OA1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvioslde_i_i_o2_0\, 
        C => \manchesterEncoderComplete_0/state[3]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_70\);
    
    \MoM_unit_0/Contention_int_RNI69TJ[3]\ : OR2A
      port map(A => \MoM_unit_0/Contention_int[3]_net_1\, B => 
        \MoM_unit_0/N_18\, Y => \MoM_unit_0/N_352\);
    
    \command_process_0/newMessage_RNIASB1\ : NOR3B
      port map(A => CommandReady2ZB_c, B => 
        command_process_0_newMsg, C => \MoM_unit_0.state[4]\, Y
         => \command_process_0/N_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI7NUM[0]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\);
    
    \command_process_0/commandRX_RNIQG88[3]\ : NOR2A
      port map(A => \command_process_0/commandRX[3]_net_1\, B => 
        \command_process_0/commandRX[1]_net_1\, Y => 
        \command_process_0/N_167\);
    
    \ZBControl_0/state_RNI4TAI[1]\ : OA1B
      port map(A => R2SINKTimeout_c, B => NWKrRouteTimeout_c, C
         => \ZBControl_0/state_i_0[1]\, Y => \ZBControl_0.N_4\);
    
    \MoM_unit_0/Contention_int_RNIBTTE[2]\ : OR2A
      port map(A => \MoM_unit_0/Contention_int[2]_net_1\, B => 
        \MoM_unit_0/N_351\, Y => \MoM_unit_0/N_18\);
    
    \MoM_unit_0/command2send_RNI86D9[0]\ : INV
      port map(A => CommandType2ZB_c, Y => CommandType2ZB_c_i);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[1]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[2]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send[0]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns_i_i_a3_0_0[5]\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[12]\ : NOR2B
      port map(A => \MoM_unit_0/aux_timeOut[11]_net_1\, B => 
        \MoM_unit_0/aux_timeOut_c10\, Y => 
        \MoM_unit_0/aux_timeOut_58_0\);
    
    \RingOscillator_0/ringO_cnt_0/XOR2_0\ : XOR2
      port map(A => \RingOscillator_0/ringO_cnt_0/NU_2\, B => 
        \RingOscillator_0/ringO_cnt_0/AND2_0_Y\, Y => 
        \RingOscillator_0/ringO_cnt_0/XOR2_0_Y\);
    
    \md_v4_0/fre_ref_0/q[1]\ : DFN1C0
      port map(D => \md_v4_0/fre_ref_0/N_6\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, Q => \md_v4_0/fre_ref_0/q[1]_net_1\);
    
    \ZBControl_0/state[1]\ : DFN1P0
      port map(D => \ZBControl_0/N_8\, CLK => CLK_GATED_c, PRE
         => RESETZB_c, Q => \ZBControl_0/state_i_0[1]\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[6]\ : AX1C
      port map(A => \MoM_unit_0/aux_timeOut_c4\, B => 
        \MoM_unit_0/aux_timeOut[5]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[6]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_n6_tz\);
    
    \housekeepingCheck_0/Result\ : OA1
      port map(A => \command_process_0.N_108\, B => 
        \command_process_0.N_148\, C => 
        \housekeepingCheck_0.Result_5\, Y => LedMochila_c);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_30\ : 
        NOR2B
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_2[0]\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[4]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_g_array_12_1[0]\);
    
    \addressingData_0/LSB_NodeAddress_i_a2[3]\ : NOR2A
      port map(A => \selAdd_c[1]\, B => \selAdd_c[0]\, Y => 
        \addressingData_0.un6_msb_nexthopaddress_2\);
    
    \MoM_unit_0/command2ZB_proc.un7_commandreceived_i_a2_0\ : 
        NOR2A
      port map(A => command_process_0_newMsg, B => 
        \MoM_unit_0/un4_commandreceived\, Y => \MoM_unit_0/N_123\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_RNO\ : 
        XNOR3
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_3\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_2\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_4\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux\);
    
    \MoM_unit_0/state_RNI9RGV1[4]\ : NOR2A
      port map(A => \MoM_unit_0/un12_contentionenab_0_a2_0\, B
         => \MoM_unit_0/N_77\, Y => 
        \MoM_unit_0/un12_contentionenab\);
    
    \md_v4_0/error_type_RNO\ : NOR2B
      port map(A => \md_v4_0/mdiSync_net_1\, B => 
        \md_v4_0/un1_error_happens\, Y => \md_v4_0/error_type_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/command2send_RNIE5FL5[1]\ : 
        OR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_52\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/dout_i_0[3]\, 
        Y => \manchesterEncoderComplete_0/N_27\);
    
    \MoM_unit_0/command2ZB_proc.un7_commandreceived_i_o2\ : AO1C
      port map(A => AddOKflag_0, B => \MoM_unit_0/N_123\, C => 
        \MoM_unit_0/commandReceived_net_1\, Y => 
        \MoM_unit_0/N_60\);
    
    \md_v4_0/error_counter_RNO_0[3]\ : AX1A
      port map(A => \md_v4_0/N_37\, B => 
        \md_v4_0/error_counter[2]_net_1\, C => 
        \md_v4_0/error_counter[3]_net_1\, Y => \md_v4_0/N_40_i\);
    
    \MoM_unit_0/state_RNO_1[2]\ : NOR3B
      port map(A => \MoM_unit_0/un3_tx_active_0\, B => 
        \MoM_unit_0/N_107_1\, C => CommandType2ZB_c, Y => 
        \MoM_unit_0/N_107\);
    
    \MoM_unit_0/state_RNO[3]\ : NOR2A
      port map(A => manchesterEncoderComplete_0_TX_Active, B => 
        \MoM_unit_0/N_121\, Y => \MoM_unit_0/N_323\);
    
    \MoM_unit_0/aux_timeOut[3]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n3\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[3]_net_1\);
    
    \md_v4_0/error_counter[1]\ : DFN0E1C0
      port map(D => \md_v4_0/N_31\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/error_countere\, Q => 
        \md_v4_0/error_counter[1]_net_1\);
    
    \CLK_GATED_pad/U0/U0\ : IOPAD_TRI
      port map(D => \CLK_GATED_pad/U0/NET1\, E => 
        \CLK_GATED_pad/U0/NET2\, PAD => CLK_GATED);
    
    \MoM_unit_0/Contention_counter.un11_tx_active_i_a2\ : NOR2
      port map(A => RX_c_c, B => 
        manchesterEncoderComplete_0_TX_Active, Y => 
        \MoM_unit_0/N_120\);
    
    \ZBControl_0/commandTypeIN_RNIIKIE\ : MX2
      port map(A => R2SINKTimeout_c, B => NWKrRouteTimeout_c, S
         => \ZBControl_0/commandTypeIN_net_1\, Y => 
        \ZBControl_0/N_9\);
    
    \MoM_unit_0/Contention_int_RNIHIU9[1]\ : OR2B
      port map(A => \MoM_unit_0/Contention_int[1]_net_1\, B => 
        \MoM_unit_0/Contention_int[0]_net_1\, Y => 
        \MoM_unit_0/N_351\);
    
    \MoM_unit_0/state_RNIO61J1[4]\ : AO1C
      port map(A => \MoM_unit_0.state[4]\, B => \MoM_unit_0/N_86\, 
        C => \MoM_unit_0/N_77\, Y => \MoM_unit_0.N_17\);
    
    \MoM_unit_0/aux_timeOut_RNISJ6H[12]\ : OR3A
      port map(A => \MoM_unit_0/aux_timeOut[12]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[10]_net_1\, C => 
        \MoM_unit_0/un13_timeoutack_0_o2_1\, Y => 
        \MoM_unit_0/un13_timeoutack_0_o2_3\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/rsr_RNO[6]\ : 
        MX2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        S => \manchesterEncoderComplete_0/load_i_1\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr_4[6]\);
    
    \md_v4_0/fre_ref_0/q_RNILJUB[1]\ : NOR3
      port map(A => \md_v4_0/fre_ref_0/q_i_0[0]\, B => 
        \md_v4_0/fre_ref_0/q_i_0[2]\, C => 
        \md_v4_0/fre_ref_0/q[1]_net_1\, Y => 
        \md_v4_0/fre_ref_0/N_28\);
    
    \MoM_unit_0/aux_timeOut[2]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n2\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[2]_net_1\);
    
    \LedMochila_pad/U0/U0\ : IOPAD_TRI
      port map(D => \LedMochila_pad/U0/NET1\, E => 
        \LedMochila_pad/U0/NET2\, PAD => LedMochila);
    
    \manchesterEncoderComplete_0/AND2_0\ : NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        B => manchesterEncoderComplete_0_TX_Active, Y => 
        Encoder_hk);
    
    \MoM_unit_0/aux_timeOut_RNO[9]\ : XA1B
      port map(A => \MoM_unit_0/aux_timeOut[9]_net_1\, B => 
        \MoM_unit_0/aux_timeOut_c8\, C => \MoM_unit_0/N_85\, Y
         => \MoM_unit_0/aux_timeOut_n9\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_22\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\);
    
    \MoM_unit_0/state_RNIDAF[0]\ : NOR3
      port map(A => CommandReady2ZB_c, B => 
        \MoM_unit_0/state[0]_net_1\, C => 
        \MoM_unit_0/state[2]_net_1\, Y => \MoMstateLed_c[1]\);
    
    \command_process_0/bitCounter_RNO[0]\ : NOR3
      port map(A => \command_process_0.N_148\, B => 
        \command_process_0/un1_commProc_busy_1_0_0_0\, C => 
        \command_process_0/bitCounter[0]_net_1\, Y => 
        \command_process_0/N_127\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNI4TLV8[2]\ : 
        OR3
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_0\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_a6_net_1\, 
        C => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_b0_0_2_net_1\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNI2D5J1[4]\ : 
        OA1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_39\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_88\);
    
    \command_process_0/state[7]\ : DFN1C0
      port map(D => \command_process_0/state_RNO[7]_net_1\, CLK
         => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \command_process_0/state[7]_net_1\);
    
    \command_process_0/addOK_reg_RNO_4\ : XOR2
      port map(A => \command_process_0/addressRX[4]_net_1\, B => 
        \selAdd_c[2]\, Y => \command_process_0/N_88_i\);
    
    \RingOscillator_0/AO14_4\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_3_Y\, Y => 
        \RingOscillator_0/AO14_4_Y\);
    
    \MoM_unit_0/Contention_int_RNO[2]\ : XA1A
      port map(A => \MoM_unit_0/Contention_int[2]_net_1\, B => 
        \MoM_unit_0/N_351\, C => \MoM_unit_0/N_120\, Y => 
        \MoM_unit_0/N_8\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/parityBit_reg_RNO_3\ : 
        XNOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\, 
        B => \manchesterEncoderComplete_0/N_6\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un27_paritybit_aux_0\);
    
    \Decoder_hk_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => \GND\, E => \VCC\, DOUT => 
        \Decoder_hk_pad/U0/NET1\, EOUT => 
        \Decoder_hk_pad/U0/NET2\);
    
    \command_process_0/addressRX_RNO[4]\ : NOR3A
      port map(A => \command_process_0/addressRX[3]_net_1\, B => 
        \command_process_0/N_2_0\, C => 
        \command_process_0/un2_dataclean_1_i_o9_0_1\, Y => 
        \command_process_0/addressRX_3[4]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_symbol_t_I_21\ : 
        XOR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[1]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/DWACT_ADD_CI_0_TMP[0]\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/I_21\);
    
    \MoM_unit_0/state[2]\ : DFN1E1C0
      port map(D => \MoM_unit_0/state_ns[4]\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => RESETZB_c, Q => 
        \MoM_unit_0/state[2]_net_1\);
    
    \MoM_unit_0/state_RNI0VHK4_0[2]\ : NOR2A
      port map(A => \MoM_unit_0/state[2]_net_1\, B => 
        \MoM_unit_0/N_76\, Y => \MoM_unit_0/un17_waitingackenab\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNI76C56\ : 
        AO1
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_65_i\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_load\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un2_load_1\);
    
    \md_v4_0/mdi2\ : DFN0E1C0
      port map(D => \md_v4_0/mdi2_2\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0.mdi2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNO_0\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/continueFlag_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un1_last_bit_sent_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/encoder_busy_RNIV3LH2\ : 
        NOR2A
      port map(A => \manchesterEncoderComplete_0/load_i_1\, B => 
        manchesterEncoderComplete_0_TX_Active, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un19_load\);
    
    \md_v4_0/error_counter_RNIHF15_0[1]\ : NOR2
      port map(A => \md_v4_0/error_counter[1]_net_1\, B => 
        \md_v4_0/error_counter[0]_net_1\, Y => \md_v4_0/N_59\);
    
    \MoM_unit_0/state_RNO_4[5]\ : NOR3B
      port map(A => \MoM_unit_0/aux_timeOut[11]_net_1\, B => 
        \MoM_unit_0/state_tr1_4\, C => 
        \MoM_unit_0/aux_timeOut[10]_net_1\, Y => 
        \MoM_unit_0/state_tr1_9\);
    
    
        \command_process_0/command_flags_gen.reg_command_error_2_i_o4\ : 
        OR3A
      port map(A => \md_v4_0.newDataEdgeAux\, B => 
        \md_v4_0.dataFiltered\, C => bit_error_1, Y => 
        \command_process_0/N_69\);
    
    \MoM_unit_0/Contention_int[2]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_8\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[2]_net_1\);
    
    \CLK_GATED_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => CLK_GATED_c, E => \VCC\, DOUT => 
        \CLK_GATED_pad/U0/NET1\, EOUT => \CLK_GATED_pad/U0/NET2\);
    
    \command_process_0/state_RNIURHL5[1]\ : OA1
      port map(A => \command_process_0/N_184\, B => 
        \command_process_0/N_146\, C => \command_process_0.N_150\, 
        Y => \command_process_0.N_148\);
    
    \command_process_0/addOK_reg_RNO_2\ : XO1A
      port map(A => \command_process_0/addressRX[3]_net_1\, B => 
        \addressingData_0.un6_msb_nexthopaddress_2\, C => 
        \command_process_0/addok_NE_0_1\, Y => 
        \command_process_0/addok_NE_0_4\);
    
    \ZBControl_0/state_RNIMKMG[1]\ : NOR2B
      port map(A => \ZBControl_0/N_17\, B => CommandReady2ZB_c, Y
         => \ZBControl_0/N_14\);
    
    \MoM_unit_0/command2send_RNO[1]\ : NOR2B
      port map(A => \command_process_0_msgType_0[1]\, B => 
        command_process_0_newMsg, Y => 
        \MoM_unit_0/commandType[1]\);
    
    \command_process_0/bitCounter_RNO[3]\ : NOR3
      port map(A => \command_process_0.N_148\, B => 
        \command_process_0/un1_commProc_busy_1_0_0_0\, C => 
        \command_process_0/N_90_i\, Y => \command_process_0/N_41\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]\ : 
        DFN1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_ns[1]\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, Q => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]_net_1\);
    
    \command_process_0/bitCounter[1]\ : DFN1E1C0
      port map(D => \command_process_0/N_37\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, E => \command_process_0/bitCountere\, Q
         => \command_process_0/bitCounter[1]_net_1\);
    
    \md_v4_0/newDataEdgeAux_RNO\ : NOR2B
      port map(A => \md_v4_0.dataFiltered\, B => md_v4_0_RX_end, 
        Y => \md_v4_0/newDataEdgeAux_2\);
    
    \md_v4_0/mdi1\ : DFN0E1C0
      port map(D => \md_v4_0/N_16\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \md_v4_0/un1_ref_clk\, Q => 
        \md_v4_0/mdi1_net_1\);
    
    \IRQ1_pad/U0/U0\ : IOPAD_TRI_U
      port map(D => \IRQ1_pad/U0/NET1\, E => \IRQ1_pad/U0/NET2\, 
        PAD => IRQ1);
    
    \md_v4_0/fre_ref_0/q[2]\ : DFN1P0
      port map(D => \md_v4_0/fre_ref_0/N_8\, CLK => CLK_GATED_c, 
        PRE => RESETZB_c, Q => \md_v4_0/fre_ref_0/q_i_0[2]\);
    
    \MoM_unit_0/state_RNO[2]\ : AO1A
      port map(A => \MoM_unit_0/state_ns_0_0_o2_1[4]\, B => 
        \MoM_unit_0/N_76\, C => \MoM_unit_0/N_107\, Y => 
        \MoM_unit_0/state_ns[4]\);
    
    \md_v4_0/fre_ref_0/q[3]\ : DFN1C0
      port map(D => \md_v4_0/fre_ref_0/N_10\, CLK => CLK_GATED_c, 
        CLR => RESETZB_c, Q => \md_v4_0/fre_ref_0/q[3]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNO_0[2]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_7_0\);
    
    \housekeepingCheck_0/Result_5\ : NOR2B
      port map(A => \housekeepingCheck_0/Result_5_4_net_1\, B => 
        IRQ1_c_c, Y => \housekeepingCheck_0.Result_5\);
    
    \MoM_unit_0/state[3]\ : DFN1E1C0
      port map(D => \MoM_unit_0/N_323\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, E => RESETZB_c, Q => 
        \MoM_unit_0/state[3]_net_1\);
    
    \command_process_0/bitCounter_RNI6UJT[3]\ : OR2A
      port map(A => \command_process_0/bitCounter[3]_net_1\, B
         => \command_process_0/bitCounter[1]_net_1\, Y => 
        \command_process_0/un2_address_end_0_a2_2_o4_0\);
    
    \NWKrRouteTimeout_pad/U0/U1\ : IOIN_IB
      port map(YIN => \NWKrRouteTimeout_pad/U0/NET1\, Y => 
        NWKrRouteTimeout_c);
    
    \BIBUF_0/U0/U0\ : IOPAD_BI
      port map(D => \BIBUF_0/U0/NET1\, E => \BIBUF_0/U0/NET2\, Y
         => \BIBUF_0/U0/NET3\, PAD => CTRL1);
    
    \MoM_unit_0/Contention_int[1]\ : DFN1E0C0
      port map(D => \MoM_unit_0/N_6\, CLK => CLK_GATED_c, CLR => 
        RESETZB_c, E => \MoM_unit_0/N_21\, Q => 
        \MoM_unit_0/Contention_int[1]_net_1\);
    
    \ZBControl_0/state_RNI7HHG[1]\ : NOR2A
      port map(A => \ZBControl_0/state_i_0[1]\, B => 
        \ZBControl_0/state[0]_net_1\, Y => \ZBControl_0/N_17\);
    
    \MoM_unit_0/aux_timeOut[0]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n0\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[0]_net_1\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/N_117\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_counte\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]_net_1\);
    
    \MoM_unit_0/aux_timeOut[8]\ : DFN1C0
      port map(D => \MoM_unit_0/N_38\, CLK => CLK_GATED_c, CLR
         => RESETZB_c, Q => \MoM_unit_0/aux_timeOut[8]_net_1\);
    
    \MoM_unit_0/aux_timeOut[6]\ : DFN1C0
      port map(D => \MoM_unit_0/aux_timeOut_n6\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, Q => 
        \MoM_unit_0/aux_timeOut[6]_net_1\);
    
    \command_process_0/ParityRX_RNO\ : OR3
      port map(A => \command_process_0.N_108\, B => 
        \command_process_0.N_148\, C => 
        \command_process_0/ParityRX_2_0_0\, Y => 
        \command_process_0/ParityRX_2\);
    
    \MoM_unit_0/NACKCnt_RNO[1]\ : NOR3A
      port map(A => \MoM_unit_0/un1_NACKCnt[0]\, B => 
        \MoM_unit_0/N_119\, C => \MoM_unit_0/NACKCnt_5_i_1_0[1]\, 
        Y => \MoM_unit_0/N_13\);
    
    \IRQ3_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => IRQ3_c, E => \VCC\, DOUT => 
        \IRQ3_pad/U0/NET1\, EOUT => \IRQ3_pad/U0/NET2\);
    
    \MoM_unit_0/aux_timeOut_RNO[0]\ : NOR2
      port map(A => \MoM_unit_0/aux_timeOut[0]_net_1\, B => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIEI664[0]\ : 
        OAI1
      port map(A => \addressingData_0_NextHopAddress_0[0]\, B => 
        \addressingData_0.un3_msb_nexthopaddress\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_36\, 
        Y => \manchesterEncoderComplete_0/N_6\);
    
    \RingOscillator_0/AO14_15\ : AO14
      port map(A => \GND\, B => \GND\, C => 
        \RingOscillator_0/AO14_14_Y\, Y => 
        \RingOscillator_0/AO14_15_Y\);
    
    \MoM_unit_0/state_RNO_6[5]\ : NOR3B
      port map(A => \MoM_unit_0/aux_timeOut[3]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[12]_net_1\, C => 
        \MoM_unit_0/NACKCnt[0]_net_1\, Y => 
        \MoM_unit_0/state_tr1_6\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[4]\ : 
        NOR2B
      port map(A => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state[5]_net_1\, 
        B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/Flash_Freeze_reg_i_0\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[1]\);
    
    \command_process_0/AddOKflag\ : DFN1E1C0
      port map(D => \command_process_0/AddOKflag_2\, CLK => 
        CLK_GATED_c, CLR => RESETZB_c, E => 
        \command_process_0/un10_reg_set_newmessage\, Q => 
        AddOKflag_0);
    
    \TX_pad/U0/U1\ : IOTRI_OB_EB
      port map(D => TX_c, E => \VCC\, DOUT => \TX_pad/U0/NET1\, 
        EOUT => \TX_pad/U0/NET2\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count_RNI2VTC[2]\ : 
        NOR3A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[0]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[1]_net_1\, 
        C => 
        \manchesterEncoderComplete_0/manchester_encoder_0/bit_count[2]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/TXBufferEmpty_1\);
    
    \manchesterEncoderComplete_0/manchester_encoder_0/active_bit\ : 
        DFN1E1C0
      port map(D => 
        \manchesterEncoderComplete_0/manchester_encoder_0/rsr[7]_net_1\, 
        CLK => CLK_GATED_c, CLR => RESETZB_c, E => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un6_bit_end\, 
        Q => 
        \manchesterEncoderComplete_0/manchester_encoder_0/active_bit_net_1\);
    
    \MoM_unit_0/aux_timeOut_RNO[12]\ : XA1B
      port map(A => \MoM_unit_0/aux_timeOut_58_0\, B => 
        \MoM_unit_0/aux_timeOut[12]_net_1\, C => 
        \MoM_unit_0/N_85\, Y => \MoM_unit_0/aux_timeOut_n12\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO[6]\ : 
        OA1C
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk\, 
        B => \MoM_unit_0.N_17\, C => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/N_57\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNO_0[6]\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t_RNIL8TQ[5]\ : 
        NOR2A
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_0/symbol_t[2]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_0/un9_encoder_busy_0\);
    
    \command_process_0/bitCounter_RNO_0[1]\ : XNOR2
      port map(A => \command_process_0/bitCounter[0]_net_1\, B
         => \command_process_0/bitCounter[1]_net_1\, Y => 
        \command_process_0/bitCounter_n1_i_0\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state_RNIFVUM[5]\ : 
        OR2
      port map(A => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[5]_net_1\, 
        B => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/state[4]_net_1\, 
        Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout[6]\);
    
    \command_process_0/state_RNI04PK3[2]\ : AO1A
      port map(A => \command_process_0/N_69\, B => 
        \command_process_0/state[2]_net_1\, C => 
        MoM_unit_0_RX_processed, Y => 
        \command_process_0/un1_dataclean\);
    
    \MoM_unit_0/state_RNO[0]\ : OA1B
      port map(A => CommandReady2ZB_c, B => 
        \MoM_unit_0/state[0]_net_1\, C => IRQ1_c_c, Y => 
        \MoM_unit_0/N_327\);
    
    \md_v4_0/fre_ref_0/q_RNO[1]\ : NOR2
      port map(A => \md_v4_0/fre_ref_0/q_n1_i_0\, B => 
        \md_v4_0/fre_ref_0/N_11\, Y => \md_v4_0/fre_ref_0/N_6\);
    
    
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_RNO_0[1]\ : 
        XNOR2
      port map(A => \manchesterEncoderComplete_0/cuentaEnvios[1]\, 
        B => \manchesterEncoderComplete_0/cuentaEnvios[0]\, Y => 
        \manchesterEncoderComplete_0/manchester_encoder_ctrl_0/cuentaEnvios_n1_i_0\);
    
    \command_process_0/state_RNID9Q8[5]\ : OR2
      port map(A => \command_process_0/state[5]_net_1\, B => 
        \command_process_0/state[2]_net_1\, Y => 
        \command_process_0/un2_dataclean_1_i_o4_1\);
    
    \selExp_pad[1]/U0/U1\ : IOIN_IB
      port map(YIN => \selExp_pad[1]/U0/NET1\, Y => \selExp_c[1]\);
    
    
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_RNO[2]\ : 
        AO1A
      port map(A => LedMochila_c, B => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/N_65_1\, 
        C => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/housekeeping_request_0_sqmuxa\, 
        Y => 
        \LowPowerManagement_0/LowPowerManagement_wrapper_inst/U0/FlashFreeze_FSM_inst/ff_current_state_ns[3]\);
    
    \command_process_0/reg_command_error_RNI9H9K\ : NOR3A
      port map(A => \command_process_0/reg_command_error_net_1\, 
        B => \command_process_0/reg_short_command_net_1\, C => 
        \command_process_0/reg_long_command_net_1\, Y => 
        \command_process_0.un2_dataclean_5_i_a9_1_0\);
    
    \MoM_unit_0/aux_timeOut_RNO_0[2]\ : AX1C
      port map(A => \MoM_unit_0/aux_timeOut[0]_net_1\, B => 
        \MoM_unit_0/aux_timeOut[1]_net_1\, C => 
        \MoM_unit_0/aux_timeOut[2]_net_1\, Y => 
        \MoM_unit_0/aux_timeOut_n2_tz\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
