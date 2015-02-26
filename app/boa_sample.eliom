open Eliom_content
open Html5.D

(* A classic standard page *)
let starter_page () () =
  Boa_skeleton.return
    "Hello !"
    [
      div
        ~a:[a_id "sample_content"]
        [ 
          h1 [pcdata "Hello world"];
          p [pcdata "A little sample of BOA"]
        ]
    ]
