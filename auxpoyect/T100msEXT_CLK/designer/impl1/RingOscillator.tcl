# Created by Actel Designer Software 10.1.3.1
# Thu Feb 28 12:59:59 2013

# (OPEN DESIGN)

open_design "RingOscillator.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "RingOscillator_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\Victor\Documents\Cookies\wake_up_radio\auxpoyect\RingOscillator\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"
set_design  -name "RingOscillator" -family "IGLOO"
set_device -die {M1AGL600V2} -package {484 FBGA} -speed {STD} -voltage {1.2~1.5} -IO_DEFT_STD {LVCMOS 1.2V} -OPCONR {COM} -TEMPR {COM} -VCCI_1.2_VOLTR {COM} -VCCI_1.5_VOLTR {COM} -VCCI_1.8_VOLTR {COM} -VCCI_2.5_VOLTR {COM} -VCCI_3.3_VOLTR {COM} -VOLTR {COM}



# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VHDL" {../../synthesis/RingOscillator.edn} \
-format "sdc"  {..\..\synthesis\RingOscillator_sdc.sdc} -merge_physical "no" -merge_timing "yes"
compile
report -type "status" {RingOscillator_compile_report.txt}

save_design
