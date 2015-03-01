open Eliom_content
open Eliom_parameter
open Boa_core

(* Custom services registration *)
let hello =
  Register.page
    ~path:["hello"]
    Hello.view

let specific_hello =
  Register.get
    ~params:(suffix (string "name"))
    ~path:["specific_hello"]
    Hello.specific_view
