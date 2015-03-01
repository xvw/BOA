open Boa_core
       
(* Vue de l'application *)
let general_view name =
  let open View in 
  Boa_skeleton.return
    "Hello !"
    [
      h1 [pcdata ("Hello " ^ name ^" !")];
    ]

let view () = general_view "le monde"
let specific_view name _ = general_view name
  
