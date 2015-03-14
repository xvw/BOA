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
    let atomic_form ~service form =
      post_form ~service form ()
  end

module Service =
  struct

    let register ~service callback =
      Boa_app.register
        ~service:service
        callback

    let curry ~service params =
      Eliom_service.preapply params

    let self = Eliom_service.void_coservice'

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

        let atomic callback =
          post
            ~params:Eliom_parameter.unit
            (fun _  -> callback ())
        
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

           
    (* Redirection *)
    module Redirection =
      struct

        let get ~path ~params callback =
          Eliom_registration.Redirection.register_service
            ~path
            ~get_params:params
            (fun x _ -> callback x)

        let page ~path callback = 
          get
            ~path
            ~params:Eliom_parameter.unit
            callback
            
        let post ~fallback  ~params callback =
          Eliom_registration.Redirection.register_post_service
            ~fallback
            ~post_params:params
            (fun _ x -> callback x)
        
      end

    (* Polymorphic services *)
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


module Util =
  struct

    let as_token s =
      String.(trim (lowercase s))
                              
    let md5 s =
      let value = as_token s in
      Digest.(to_hex (string value))

    let password_hash s =
      Bcrypt.(string_of_hash (hash s))

    let password_check hashcode s =
      Bcrypt.(verify s (hash_of_string hashcode))
    
  end

module Check =
  struct

    let is_email s =
      let mail = Util.as_token s
      and regexp = Str.regexp "\\([^<>(),; \t]+@[^<>(),; \t]+\\)" in
      Str.string_match regexp mail 0

    let password = Util.password_check

  end

module Email =
  struct

    let is_valide = Check.is_email
    
  end

module Password =
  struct

    let hash = Util.password_hash
    let check = Util.password_check

  end

{shared{    
     module List =
       struct
         
         include List
                   
         let range fprev fnext a b =
           let f = if a < b then fprev else fnext in 
           let rec range acc x =
             if x = (f a) then acc
             else range (x::acc) (f x)
           in range [] b
                    
         let seed = range pred succ
         let (-->) = seed
                       
       end
   }}

{shared{


     module Math =
       struct

         let pi = 3.14159265358979323846

       end
         
     
   }}
