open Eliom_content
open Boa_core
       
(* A classic standard page *)

let text_intro =
  let open View in 
  p
    ~a:[a_class ["paragraph"]]
    [
      pcdata
        "A little sample of BOA. A little framework builded
         over Ocsigen !
         "
    ]

let btnA =
  Boa_gui.button
    ~classes:["boa2_btn"]
    (Boa_ui.Link.url
       "http://ocsigen.org"
       "Ocsigen website")

let btnB =
  Boa_gui.button
    ~classes:["boa2_btn"]
    (Boa_ui.Link.url
       "http://github.com/phutur/BOA"
       "BOA repository")

let btnC =
  Boa_gui.button
    ~classes:["boa2_btn"]
    (Boa_ui.Link.url
       "http://github.com/phutur/BOA/wiki"
       "BOA Wiki")

let grid =
  Boa_gui.autogrid
    "autogrid3"
    [
      btnA;
      btnB;
      btnC;
    ]
  
  
let starter_page () = 
  Boa_skeleton.return
    "Hello !"
    [
      Boa_gui.modal_with_title
        ~classes:["text_center"]
        ~title:"Hello from BOA!"
        [ 
          text_intro;
          grid;
        ]
      
    ]


let start =
  Register.page
    ~path:[]
    starter_page
