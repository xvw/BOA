{shared{

open Eliom_lib
open Boa_core


}}

module Debug =
struct

  let view () =
    let open View in 
    Boa_skeleton.return
      "Sample geocode"
      [
        Raw.input
          ~a:[a_id "input-1"]
          ();
        Raw.input
          ~a:[a_id "input-2"]
          ();
      ]

  let main =
    Register.page
      ~path:["geo"]
      view

end

