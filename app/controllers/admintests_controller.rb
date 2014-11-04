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

	# Questions

	def addQuestion
		puts "- - PARAMS - - "
	    puts YAML::dump(params)
	    puts "- - END OF PARAMS - - "
	    question = Test.find(session[:test_id]).questions.create
      	render json: { 	
      		status: 'success', 
      		test_id: session[:test_id],
      		question_id: question.id,
      	}
      	
	end

	def deleteQuestion
		puts "- - PARAMS - - "
	    puts YAML::dump(params)
	    puts "- - END OF PARAMS - - "
		Question.find(params[:question_no]).destroy
		render json: { status: true}
	end

	# Answers

	def addAnswer
		puts "- - PARAMS - - "
	    puts YAML::dump(params)
	    puts "- - END OF PARAMS - - "
		puts params[:question_id]
		answer = Test.find(session[:test_id]).answers.create(:question_id => params[:question_id])
		render json: {
			status: 'success',
			test_id: session[:test_id],
			question_id: params[:question_id],
			answer_id: answer.id
		}

	end

	def deleteAnswer
		
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
