(* This page provide a layout for Boas application *)
open Eliom_content
open Html5.D

(* Generic page wrapper *)
let raw title content =
  Eliom_tools.F.html
    ~title:title
    ~css:[["css"; "boa.css"]]
    (Html5.F.body content)
  |> Lwt.return
