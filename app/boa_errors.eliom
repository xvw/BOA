(* Custom error handlers *)

open Eliom_lib
open Eliom_content
open Html5.D
open Lwt_ops

let error_template title h desc =
  Boa_skeleton.raw
    title
    [Boa_gui.error h desc]
       
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

let unknown_error () =
  error_template
    "Unknown error"
    "Unknown error... DAMN !"
    "The page has been crashed... for an obscur reason... this is so sad :'("

let pgerror s =
  error_template
    "Postgres Error"
    "Internal Error (with PostgreSQL)"
    s
    
(* Register error handler *)
let _ =
  Eliom_registration.set_exn_handler
    (
      function
      | Eliom_common.Eliom_404 ->
         Eliom_registration.Html5.send ~code:404 (error404 ())
      | Eliom_common.Eliom_Wrong_parameter ->
         Eliom_registration.Html5.send (wrong_params ())
      | Eliom_common.Eliom_site_information_not_available data ->
         Eliom_registration.Html5.send (error_template data data data)
      | Eliom_Internal_Error s ->
         Eliom_registration.Html5.send
           (error_template "Internal Error" "Error 500" s)
      | Boa_db.Lwt_PGOCaml.Error s ->
         Eliom_registration.Html5.send (pgerror s)
      | Boa_db.Lwt_PGOCaml.PostgreSQL_Error (s, _) ->
         Eliom_registration.Html5.send (pgerror s)
      | e ->
         Eliom_registration.Html5.send (unknown_error ())
    )
