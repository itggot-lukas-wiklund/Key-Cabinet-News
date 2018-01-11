require_relative 'auth.rb'
include Auth
require 'session'

class App < Sinatra::Base

	get '/' do
		slim(:index)
	end

	get '/account/login' do
		slim(:login)
	end

	post '/account/login' do

	end

	get '/account/register' do
		slim(:register)
	end

	post '/account/register' do
		email = params[:email].strip
		name = params[:name].strip
		password = params[:password]
		password2 = params[:password_confim]

		if password != password2 && false
			puts "Passwords don't match!"
			return slim(:register)
		end

		db = open_database()
		user = get_user_by_email(email, db)
		if user != nil
			puts "User with email '#{email}' already exists!"
			return slim(:register)
		end
		register_user(email, name, password, db)

		slim(:register)
	end
end
