module Products

    def get_products(db)
        products = db.execute('SELECT * FROM products')
        return products
    end
end