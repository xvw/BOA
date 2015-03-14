(* Mapbox API *)
{shared{
     open Eliom_content
     open Html5
     open Boa_core
     let (>>=) = Lwt.bind
     let access = "pk.eyJ1IjoiYW5kcmVhZW4i"
     let token = "LCJhIjoiYjNPT0RtYyJ9.B1gFZrq5axjQ5hKDI0Tn1w"
     let access_token = access ^ token
   }}

{client{

     let append elt map_id = 
       let mapbox =
         let l = Js.Unsafe.variable "L" in
         l ## mapbox
       in
       let _ = (mapbox ## accessToken <- access_token) in
       let m = mapbox ## map (Js.string elt, Js.string map_id) in
       m

     let focusOn map x y zoom =
       let coords = Js.array [|x;y|] in
       map ## setView (coords, zoom)
       

   }}

