{shared{

     open Eliom_lib
     open Boa_core
     
   }}

  let main_service =
    Register.page
      ~path:["lol"]
      (fun () ->
       let open Eliom_content.Html5.D in
       let input = Raw.input ~a:[a_input_type `Text] () in
       let onclick_handler =
	       {{ fun e ->
            let v = "lol" in
	          Dom_html.window##alert(Js.string ("Input value :" ^ v)) }}
       in
       let button =
         Raw.button ~a:[a_onclick onclick_handler] [pcdata "Read value"]
       in
       Lwt.return
         (html
	          (head (title (pcdata "Test")) [])
            (body [input; button]) ) )
      

module Debug =
  struct

    let view () =
      let open View in 
      Boa_skeleton.return
        "Sample geocode"
        [
          Raw.input
            ~a:[a_id "input-1"]
            ();
          Raw.input
            ~a:[a_id "input-2"]
            ();
        ]

    let main =
      Register.page
        ~path:["geo"]
        view

  end
