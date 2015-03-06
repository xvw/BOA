open Eliom_lib

let users_id_seq =
  <:sequence< serial "users_id_seq" >>

let table =
  <:table< users (
   user_id       integer NOT NULL DEFAULT(nextval $users_id_seq$),
   user_name     text    NOT NULL,
   user_password text    NOT NULL,
   user_mail     text    NOT NULL
   )>>
