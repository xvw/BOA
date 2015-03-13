(* Handle tip notifications *)
{shared{
     open Eliom_lib
     open Eliom_content
     open Html5
     open Boa_core
}}
{client{

     let greff_component target content =
       let dom_target = To_dom.of_div target
       and dom_content = To_dom.of_div content in
       Dom.appendChild dom_target dom_content

     let remove_component target content =
       let dom_target = To_dom.of_div target
       and dom_content = To_dom.of_div content in
       Dom.removeChild dom_target dom_content
            
}}

let raw_set target content =
  let _ = {unit{ greff_component %target %content}}
  in Lwt.return_unit

let set target content =
  raw_set target (D.div content)

let set_closable target content =
  let ctn = D.div content in 
  let _ =
    {unit{
         let dom_content = To_dom.of_div %ctn in  
         let open Lwt_js_events in
         async
           (fun () ->
            clicks
              dom_content
              (fun _ _ ->
               let _ = remove_component %target %ctn
               in Lwt.return_unit
              )
           )
         
    }} in raw_set target ctn

