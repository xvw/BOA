(* Entry point *)
module Db = Boa_db
module Core = Boa_core
module Skeleton = Boa_skeleton
module Errors = Boa_errors
module Sample = Boa_sample
                  
(* Main *)
let _ =
  Core.Register.get
    ~path:[]
    Sample.starter_page
           
           
