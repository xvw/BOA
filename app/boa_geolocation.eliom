{shared{

open Eliom_lib
open Boa_core

type pos = (float * float) deriving(Json)

 }}

let inA =
  View.(Raw.input
    ~a:[a_id "input-1"]
    ())
let inB =
  View.(Raw.input
    ~a:[a_id "input-2"]
    ())
  

let current_position = Boa_session.create (0.0, 0.0)
let set_pos k =
  Boa_session.set current_position k;
  Lwt.return_unit
let session_set_rpc = server_function Json.t<pos> set_pos
{client{
     
let geolocation =
  let nav = Js.Unsafe.variable "navigator" in 
  nav ## geolocation
      
let retreive_callback pos =
  let lat = pos ## coords ## latitude
  and lon = pos ## coords ## longitude
  in
  %session_set_rpc (Js.to_float lat, Js.to_float lon)

let _ = geolocation ## getCurrentPosition(retreive_callback)

}}

module Debug =
struct

  let view () =
    let open View in
    let (lat, long) = Boa_session.get current_position in
    Boa_skeleton.return
      "Sample geocode"
      [
        inA; inB
      ]

  let main =
    Register.page
      ~path:["geo"]
      view

end

