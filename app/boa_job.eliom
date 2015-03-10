(* Job helper *)
{shared{
     open Eliom_content
     open Html5
     open Boa_core
     let (>>=) = Lwt.bind
     let cancle job = Lwt.cancel job
}}

{client{
     (* Process a continous job on background *)
     let rec continous ?(delay=1.0) f =
       let _ = f () in
       Lwt_js.sleep delay
       >>= (fun _ -> continous ~delay f)

 }}

{server{

     let rec continous ?(delay=1.0) f =
       let _ = f () in
       Lwt_unix.sleep delay
       >>= (fun _ -> continous ~delay f)
     
}}
