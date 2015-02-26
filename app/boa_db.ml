(* Database Helper for PGSql connection *)

module Lwt_thread = struct
  include Lwt
  include Lwt_chan
end 
module Lwt_PGOCaml = PGOCaml_generic.Make(Lwt_thread)
module Lwt_Query = Query.Make_with_Db(Lwt_thread)(Lwt_PGOCaml)
                                     
let connect () = 
  Lwt_PGOCaml.connect 
    ~host:Boa_config.Db.host
    ~user:Boa_config.Db.user
    ~password:Boa_config.Db.pass
    ~database:Boa_config.Db.name
    ()

let pool  =
  fun () -> (
    Lwt_pool.create 
      16 
      ~validate:Lwt_PGOCaml.alive 
      connect
  )

let use f ?log x = 
  Lwt_pool.use 
    (pool ()) 
    (fun db -> f db ?log  x)


(* Common API *)
let view ?log x = 
  use Lwt_Query.view ?log x
      
let view_one ?log x = 
  use Lwt_Query.view_one ?log x
      
let view_opt ?log x = 
  use Lwt_Query.view_opt ?log x

let query ?log x = 
  use Lwt_Query.query ?log x

let value ?log x = 
  use Lwt_Query.value ?log x

let value_opt ?log x = 
  use Lwt_Query.value_opt ?log x
