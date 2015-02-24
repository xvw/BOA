(* Entry point of an application. This file is for *)
(* services registration. *)

module Boa_app =
  Eliom_registration.App
    (
      struct
        let application_name = Config.name
      end
    )
