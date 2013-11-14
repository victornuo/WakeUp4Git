quietly set ACTELLIBNAME igloo
quietly set PROJECT_DIR "C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/WupPMODbyIRQnoMultiRX"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap igloo "C:/Microsemi/Libero_v10.1/Designer/lib/modelsim/precompiled/vhdl/igloo"

vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/Wupu_pck.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/adressingData.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/Command_Process_preamble.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/housekeepingCheck.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/common/vhdl/FlashFreeze_FSM.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/common/vhdl/FlashFreeze_Filter.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/common/vhdl/FlashFreeze_Managment.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/LowPowerManagement/LowPowerManagement_wrapper.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/LowPowerManagement/LowPowerManagement.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/manchester_encoder.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/ManchesterEncoder_ctrl.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/component/work/manchesterEncoderComplete/manchesterEncoderComplete.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/freq_ref_preamble.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/manchesterDecoder_preamble.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/Mom_unit_preamble.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/ASCII_pck.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/hdl/ZBControl_IRQs.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/smartgen/ZBWatchDog/ZBWatchDog.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/component/work/WuPu/WuPu.vhd"
vcom -93 -explicit  -work presynth "${PROJECT_DIR}/component/work/WuPu/testbench.vhd"

vsim -L igloo -L presynth  -t 1ps presynth.testbench
add wave /testbench/*
run 1000ns
