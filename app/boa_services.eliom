open Eliom_content
open Eliom_parameter
open Boa_core

(* Common services interface *)
module Common =
  struct

    module Gravatar =

      struct

        let get mail =
          let md5mail = Util.md5 mail in
          Eliom_service.Http.external_service
            ~prefix:"http://www.gravatar.com"
            ~path:["avatar"; md5mail]
            ~get_params:(int "s" ** string "d")
            ()                         
            
      end 
  end
       
(* Custom services registration *)
(* Entry point for service regsitration *)
module Custom =
  struct

    
  end
