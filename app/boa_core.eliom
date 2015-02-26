(* Kernel of a BOA application *)
(* Kernel of a Boa Application *)
open Eliom_content

module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Boa_config.name
      end
    )

(* Convinient access to SIMPLE service registration *)
module Register =
  struct

    (* Define and register get service *)
    let get ?(params=Eliom_parameter.unit) ~path callback =
      let service =
        Eliom_service.App.service
          ~path:path
          ~get_params:params
          () 
      in
      let _ =
        Boa_app.register
          ~service:service
          callback
      in service
           
    (* Define and register a post service*)
    let post
          ?(get_params=Eliom_parameter.unit)
          ~fallback
          ~path
          ~params
          callback =
      let service =
        Eliom_service.App.post_service
          ~fallback:fallback
          ~post_params:params
          ()
      in
      let _ =
        Boa_app.register
          ~service:service
          callback
      in service

    
  end

