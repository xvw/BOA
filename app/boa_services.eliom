open Eliom_content
open Eliom_parameter
open Boa_core

(* Custom services registration *)
(* Entry point for service regsitration *)
module Custom =
  struct

    (* A verry simple todo list *)
    let todo =
      Register.page
        ~path:["todo"]
        Task.view
    
  end
