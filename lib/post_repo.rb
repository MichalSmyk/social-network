require_relative './post'
class PostRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id,content, title, view, user_id FROM posts;
        sql = 'SELECT id,content, title, view, user_id FROM posts;'

        result_set = DatabaseConnection.exec_params(sql, [])

            posts = []

            result_set.each do |record|
                post = Post.new
                post.id = record['id']
                post.content = record['content']
                post.title = record['title']
                post.view = record['view']
                post.user_id = record['user_id']

                posts << post
            end
                return posts
      # Returns an array of Post objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id,content, title, view, user_id FROM posts WHERE id = $1;
        sql = 'SELECT id,content, title, view, user_id FROM posts WHERE id = $1;'
        sql_params = [id]

        result_set = DatabaseConnection.exec_params(sql, sql_params)

        record = result_set[0]

        post = Post.new
        post.id = record['id']
        post.content = record['content']
        post.title = record['title']
        post.view = record['view']
        post.user_id = record['user_id']

        return post
      # Returns a single Post object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(post)
     # Executes the SQL query:
      # `INSERT INTO posts (content, title, view, user_id) VALUES ($1, $2, $3, $4);
        sql = 'INSERT INTO posts (content, title, view, user_id) VALUES ($1, $2, $3, $4);'
        sql_params = [post.content, post.title, post.view, post.user_id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end
  
    def update(post)
     # Executes the SQL query:
      # UPDATE posts SET content = $1 ,title = $2, view = $3, user_id = $4 WHERE id = $5;
        sql = 'UPDATE posts SET content = $1 ,title = $2, view = $3, user_id = $4 WHERE id = $5;'
        sql_params = [post.content, post.title, post.view, post.user_id, post.id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
      # Returns nothing
    end
  
    def delete(id)
     # Executes the SQL query:
      # DELETE FROM posts WHERE id =$1;
        sql = 'DELETE FROM posts WHERE id =$1;'
        sql_params = [id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
      # Returns nothing
    end
end