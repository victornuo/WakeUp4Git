quietly set ACTELLIBNAME igloo
quietly set PROJECT_DIR "C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/Wupu30K-InitializationwithR2SINK"

if {[file exists ../designer/impl1/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/impl1/simulation/postlayout already exists"
} else {
   vlib ../designer/impl1/simulation/postlayout
}
vmap postlayout ../designer/impl1/simulation/postlayout
vmap igloo "C:/Microsemi/Libero_v11.1/Designer/lib/modelsim/precompiled/vhdl/igloo"

vcom -93 -explicit  -work postlayout "${PROJECT_DIR}/hdl/ASCII_pck.vhd"
vcom -93 -explicit  -work postlayout "${PROJECT_DIR}/hdl/Wupu_pck.vhd"
vcom -93 -explicit  -work postlayout "${PROJECT_DIR}/designer/impl1/WuPu_ba.vhd"
vcom -93 -explicit  -work postlayout "${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1/PULSE_GEN.vhd"

vsim -L igloo -L postlayout  -t 1ps -sdfmax /WuPu_0=${PROJECT_DIR}/designer/impl1/WuPu_ba.sdf postlayout.testbench
add wave /testbench/WuPu_0/*
run 10 ps
