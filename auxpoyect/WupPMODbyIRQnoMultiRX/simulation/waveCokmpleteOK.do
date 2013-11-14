onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_wupu_complete/md_v4_0/mdi
add wave -noupdate /tb_wupu_complete/addressingData_0_NextHopAddress
add wave -noupdate /tb_wupu_complete/addressingData_0_NodeAddress
add wave -noupdate /tb_wupu_complete/command_process_0_AddOKflag
add wave -noupdate /tb_wupu_complete/command_process_0_Busy
add wave -noupdate /tb_wupu_complete/command_process_0_msgType
add wave -noupdate /tb_wupu_complete/command_process_0_newMsg
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0_dout
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1_TX_Active
add wave -noupdate /tb_wupu_complete/md_v4_0_bit_error
add wave -noupdate /tb_wupu_complete/md_v4_0_dout
add wave -noupdate /tb_wupu_complete/md_v4_0_new_data
add wave -noupdate /tb_wupu_complete/MoM_unit_0_commandReady2ZB
add wave -noupdate /tb_wupu_complete/MoM_unit_0_commandToEncoder
add wave -noupdate /tb_wupu_complete/MoM_unit_0_commandType2ZB
add wave -noupdate /tb_wupu_complete/MoM_unit_0_Enable_encoder
add wave -noupdate /tb_wupu_complete/MoM_unit_0_RX_processed
add wave -noupdate /tb_wupu_complete/MoM_unit_0_TX_load
add wave -noupdate /tb_wupu_complete/PULSE_GEN_0_PULSE_0
add wave -noupdate /tb_wupu_complete/PULSE_GEN_1_PULSE
add wave -noupdate /tb_wupu_complete/PULSE_GEN_2_PULSE_1
add wave -noupdate /tb_wupu_complete/PULSE_GEN_3_PULSE
add wave -noupdate /tb_wupu_complete/ZBControl_0_ZB_active
add wave -noupdate /tb_wupu_complete/sel_const_net_0
add wave -noupdate /tb_wupu_complete/GND_net
add wave -noupdate /tb_wupu_complete/PULSE_OUT_PRE_INV0_0
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/dout
add wave -noupdate /tb_wupu_complete/commandRX_0_NexthopAddress
add wave -noupdate /tb_wupu_complete/commandRX_0_selAddress
add wave -noupdate /tb_wupu_complete/commandRX_0_load
add wave -noupdate /tb_wupu_complete/commandRX_0_start
add wave -noupdate /tb_wupu_complete/commandRX_0_din
add wave -noupdate /tb_wupu_complete/Timeout_0_ZBControl
add wave -noupdate /tb_wupu_complete/command_process_0/nodeAddress
add wave -noupdate /tb_wupu_complete/command_process_0/din
add wave -noupdate /tb_wupu_complete/command_process_0/newData
add wave -noupdate /tb_wupu_complete/command_process_0/dataClean
add wave -noupdate /tb_wupu_complete/command_process_0/bitError
add wave -noupdate /tb_wupu_complete/command_process_0/newMsg
add wave -noupdate /tb_wupu_complete/command_process_0/msgType
add wave -noupdate /tb_wupu_complete/command_process_0/Busy
add wave -noupdate /tb_wupu_complete/command_process_0/rst
add wave -noupdate /tb_wupu_complete/command_process_0/AddOKflag
add wave -noupdate /tb_wupu_complete/command_process_0/d_hk
add wave -noupdate /tb_wupu_complete/MoM_unit_0/state
add wave -noupdate /tb_wupu_complete/MoM_unit_0/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11325080732 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
configure wave -valuecolwidth 71
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {63 ms}
