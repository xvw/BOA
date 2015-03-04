open Eliom_lib
(* Table definition *)
let tasks_id_seq =
  <:sequence< serial "tasks_id_seq" >>
let table =
  <:table< tasks (
   task_id       integer NOT NULL DEFAULT(nextval $tasks_id_seq$),
   task_title    text    NOT NULL,
   task_priority integer NOT NULL, 
   task_state    boolean NOT NULL
   )>>

(* Projection *)
type t =
    { id       : int
    ; title    : string
    ; priority : int
    ; state    : bool
    }

    
(* Convert SQL value to Task.t *)
let project_task t =
  { id       = Int32.to_int (t#!task_id)
  ; title    = t#!task_title
  ; priority = Int32.to_int (t#!task_priority)
  ; state    = t#!task_state
  }

let add_task title priority =
  let prior = Int32.of_int priority
  and state = false in
  Boa_db.query
    <:insert< $table$ := 
     {
     task_id       = table?task_id; 
     task_title    = $string:title$; 
     task_priority = $int32:prior$;
     task_state    = $bool:state$
     }>>

let remove_task id =
  Boa_db.query
    <:delete< task in $table$  
     | task.task_id = $int32:(Int32.of_int id)$
     >>    
    
let set_state id value =
  Boa_db.query
    <:update< task in $table$ := 
     { task_state = $bool:value$} 
     | task.task_id = $int32:(Int32.of_int id)$
     >>

let open_task id = set_state id true
let close_task id = set_state id false

(* Retreive all tasks *)
let all () = 
  (Boa_db.view (<< row | row in $table$ >>))
  >|= (List.map project_task)
  >|= (List.sort (fun x y -> compare (x.id) (y.id)))

