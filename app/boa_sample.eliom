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
          h1 [pcdata "Hello World"];
          p [pcdata "A little sample of BOA"]
        ]
    ]

(* Test for redirection *)
let test_redirection g _ =
  Boa_skeleton.raw
    "Test redirection"
    [
      div
        ~a:[a_id "sample_content"]
        [ 
          h1 [pcdata ("Hello "^g)];
          p [pcdata "A little sample of BOA"]
        ] 
    ]
