(* Entry point *)
module Db = Boa_db
module Core = Boa_core
module App = Core.Boa_app
module Services = Boa_services
module Skeleton = Boa_skeleton
module Ui = Boa_ui
module Gui = Boa_gui
module Errors = Boa_errors
module Sample = Boa_sample
                  
(* Main *)
let _ =
  App.register
    ~service:Services.sample_main
    Sample.starter_page

    
