CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email text,
  user_name text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  content text,
  title text,
  view int,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references user_accounts(id)
    on delete cascade
);