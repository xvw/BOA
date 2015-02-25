(* Kernel of a Boa Application *)
open Eliom_content

module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Config.name
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

    (* Default error *)
    let default_error =
      get
        ~path:["boa";"error"]
        (fun () () ->
         Skeleton.raw
           "BOA_DEFAULT_ERROR"
           [
             Html5.D.(h1 [pcdata "[BOA DEFAULT ERROR]"]);
             Html5.D.(p [pcdata "Unknown error"]);
             Ui.Link.url "https://github.com/Phutur/BOA" "BOA webpage"
           ]
        )


    (* Define and register a post service*)
    let post
          ?(get_params=Eliom_parameter.unit)
          ?(fallback=default_error)
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
