(* Realtime implementation *)
{shared{
open Eliom_content
open Eliom_content.Html5.D
open Eliom_lib.Lwt_ops
}}

let create_bus ~name typ = Eliom_bus.create ~name:name typ
                                            
{shared{
let iterate f bus = Lwt_stream.iter f (Eliom_bus.stream bus)
let write_bus bus value = Eliom_bus.write bus value
                                          
}}

