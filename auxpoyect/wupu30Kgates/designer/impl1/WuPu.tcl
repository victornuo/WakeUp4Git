# Created by Actel Designer Software 10.1.3.1
# Thu Feb 28 19:30:09 2013

# (OPEN DESIGN)

open_design "WuPu.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "WuPu_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\Victor\Documents\Cookies\wake_up_radio\auxpoyect\wupu30Kgates\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"


layout -timing_driven
report -type "status" {WuPu_place_and_route_report.txt}
report -type "globalnet" {WuPu_globalnet_report.txt}
report -type "globalusage" {WuPu_globalusage_report.txt}
report -type "iobank" {WuPu_iobank_report.txt}

save_design
