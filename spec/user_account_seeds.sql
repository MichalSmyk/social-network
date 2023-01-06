TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email, user_name) VALUES ('example@example.com', 'unicorn');
INSERT INTO user_accounts (email, user_name) VALUES ('lalala@blablabla.com', 'butterfly');
INSERT INTO posts (content, title, view, user_id) VALUES ('first content', 'first title', 25, 1);
INSERT INTO posts (content, title, view, user_id) VALUES ('second content', 'second title', 15, 2);
