(* Canvas Helper ! *)
{shared{
     open Eliom_lib
     open Eliom_content
     open Html5
     open Boa_core
}}

{client{

     let doc = Dom_html.document
     let color c = Js.string c
     let map_couple f (x, y) = (f x, f y)

     let cap_style style =
       let s =  match style with
         | `Round -> "round"
         | `Square -> "square"
         | _ -> "butt"
       in Js.string s

     let join_style style =
       let s = match style with
         | `Bevel -> "bevel"
         | `Round -> "round"
         | _ -> "mitter"
       in Js.string s

     let create width height  =
       let canvas = Dom_html.createCanvas doc in
       let _ = canvas ## width <- width in 
       let _ = canvas ## height <- height in
       canvas

     let append canvas elt =
       let dom_elt = To_dom.of_element elt in
       Dom.appendChild dom_elt canvas

     let createIn width height elt =
       let canvas = create width height in
       let _ = append canvas elt in
       canvas

     let context canvas =
       canvas ## getContext(Dom_html._2d_)

     module Context =
       struct

         let get canvas = context canvas

         let wrap_optn f ctx = function
           | Some x -> f ctx x
           | _ -> ()
                                  
         let fill ctx c =
           let _ = ctx ## fillStyle <- (color c) in
           ctx ## fill ()

         let fill_rect ctx c rect =
           let _ = ctx ## fillStyle <- (color c) in
           ctx ## fillRect rect

         let stroke ctx c =
           let _ = ctx ## strokeStyle <- (color c) in
           ctx ## stroke ()

         let shape ctx fill_color stroke_color =
           function
           | point :: point_list -> 
              let _ = ctx ## beginPath () in
              let _ = ctx ## moveTo point in
              let _ = List.iter (fun x -> ctx ## lineTo x) point_list in
              let _ = ctx ## closePath () in 
              let _ = wrap_optn fill ctx fill_color in 
              wrap_optn stroke ctx stroke_color
           | _ -> ()

         let closedShape ctx fill_color stroke_color =
           function
           | (point :: point_list :: xs) as p ->
              shape ctx fill_color stroke_color (p @ [point])
           | _ -> ()

         let lineJoin ctx style = ctx ## lineJoin (join_style style)
         let lineCap ctx style = ctx ## lineCap (cap_style style)
 
                                     
         let fillRect ctx c x y w h  =
           let _ = ctx ## fillStyle <- (color c) in
           ctx ## fillRect (x, y, w, h)

         let strokeRect ctx c x y w h =
           let _ = ctx ## strokeStyle <- (color c) in
           ctx ## strokeRect (x, y, w, h)

         let curve ?(dir = true) ctx f_color s_color x y r angle angle_end =
           let d = if dir then Js._true else Js._false in 
           let _ = ctx ## beginPath () in
           let _ = ctx ## arc (x, y, r, angle, angle_end, d) in
           let _ = wrap_optn fill ctx f_color in
           wrap_optn stroke ctx s_color

         let circle ctx f_color s_color x y r =
           curve ctx f_color s_color x y r 0. (Math.pi *. 2.)

         let lineSize ctx x =
           ctx ## lineWidth <- (Js.float x)

       end
     
}}

let create width height container =
  let _ =
    {unit{
         createIn %width %height %container
         |> ignore
     }} in () 
  
