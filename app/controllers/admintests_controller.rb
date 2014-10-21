class AdmintestsController < ApplicationController
	layout "admin"

	def index
		if (session[:user_id] == nil)
		  redirect_to '/', :notice => "Please sign in to access this page."
		else
		  @current_user = User.find(session[:user_id])
		  session[:current_user] = @current_user
		  @tests = Test.all
		end
	end

	def new
		@current_user = User.find(session[:user_id])
		@newTest = Test.new 
		@newTest.name = session[:test_name] = params[:test_name] 
		@newTest.save
		session[:test_id] = @newTest.id
		
	end

	def show

	end

	def edit
	end

end
