(* Ui components for webprototyping *)
open Eliom_lib
open Eliom_content
open Html5.D
open Lwt_ops


(* Easy link designer  *)
module Link =
  struct

    (* Simple link *)
    let url ?(a=[]) href txt =
      let target = Raw.uri_of_string href in 
      Html5.F.Raw.a
        ~a:([a_href target] @ a)
        [pcdata txt]

    (* Service link *)
    let service ?(a=[]) service params txt =
      Html5.D.a
        ~service:service
        ~a:a
        [pcdata txt]
        params
  end
