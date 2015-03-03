open Eliom_lib
open Eliom_parameter
open Boa_core

(* services *)

let add_task =
  Define.Action.post
    ~params:(
      (string "title")
      ** (int "priority")
    )
    (fun (title, prior) ->
     Db_task.add_task title prior
    )

let close_task =
  Define.Action.get
    ~params:(int "task_id")
    (fun id -> Db_task.close_task id)


let open_task =
  Define.Action.get
    ~params:(int "task_id")
    (fun id -> Db_task.open_task id)

    
(* view *)
let priority x =
  let (klass, text) = match x.Db_task.priority with
    | 0 -> "weak_btn", "basse"
    | 1 -> "normal_btn", "normale"
    | _ -> "strong_btn", "haute"
  in Boa_gui.button
       ~classes:["label_btn";klass]
       (View.pcdata text)

let state x =
  let text, service, klass =
    if x.Db_task.state
    then ("Open", close_task, "close-task")
    else ("Close", open_task, "open-task")
  in
  Boa_gui.button
    ~classes:["label_btn"; klass]
    (Boa_ui.Link.service service x.Db_task.id text)
  
    
let define_class x =
  if x.Db_task.state
  then ["task_finished"]
  else ["task_unfinished"]

         
let wrap_tasks =
  let open View in
  List.map
    (fun x ->
     tr
       [
         td
           ~a:[a_class (["w66"; "task"] @ (define_class x))]
           [pcdata x.Db_task.title];
         td [priority x];
         td [state x];
       ]
    )
    
       
let tasks () =
  let open View in
  let h =
    tr ~a:[a_style "background-color:#f2f2f2"]
      [
        th ~a:[a_class ["w66"; "vertical"]] [pcdata "Titre"];
        th [pcdata "Priorité"];
        th [pcdata "Flip/Flop"];
      ]
  in 
  (Db_task.all ()) >|=
    (function
      | [] -> pcdata "Il n'y a pas de tâche en cours"
      | x -> table ([h]@wrap_tasks x)
    )

let add_form (task_title, task_prior) =
  let open View in 
  [div
     ~a:[a_class ["input_task"]]
     [
       string_input
         ~a:[a_placeholder "Tâche à réaliser"]
         ~input_type:`Text
         ~name:task_title
         ();
       int_select
         ~name:task_prior
         (Option ([], 0, Some (pcdata "Priorité basse"), false))
         [
           Option ([], 1, Some (pcdata "Priorité normale"), false);
           Option ([], 2, Some (pcdata "Priorité haute"), false);
         ];
       string_input
         ~input_type:`Submit
         ~value:"Submit task"
         ()
     ]
  ]
    
let view () =
  lwt t =tasks () in
  let form = View.post_form add_task add_form () in 
  Boa_skeleton.return
    "Todo list"
    [
      Boa_gui.modal_with_title
        ~classes:["boa_box"]
        ~title:"Tâches à réaliser !"
        (form::[t])
    ]
