require 'session'

module Auth
    
    def open_database()
        db = SQLite3::Database.new('db/db.sqlite3')
        db.results_as_hash = true
        return db
    end

    def get_user_by_id(id, db)
        users = db.execute("SELECT * FROM users WHERE id = #{id}")
        if users.length == 0
            return nil
        end
        return users[0]
    end

    def get_user_by_email(email, db)
        users = db.execute("SELECT * FROM users WHERE email = '#{email}'")
        if users.length == 0
            return nil
        end
        return users[0]
    end

    def register_user(email, name, password, db)
        password_encrypted = BCrypt::Password.create(password)
        db.execute("INSERT INTO users(email, name, password) VALUES(?, ?, ?)",
        [email, name, password_encrypted])
        session[:user_id] = id
    end

    def login_user(email, password, db)
        users = db.execute("SELECT * FROM users WHERE email = '#{email}'")
        if users.length == 0
            return -1
        end

        user = users[0]
        if BCrypt::Password.new(user['password']) == password
            id = user['id']
            session[:user_id] = id
            return id
        end

        return -1
    end

    def get_user_id()
        id = session[:user_id]
        if id == nil
            return -1
        end
        return id
    end

    def is_logged_in()
        return get_user_id() != -1
    end
end