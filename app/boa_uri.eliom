(* Collection of Uri's *)

(* Retreive url of a gravatar picture *)
let gravatar ?(width=100) ?(default="identicon") mail =
  Eliom_content.Html5.F.make_uri
    ~service:(Boa_services.Common.Gravatar.get mail)
    (width, default)

