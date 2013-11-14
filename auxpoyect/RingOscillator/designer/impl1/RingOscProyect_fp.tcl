new_project \
    -name {RingOscProyect} \
    -location {C:\Users\Victor\Documents\Cookies\wake_up_radio\auxpoyect\RingOscillator\designer\impl1\RingOscProyect_fp} \
    -mode {single}
set_programming_file -file {C:\Users\Victor\Documents\Cookies\wake_up_radio\auxpoyect\RingOscillator\designer\impl1\RingOscProyect.pdb}
set_programming_action -action {PROGRAM}
catch {run_selected_actions} return_val
save_project
close_project
if { $return_val != 0 } {
  exit 1 }
