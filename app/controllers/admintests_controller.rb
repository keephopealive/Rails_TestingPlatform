class AdmintestsController < ApplicationController
	layout "admin"

	def index
		if (session[:user_id] == nil)
		  redirect_to '/', :notice => "Please sign in to access this page."
		else
		  @current_user = User.find(session[:user_id]) # CHANGE - [:user][:first_name] etc
		  session[:first_name] = @current_user.first_name
		  session[:last_name] = @current_user.last_name
		  session[:email] = @current_user.email
		  @tests = Test.all
		end
	end

	def new
		@newTest = Test.new 
		@newTest.name = session[:test_name] = params[:test_name] 
		@newTest.save
		session[:test_id] = params[:id] = @newTest.id
		@currentTest = Test.find(@newTest.id)
		render "admintests/edit"
	end

	# Questions

	def addQuestion
	    question = Test.find(session[:test_id]).questions.create(:timelimit => 999)
		session[:tempQuestion_id] = question.id # <- Moving Variables into file.
		render :file => "partials/add-question.html.erb", :layout => false
	end

	def deleteQuestion
		Question.find(params[:question_id]).destroy
		Answer.where(:question_id => params[:question_id]).destroy_all
		render json: { status: true}
	end

	# Answers

	def addAnswer
		puts "CAME HERE"
		answer = Test.find(session[:test_id]).answers.create(:question_id => params[:question_id])
		session[:tempQuestion_id] = params[:question_id] # <----------------- Moving Variables into file.
		session[:tempAnswer_id] = answer.id
		session[:tempAuthTok] = form_authenticity_token
		puts session[:tempAuthTok]
		render :file => "partials/add-answer.html.erb", :layout => false
	end

	def deleteAnswer
	    Answer.find(params[:answer_id]).destroy
		render json: {
			status: 'success',
			test_id: session[:test_id],
			question_id: params[:question_id],
		}
	end

	def saveQuestion
	    Question.find(params[:question_id]).update(:question=>params[:question])
		render json: {
			type: 'saveQuestion',
			status: 'success'
		}		
	end

	def updateAnswer
		if params[:answerValue] == 'true'
			answer = true
		else
			answer = false
		end
		Answer.find(params[:answer_id]).update(:answer=>params[:answer], :correct=>answer)
		render json: {
			type: 'updateAnswer',
			status: 'success'
		}	
	end

	def updateAnswerTimeLimit
		Question.find(params[:question_id]).update(:timelimit=>params[:timelimit])		
		render json: {
			type: 'updateAnswerTimeLimit',
			status: 'success'
		}
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
