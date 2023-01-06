require_relative './user'
class UserAccountRepository

# Selecting all records
# No arguments
def all
  # Executes the SQL query:
  # SELECT id, email, user_name FROM user_accounts;
    sql = 'SELECT id, email, user_name FROM user_accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])

        users = []

        result_set.each do |record|
            user = User.new
            user.id = record['id']
            user.email = record['email']
            user.user_name = record['user_name']

            users << user
        end
        return users
  # Returns an array of User objects.
end

# Gets a single record by its ID
# One argument: the id (number)
def find(id)
  # Executes the SQL query:
  # SELECT id, email, user_name FROM user_accounts WHERE id = $1;;
    sql = 'SELECT id, email, user_name FROM user_accounts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    record = result_set[0]

    user = User.new
    user.id = record['id']
    user.email = record['email']
    user.user_name = record['user_name']

    return user
    
  # Returns a single User object.
end

# Add more methods below for each operation you'd like to implement.

def create(user)
    sql ='INSERT INTO user_accounts (email, user_name) VALUES ($1, $2);'
    sql_params = [user.email, user.user_name]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
end

def update(user)
    sql = 'UPDATE user_accounts SET email =$1, user_name = $2 WHERE id = $3'
    sql_params = [user.email, user.user_name, user.id]
    
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
end

def delete(id)
    sql = 'DELETE FROM user_accounts WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

end
end