onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TX
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/clk
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/din
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/load_din
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/nextHopAddress
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/rstn
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/start
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/TX_Active
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/d_hk
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_0/dout
add wave -noupdate -divider RX
add wave -noupdate -divider Decoder
add wave -noupdate /tb_wupu_complete/md_v3_0/ERROR_TIME
add wave -noupdate /tb_wupu_complete/md_v3_0/mdi
add wave -noupdate /tb_wupu_complete/md_v3_0/EoM
add wave -noupdate /tb_wupu_complete/md_v3_0/rst
add wave -noupdate /tb_wupu_complete/md_v3_0/bit_error
add wave -noupdate /tb_wupu_complete/md_v3_0/dout
add wave -noupdate /tb_wupu_complete/md_v3_0/new_data
add wave -noupdate /tb_wupu_complete/md_v3_0/d_hk
add wave -noupdate -divider commandProcc
add wave -noupdate /tb_wupu_complete/command_process_0/nodeAddress
add wave -noupdate /tb_wupu_complete/command_process_0/din
add wave -noupdate /tb_wupu_complete/command_process_0/newData
add wave -noupdate /tb_wupu_complete/command_process_0/state
add wave -noupdate /tb_wupu_complete/command_process_0/addOK
add wave -noupdate /tb_wupu_complete/command_process_0/ParityOK
add wave -noupdate /tb_wupu_complete/command_process_0/ParityRX
add wave -noupdate /tb_wupu_complete/command_process_0/dataClean
add wave -noupdate /tb_wupu_complete/command_process_0/bitError
add wave -noupdate /tb_wupu_complete/command_process_0/rst
add wave -noupdate /tb_wupu_complete/command_process_0/endOfMessage
add wave -noupdate /tb_wupu_complete/command_process_0/newMsg
add wave -noupdate /tb_wupu_complete/command_process_0/msgType
add wave -noupdate /tb_wupu_complete/command_process_0/Busy
add wave -noupdate /tb_wupu_complete/command_process_0/AddOKflag
add wave -noupdate /tb_wupu_complete/command_process_0/d_hk
add wave -noupdate -divider Encoder
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/din
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/load_din
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/nextHopAddress
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/rstn
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/start
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/TX_Active
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/d_hk
add wave -noupdate /tb_wupu_complete/manchesterEncoderComplete_1/dout
add wave -noupdate -divider MOMUnit
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_port
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_active
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_commandType
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_commandReady
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_addressOK
add wave -noupdate /tb_wupu_complete/MoM_unit_0/uC_commandType
add wave -noupdate /tb_wupu_complete/MoM_unit_0/uC_commandReady
add wave -noupdate /tb_wupu_complete/MoM_unit_0/ZB_active
add wave -noupdate /tb_wupu_complete/MoM_unit_0/TX_Active
add wave -noupdate /tb_wupu_complete/MoM_unit_0/rst
add wave -noupdate /tb_wupu_complete/MoM_unit_0/nextHopAddress
add wave -noupdate /tb_wupu_complete/MoM_unit_0/commandType2ZB
add wave -noupdate /tb_wupu_complete/MoM_unit_0/commandReady2ZB
add wave -noupdate /tb_wupu_complete/MoM_unit_0/commandToEncoder
add wave -noupdate /tb_wupu_complete/MoM_unit_0/Enable_encoder
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RF_selector
add wave -noupdate /tb_wupu_complete/MoM_unit_0/TX_load
add wave -noupdate /tb_wupu_complete/MoM_unit_0/RX_processed
add wave -noupdate /tb_wupu_complete/MoM_unit_0/MoMState
add wave -noupdate /tb_wupu_complete/MoM_unit_0/d_hk
add wave -noupdate -divider ZBCtrl
add wave -noupdate /tb_wupu_complete/ZBControl_0/commandType2uC
add wave -noupdate /tb_wupu_complete/ZBControl_0/commandReady2uC
add wave -noupdate /tb_wupu_complete/ZBControl_0/WD_IRQ
add wave -noupdate /tb_wupu_complete/ZBControl_0/R2SINKTimeout
add wave -noupdate /tb_wupu_complete/ZBControl_0/NWKrRouteTimeout
add wave -noupdate /tb_wupu_complete/ZBControl_0/rst
add wave -noupdate /tb_wupu_complete/ZBControl_0/ZB_active
add wave -noupdate /tb_wupu_complete/ZBControl_0/IRQ0
add wave -noupdate /tb_wupu_complete/ZBControl_0/IRQ1
add wave -noupdate /tb_wupu_complete/ZBControl_0/IRQ2
add wave -noupdate /tb_wupu_complete/ZBControl_0/IRQ3
add wave -noupdate /tb_wupu_complete/ZBControl_0/WD_CLR
add wave -noupdate /tb_wupu_complete/ZBControl_0/d_hk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1983992775 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 323
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
configure wave -timelineunits ns
update
WaveRestoreZoom {1884151120 ps} {3196652880 ps}
