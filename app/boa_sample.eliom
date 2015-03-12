{shared{
open Boa_core
}}

module Start =
struct

  (* A classic standard page *)

  let text_intro =
    let open View in 
    p
      ~a:[a_class ["paragraph"]]
      [
        pcdata
          "A little sample of BOA. A little framework built
             from Ocsigen !
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

end


(* Sample of simple reactiv context *)
  
{shared{
open Eliom_lib
open Eliom_content.Html5
}}

{client{
let handler = Boa_react.create 0
}}

{shared{
 let reactive_div () =
   D.div
     [C.node
        {{ R.pcdata (Boa_react.map string_of_int handler) }}
     ]
     
 let a_button =
   let open D in
     button
       ~button_type:`Button
       ~a:[a_onclick {{ fun e -> Boa_react.apply succ handler}}]
       [pcdata "+1"]
   }}

let react_sample =
  Register.page
    ~path:["react_sample"]
    (fun () ->
     Boa_skeleton.return
       "Sample of Reactive data"
       [
         reactive_div ();
         a_button;
       ]
    )

(* Another reactive sample *)

(* Create an iterator (on each frames) *)
let time =
  Boa_react.iterate
    "Valeur par défaut :v"
    (fun _ -> Printf.sprintf "%f" (Unix.time ()))

(* Display with reactives values *)
let other_react_sample =
  Register.page
    ~path:["react_other_sample"]
    (fun () ->
     let time_div = View.div [C.node {{ R.pcdata %time }}] in 
     Boa_skeleton.return
       "Timer Sample"
       [time_div]
    )


(* Realtime test *)
let realtime_div = D.(div ~a:[a_id "realtime-div"] [])

                       
let bus =
  Boa_realtime.create_bus
    ~name:"texted"
    Json.t<string>
    
                       
{client{
                            
     let rec process_append s = 
       let dom_div = To_dom.of_div %realtime_div in
       let added_div = Dom_html.createDiv Dom_html.document in  
       let textnode =
         Dom_html.document ## createTextNode (Js.string s)
       in
       let _ = Dom.appendChild added_div textnode in 
       let _ = Dom.appendChild dom_div added_div in ()

     let write s =
       Boa_realtime.write_bus %bus s
       |> ignore


     let _ = Boa_realtime.iterate process_append %bus

   }}  
  
  
let realtime_service =
  let open View in
  Register.page
    ~path:["realtime"]
    (fun () ->
     Boa_skeleton.return
       "Realtime example"
       [
         Boa_gui.modal_with_title
           "Realtime example"
           [
             D.button
               ~button_type:`Button
               ~a:[a_onclick
                     {{
                       fun _ -> write (Printf.sprintf "%f" (Unix.time ()))
                     }}
                  ]
               [pcdata "Append text"];
             realtime_div
           ]
       ]
    )

(* Geo Sample *)
{client{open Boa_geolocation}}
let geo_view () =
  let lat_ctn = Boa_react.node {{R.pcdata (map_latitude string_of_float)}}
  and lon_ctn = Boa_react.node {{R.pcdata (map_longitude string_of_float)}}
  in
  let _ = {unit{track_coords ()}} in
  Boa_skeleton.modal_with_title
    "Sample of Geolocation"
    [lat_ctn; lon_ctn]
    
let geo_service =
  Register.page
    ~path:["geo"]
    geo_view

(* Gravatar sample *)
let gravatar_service =
  Register.get
    ~path:["gravatar"]
    ~params:Eliom_parameter.(suffix (string "mail"))
    (fun g ->
     let open View in 
     Boa_skeleton.modal_with_title
       "Sample of Gravatar"
       [
         h2 [pcdata g];
         img
           ~a:[a_style "width:100%"]
           ~alt:"Avatar"
           ~src:(Boa_uri.gravatar g)
           ()
       ]
    )
