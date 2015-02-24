(* Kernel of a Boa Application *)
module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Config.name
      end
    )

(* Convinient access to service registration *)
module Service =
  struct

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
    
  end
