(* Convinient access to session *)
open Eliom_lib
open Boa_core

(* Volatile session *)

(* Create a volatile session *)
let create ?(scope=Eliom_common.default_session_scope) value =
  Eliom_reference.Volatile.eref
    ~scope:scope
    value
    
(* Set value to a volatile session *)
let set target value =
  Eliom_reference.Volatile.set target value
                      
(* Retreive the value of a volatile session *)
let get target =
  Eliom_reference.Volatile.get target
                      
(* Restore eref value with the initial value *)
let restore target =
  Eliom_reference.Volatile.unset target                        
       
(* Persistant sessions *)       
module Persistant =
  struct


    (* Create a persistant session *)
    let create value =
      Eliom_reference.eref
        ~scope:Eliom_common.default_session_scope
        value

    (* Set value to a persistant session *)
    let set target value =
      Eliom_reference.set target value

    (* Retreive the value of a persistant session *)
    let get target =
      Eliom_reference.get target

    (* Restore eref value with the initial value *)
    let restore target =
      Eliom_reference.unset target
    
  end

