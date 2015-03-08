{shared{
open Eliom_lib
}}
  
{client{
let page_load () =
  let t, u = Lwt.wait () in 
  let _ = Dom_html.window ## onload <-
      Dom.handler (fun _ -> Lwt.wakeup u (); Js._true)
  in t
}}
