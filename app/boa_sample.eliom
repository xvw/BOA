open Eliom_content
open Boa_core
       
(* A classic standard page *)
let starter_page () =
  let open View in 
  Boa_skeleton.return
    "Hello !"
    [
      Boa_gui.modal_with_title
        ~title:"Hello from BOA!"
        [ 
          p
            ~a:[a_class ["paragraph"]]
            [
              pcdata
                "A little sample of BOA. A little framework builded
                 over Ocsigen !
                 "
            ];
          Boa_gui.button
            ~classes:["boa2_btn"]
            (Boa_ui.Link.url
               "http://ocsigen.org"
               "Ocsigen website");

          Boa_gui.button
            ~classes:["boa2_btn"]
            (Boa_ui.Link.url
               "http://github.com/phutur/BOA"
               "BOA repository");
          
          Boa_gui.button
            ~classes:["boa2_btn"]
            (Boa_ui.Link.url
               "http://github.com/phutur/BOA/wiki"
               "BOA Wiki");
        ]
    ]


let start =
  Register.page
    ~path:[]
    starter_page
