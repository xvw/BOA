CREATE SEQUENCE users_id_seq; 
CREATE TABLE users (
  user_id integer PRIMARY KEY,
  user_name text NOT NULL,
  user_password text NOT NULL,
  user_mail text NOT NULL
);
