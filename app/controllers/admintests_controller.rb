class AdmintestsController < ApplicationController
	layout "admin"

	def index
		if (session[:user_id] == nil)
		  redirect_to '/', :notice => "Please sign in to access this page."
		else
		  @current_user = User.find(session[:user_id])
		  session[:first_name] = @current_user.first_name
		  session[:last_name] = @current_user.last_name
		  session[:email] = @current_user.email
		  @tests = Test.all
		end
	end

	def new
		@current_user = User.find(session[:user_id])
		@newTest = Test.new 
		@newTest.name = session[:test_name] = params[:test_name] 
		@newTest.save
		params[:test_id] = @newTest.id
		redirect_to 'admintests/edit/:id'
	end

	def show

	end

	def update

	end

	def addQuestion
		puts "- - PARAMS - - "
	    puts YAML::dump(params)
	    puts "- - END OF PARAMS - - "
	    puts params[:testNo]
	    puts Test.find(params[:testNo]).questions.create
      	render json: { status: 'success'}
      	
	end

	def deleteQuestion
		puts "- - PARAMS - - "
	    puts YAML::dump(params)
	    puts "- - END OF PARAMS - - "
		Question.find(params[:question_no]).destroy
		render json: { status: 'success'}
	end


	def edit
		session[:test_id] = params[:id]
		@currentTest = Test.find(params[:id])
	end

	def destroy 
		test = Test.find(params[:id]).destroy
		redirect_to admintests_path
	end

end
