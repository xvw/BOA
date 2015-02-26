(* Custom error handlers *)

open Eliom_lib
open Eliom_content
open Html5.D
open Lwt_ops

let error404 () =
  Boa_skeleton.raw
    "Service not accessible"
    [
      div
        ~a:[a_class ["modal"; "error"]]
        [
          h1 [pcdata "Error 404"];
          p [pcdata "This service is not accessible :/"];
          Boa_ui.Link.service
            Eliom_service.void_coservice' ()
            "reload the page"
        ]
    ]

(* Register error handler *)
let _ =
  Eliom_registration.set_exn_handler
    (
      function
      | Eliom_common.Eliom_404 ->
         Eliom_registration.Html5.send ~code:404 (error404 ())
      | e -> Lwt.fail e
    )
