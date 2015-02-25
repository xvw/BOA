
(* General configuration of Boa Application *)
let name = "Boa sample app"


(* Database configuration *)
module DB =
  struct

    let user = "nuki_psql"
    let password = "password"
    let database = "boa_sample"
    let host = "localhost"
    
  end
