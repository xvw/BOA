(* Kernel of a BOA application *)

open Eliom_content

module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Boa_config.name
      end
    )


(* Convinient access to SIMPLE service definition *)
module Define =
  struct

    let get ~params ~path =
      Eliom_service.App.service
        ~path:path
        ~get_params:params

    let post ~fallback ~params =
      Eliom_service.App.post_service
        ~fallback:fallback
        ~post_params:params
   
  end
    
(* Convinient access to SIMPLE service registration *)
module Register =
  struct

    (* Define and register get service *)
    let get ~params ~path callback =
      let service =
        Define.get
          ~path:path
          ~params:params
          ()
      in
      let _ =
        Boa_app.register
          ~service:service
          callback
      in service
           
    (* Define and register a post service*)
    let post ~fallback ~params callback =
      let service =
        Define.post
          ~params:params
          ~fallback
          ()
      in
      let _ =
        Boa_app.register
          ~service:service
          callback
      in service


    module Any =
      struct
        
        let get
              ~params
              ~path
              ~check
              ~redirection
              callback
          =
          Eliom_registration.Any.register_service
            ~path:path
            ~get_params:params
            (fun g p ->
             if check g p
             then Eliom_registration.Html5.send (callback g p)
             else Eliom_registration.Redirection.send redirection
            )

        let post
              ~params
              ~check
              ~redirection
              ~fallback
              callback
          =
          Eliom_registration.Any.register_post_service
            ~post_params:params 
             (fun g p ->
              if check g p
              then Eliom_registration.Html5.send (callback g p)
              else Eliom_registration.Redirection.send redirection
             )
          
        
      end
    
  end

