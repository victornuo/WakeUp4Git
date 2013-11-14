# Created by Actel Designer Software 10.1.3.1
# Thu Feb 28 17:57:06 2013

# (OPEN DESIGN)

open_design "RingOscProyect.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "RingOscProyect_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\Victor\Documents\Cookies\wake_up_radio\auxpoyect\T100msEXT_CLK\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"


# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VHDL" {../../synthesis/RingOscProyect.edn} -merge_physical "yes" -merge_timing "yes"
compile
report -type "status" {RingOscProyect_compile_report.txt}

save_design
