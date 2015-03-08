(* Provide a small Reactive library *)
{shared{
open Eliom_content
open Html5


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

let map f handler = React.S.map f handler.signal
let apply f handler =
  handler.callback (f (React.S.value handler.signal)) 

let node value = C.node value                   

}}
