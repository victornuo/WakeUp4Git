open_project -project {C:\Users\Victor Ros\Documents\Cookies\wake_up_radio\auxpoyect\RingOscillator\designer\impl1\RingOscProyect_fp\RingOscProyect.pro}
set_programming_action -action {PROGRAM}
catch {run_selected_actions} return_val
save_project
close_project
if { $return_val != 0 } {
  exit 1 }
