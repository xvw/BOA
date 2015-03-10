{shared{

open Eliom_lib
open Boa_core
open Eliom_content.Html5
}}

let inp = 
  D.Raw.input ()
  
{client{

let geolocation =
  let nav = Js.Unsafe.variable "navigator" in
  nav ## geolocation

let retreive_callback pos =
  let lat = Js.to_float (pos ## coords ## latitude)
  and lon = Js.to_float (pos ## coords ## longitude) in
  let i = To_dom.of_input %inp in
  i ## value <- (Js.string (Printf.sprintf "%f x %f" lat lon))

let position_call () =
  geolocation ## getCurrentPosition(retreive_callback)
      
let binder ()  =
  while_lwt true
  do
    %(Lwt_unix.sleep 1.0) >>=
      (fun () ->
       position_call ();
       Lwt.return_unit
      )
  done

let _ = Lwt.async binder
              
}}
              
let view () =
  Boa_skeleton.return
    "Sample geocode"
    [
      Boa_gui.modal_with_title
        "Your current position"
        [inp]
    ]

    
let main =
  Register.page
    ~path:["geo"]
    view
