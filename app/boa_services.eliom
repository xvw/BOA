open Eliom_content
open Eliom_parameter
open Boa_core

(* Custom services registration *)
let todo =
  Register.page
    ~path:["todo"]
    Task.view
       
