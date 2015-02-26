(* This page provide a layout for Boas application *)
open Eliom_content
open Html5.D

(* Generic page wrapper *)
let raw title content =
  Eliom_tools.F.html
    ~title:title
    ~css:[["css"; "boa.css"]]
    (Html5.F.body content)

(* Generic page returner *)
let return title content =
  raw title content
  |> Lwt.return
