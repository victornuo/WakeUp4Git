# Created by Actel Designer Software 10.1.3.1
# Mon May 06 19:01:01 2013

# (NEW DESIGN)

# create a new design
new_design -name "RingOscProyect" -family "IGLOO"
set_device -die {AGL250V5} -package {100 VQFP} -speed {STD} -voltage {1.5} -IO_DEFT_STD {LVCMOS 1.5V} -OPCONR {COM} -TEMPR {COM} -VCCI_1.5_VOLTR {COM} -VCCI_1.8_VOLTR {COM} -VCCI_2.5_VOLTR {COM} -VCCI_3.3_VOLTR {COM} -VOLTR {COM}


# set default back-annotation base-name
set_defvar "BA_NAME" "RingOscProyect_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\Victor Ros\Documents\Cookies\wake_up_radio\auxpoyect\RingOscillatorCookie\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"

# set working directory
set_defvar "DESDIR" "C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/auxpoyect/RingOscillatorCookie/designer/impl1"

# set back-annotation output directory
set_defvar "BA_DIR" "C:/Users/Victor Ros/Documents/Cookies/wake_up_radio/auxpoyect/RingOscillatorCookie/designer/impl1"

# enable the export back-annotation netlist
set_defvar "BA_NETLIST_ALSO" "1"

# set EDIF options
set_defvar "EDNINFLAVOR" "GENERIC"

# set HDL options
set_defvar "NETLIST_NAMING_STYLE" "VHDL93"

# setup status report options
set_defvar "EXPORT_STATUS_REPORT" "1"
set_defvar "EXPORT_STATUS_REPORT_FILENAME" "RingOscProyect.rpt"

# legacy audit-mode flags (left here for historical reasons)
set_defvar "AUDIT_NETLIST_FILE" "1"
set_defvar "AUDIT_DCF_FILE" "1"
set_defvar "AUDIT_PIN_FILE" "1"
set_defvar "AUDIT_ADL_FILE" "1"

# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VHDL" {../../synthesis/RingOscProyect.edn}

# save the design database
save_design {RingOscProyect.adb}


compile
report -type "status" {RingOscProyect_compile_report.txt}

save_design
