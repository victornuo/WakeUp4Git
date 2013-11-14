onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/clk
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/din
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/load_din
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/nextHopAddress
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/rstn
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/start
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/TX_Active
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/d_hk
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/dout
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/d_hk_net_0
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/dout_net_0
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_0_TXbuff_free
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_ctrl_0_addParity
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_ctrl_0_d_hk
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_ctrl_0_dout
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_ctrl_0_enableEncoder
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/manchester_encoder_ctrl_0_loadEncoder
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/TX_Active_net_0
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/dout_net_1
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/d_hk_net_1
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/TX_Active_net_1
add wave -noupdate /tb_mom_encoder_zbctrl/manchesterEncoderComplete_0/TX_Active_OUT_PRE_INV0_0
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_port
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_active
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_commandType
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_commandReady
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_addressOK
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/uC_commandType
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/uC_commandReady
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ZB_active
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/TX_Active
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandType2ZB
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandReady2ZB
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/nextHopAddress
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandToEncoder
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/Enable_encoder
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RF_selector
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/TX_load
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/RX_processed
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/MoMState
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/d_hk
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/rst
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/state
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/next_state
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/TX_enable
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/SINKNeighbor
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandSource
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/clean_command
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/command2send
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandType
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/commandReceived
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/WaitingACKEnab
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/timeOutACK
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/NACKCnt
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/aux_timeOut
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ContentionEnab
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/NACKCounterEnab
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ContentionTimeExpired
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/Contention_int
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ChannelFreeTime
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ChannelFree
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/ContentionExpired
add wave -noupdate /tb_mom_encoder_zbctrl/MoM_unit_0/Mom_Free
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/commandType2uC
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/commandReady2uC
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ZB_active
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/IRQ0
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/IRQ1
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/IRQ2
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/IRQ3
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/WD_IRQ
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/WD_CLR
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/R2SINKTimeout
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/NWKrRouteTimeout
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/clk
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/rst
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/d_hk
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ZB_Activate
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ZB_Sleep
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/IOtoLow
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/StartTimers
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/commandTypeIN
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/commandReadyIN
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ZBcontrolActive
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/LoadNWKmsg
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/SleepZB
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ActivateZB
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/ZBTimeout
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/state
add wave -noupdate /tb_mom_encoder_zbctrl/ZBControl_0/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16489307670 ps} 0} {{Cursor 2} {29641891892 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 249
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {57750 us}
