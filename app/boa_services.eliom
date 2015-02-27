open Eliom_content
open Eliom_parameter
open Boa_core

       
let sample_main =
  Define.get
    ~path:[]
    ~params:(unit)
    ()

let sample_redirect =
  Register.Any.get
    ~path:["sample_redirect"]
    ~check:(fun a _ -> a = "nuki" )
    ~params:(string "to")
    ~redirection:sample_main
    Boa_sample.test_redirection
    
