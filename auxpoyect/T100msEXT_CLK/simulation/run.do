quietly set ACTELLIBNAME igloo
quietly set PROJECT_DIR "C:/Users/Victor/Documents/Cookies/wake_up_radio/auxpoyect/RingOscillator"

if {[file exists ../designer/impl1/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/impl1/simulation/postlayout already exists"
} else {
   vlib ../designer/impl1/simulation/postlayout
}
vmap postlayout ../designer/impl1/simulation/postlayout
vmap igloo "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/igloo"

vcom -93 -explicit -work postlayout "${PROJECT_DIR}/designer/impl1/RingOscillator_ba.vhd"
vcom -93 -explicit -work postlayout "${PROJECT_DIR}/component/work/RingOscillator/testbench.vhd"

vsim -L igloo -L postlayout  -t 1ps -sdfmax /RingOscillator_0=${PROJECT_DIR}/designer/impl1/RingOscillator_ba.sdf postlayout.testbench
add wave /testbench/*
run 1000ns
