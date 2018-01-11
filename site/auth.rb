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
        db.execute("INSERT INTO users(email, name, password) VALUES(?, ?, ?)",
        [email, name, password])
    end
end