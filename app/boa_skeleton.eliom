(* This page provide a layout for Boas application *)
open Eliom_content
open Html5.D

(* Generic page wrapper *)
let raw title content =
  Eliom_tools.F.html
    ~title:title
    ~css:[["css"; "boa.css"]]
    ~other_head:[
      meta
        ~a:[a_name "viewport"; a_content "width = device-width"]
        ()
    ]
    (Html5.F.body content)

(* Generic page returner *)
let return title content =
  raw title content
  |> Lwt.return
