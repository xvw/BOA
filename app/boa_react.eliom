(* Provide a small Reactive library *)
{shared{
open Eliom_content
open Html5

let (>>=) = Lwt.bind

type 'a react_hanlder = {
  signal :'a React.signal;
  callback : (?step:React.step -> 'a -> unit)
}

let create value =
  let signal, handler = React.S.create value in
  {
    signal = signal;
    callback = handler
  }

let set handler value =
  handler.callback value
let map f handler = React.S.map f handler.signal
let apply f handler =
  handler.callback (f (React.S.value handler.signal)) 

}}



let iterate ?(step=1.0) value f =
  let handler = create value in
  Lwt.async
    (fun () ->
     Boa_job.continous
       (fun () -> 
        apply f handler;
        Lwt.return_unit
       )
    );
  Eliom_react.S.Down.of_react
    ~scope:`Site
    (handler.signal)


let node content = C.node content
