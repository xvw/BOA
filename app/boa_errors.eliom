(* Custom error handlers *)

open Eliom_lib
open Eliom_content
open Html5.D
open Lwt_ops

let error_template title h desc =
  Boa_skeleton.raw
    title
    [
      div
        ~a:[a_class ["modal"; "error"]]
        [
          h1 [pcdata h];
          p [pcdata desc];
          Boa_ui.Link.service
            Eliom_service.void_coservice' ()
            "reload the page"
        ]
    ]
       
let error404 () =
  error_template
    "Service is not available"
    "Error 404"
    "This service is not avaible :/"

let wrong_params () =
  error_template
    "Wrong parameters"
    "Wrong parameters"
    "This service is not deserved by this parameters schema"

(* Register error handler *)
let _ =
  Eliom_registration.set_exn_handler
    (
      function
      | Eliom_common.Eliom_404 ->
         Eliom_registration.Html5.send ~code:404 (error404 ())
      | Eliom_common.Eliom_Wrong_parameter ->
         Eliom_registration.Html5.send (wrong_params ())
      | e -> Lwt.fail e
    )
