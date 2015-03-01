open Eliom_lib
open Eliom_content
open Html5.D
open Lwt_ops
open Boa_ui

(* Layout elements *)
let fixed classes a fixed content =
  div
    ~a:(a@[a_class (fixed::classes)])
    content

let col ?(classes=[]) ?(a=[])  = fixed classes a "col"
let row ?(classes=[]) ?(a=[])  = fixed classes a "row"
let line ?(classes=[]) ?(a=[])  = fixed classes a "line"
let inblock ?(classes=[]) ?(a=[])  = fixed classes a "inbl"
let grid ?(classes=[]) ?(a=[]) grid_type content  =
  fixed classes a "grid" [div ~a:[a_class [grid_type]] content]

let autogrid ?(classes=[]) ?(a=[]) grid_type content =
  fixed classes a grid_type content


(* Simple button *)
let button ?(classes = []) a =
  div ~a:[a_class ("button"::classes)] [a]

(* Display an HTML5 Modal*)
let modal ?(classes = []) content =
  div
    ~a:[a_class ["container_modal"]]
    [div ~a:[a_class classes] content]

(* HTML5 Modal with title *)
let modal_with_title ?(classes=[]) ~title content =
  modal ~classes ([h1 [pcdata title]]@content)

(* Error Modal *)        
let error title content =
  modal_with_title
    ~classes:["error"]
    ~title:title
    [
      p [pcdata content];
      button
        ~classes:["error_btn"]
        (
          Link.service
            Eliom_service.void_coservice' ()
            "Reload the page"
        )
    ]
