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
		email = params[:email]
		password = params[:password]

		id = login_user(email, password)
		if id == -1
			return redirect('/account/login')
		end

		return redirect('/')
	end

	get '/account/register' do
		slim(:register)
	end

	post '/account/register' do
		email = params[:email].strip
		name = params[:name].strip
		password = params[:password]
		password_confirm = params[:password_confirm]
		puts "Password: #{password}, confirm: #{password_confirm}"

		if password != password_confirm
			puts "Passwords don't match!"
			return redirect('/account/register')
		end

		db = open_database()
		user = get_user_by_email(email, db)
		if user != nil
			puts "User with email '#{email}' already exists!"
			return redirect('/account/register')
		end
		register_user(email, name, password, db)

		return redirect('/')
	end
end
