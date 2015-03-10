(* Geolocation helper *)
{shared{
     open Eliom_content
     open Html5
     open Boa_core
     let (>>=) = Lwt.bind
}}

{client{
     
     (* Create signal for reactive data *)
     let signal_lat = Boa_react.create 0.0
     let signal_lon = Boa_react.create 0.0

     (* Create an Geolocation object in JS *)                                   
     let geo_obj =
       let nav = Js.Unsafe.variable "navigator" in
       nav ## geolocation

     (* Position callback *)
     let position_callback pos_obj =
       let lat = Js.to_float (pos_obj ## coords ## latitude)
       and lon = Js.to_float (pos_obj ## coords ## longitude) in
       let _ = Boa_react.set signal_lat lat in
       Boa_react.set signal_lon lon

     (* reactive caller *)
     let process () =
       geo_obj ## getCurrentPosition (position_callback)

     let map_latitude f = Boa_react.map f signal_lat
     let map_longitude f = Boa_react.map f signal_lon

     let track_coords () =
       Lwt.async (fun () -> Boa_job.continous process)
       
}}
