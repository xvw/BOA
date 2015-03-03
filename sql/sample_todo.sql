-- Example d'une todoliste simple
CREATE SEQUENCE tasks_id_seq; 
CREATE TABLE tasks (
  task_id integer PRIMARY KEY,
  task_title text NOT NULL,
  task_priority integer NOT NULL,
  task_state integer NOT NULL
);
