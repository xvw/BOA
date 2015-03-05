(* Kernel of a BOA application *)
open Eliom_content

       
module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Boa_config.name
      end
    )

(* Tool for HTML definition *)    
module View =
  struct

    include Html5.D
    
  end


(* Convinient access to SIMPLE service definition *)
module Define =
  struct

    let get ~params ~path =
      Eliom_service.App.service
        ~path:path
        ~get_params:params

    let page ~path =
      get ~params:Eliom_parameter.unit ~path

    let post ~fallback ~params =
      Eliom_service.App.post_service
        ~fallback:fallback
        ~post_params:params

    module Action =
      struct

        let post ~params callback  =
          Eliom_registration.Action.register_post_coservice'
            ~post_params:params
            (fun () x -> callback x)

        let get ~params callback =
          Eliom_registration.Action.register_coservice'
            ~get_params:params
            (fun x () -> callback x)
        
      end
   
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
          (fun x _ -> callback x)
      in service

    let page ~path callback =
      get
        ~params:Eliom_parameter.unit
        ~path
        (fun _ -> callback ()) 
           
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
          (fun _ x -> callback x)
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
            (fun g _ ->
             if check g 
             then Eliom_registration.Html5.send (callback g)
             else Eliom_registration.Redirection.send redirection
            )

        let page ~path ~check ~redirection callback =
          get
            ~params:Eliom_parameter.unit
            ~path
            ~check
            ~redirection
            callback

        let post
              ~params
              ~check
              ~redirection
              ~fallback
              callback
          =
          Eliom_registration.Any.register_post_service
            ~post_params:params 
             (fun _ p->
              if check p
              then Eliom_registration.Html5.send (callback p)
              else Eliom_registration.Redirection.send redirection
             )
          
        
      end
    
  end

