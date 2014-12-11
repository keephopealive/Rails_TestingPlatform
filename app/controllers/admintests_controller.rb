class AdmintestsController < ApplicationController
	layout "admin"

# Admin Landing Page
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

# Test Render View
	def new
		@newTest = Test.new 
		@newTest.name = session[:test_name] = params[:test_name] 
		@newTest.save
		session[:test_id] = params[:id] = @newTest.id
		redirect_to :controller => 'admintests', :action => 'edit', :id => @newTest.id
	end
# Ajax	
	def edit
		session[:test_id] = params[:id]
		@currentTest = Test.find(params[:id])
	end
	def destroy 
		test = Test.find(params[:id]).destroy
		redirect_to admintests_path
	end


# Render View
	def show # Show User Results:
		@results = Result.all
		# @results = Result.paginate :page => params[:page], :per_page => 30
		# @results = Result.paginate(:page=> params[:page], :per_page=>10)
	end

# Ajax
	def getNames
		@results = Result.where(Result.arel_table[:first_name].matches("%#{params[:name]}%").or(Result.arel_table[:last_name].matches("%#{params[:name]}%")))
		render :file => "partials/results-table.html.erb", :layout => false, collection: @results
	end
	def getEmails
		@results = Result.where(Result.arel_table[:email].matches("%#{params[:email]}%"))
		render :file => "partials/results-table.html.erb", :layout => false, collection: @results
	end
	def updateTestDescription
		result = Test.find(session[:test_id]).update(:description => params[:description])
		render json: {
			type: 'updateTestDescription',
			status: 'success'
		}
	end
	def updateTestNameUrl
		result = Test.find(session[:test_id]).update(:name => params[:testName], :url => params[:url])
		render json: {
			type: 'updateTestDescription',
			status: 'success'
		}
	end

# Questions
# Ajax
	def addQuestion
	    question = Test.find(session[:test_id]).questions.create(:timelimit => 999)
		session[:tempQuestion_id] = question.id # <- Moving Variables into file.
		render :file => "partials/add-question.html.erb", :layout => false
	end
	def saveQuestion
	    Question.find(params[:question_id]).update(:question=>params[:question])
		render json: {
			type: 'saveQuestion',
			status: 'success'
		}		
	end
	def deleteQuestion
		puts YAML::dump(params)
		Question.find(params[:question_id]).destroy
		Answer.where(:question_id => params[:question_id]).destroy_all
		render json: { status: true}
	end
	def updateQuestionTimer
		Question.find_by_id(params[:question_id]).update(:timelimit => params[:timelimit])
		render json: { 
			type: 'updateQuestionTimer',
			status: 'success'
		}
	end

# Answers
# Ajax
	def addAnswer
		puts "CAME HERE"
		answer = Test.find(session[:test_id]).answers.create(:question_id => params[:question_id])
		session[:tempQuestion_id] = params[:question_id] # <----------------- Moving Variables into file.
		session[:tempAnswer_id] = answer.id
		session[:tempAuthTok] = form_authenticity_token
		puts session[:tempAuthTok]
		render :file => "partials/add-answer.html.erb", :layout => false
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
	def deleteAnswer
	    Answer.find(params[:answer_id]).destroy
		render json: {
			status: 'success',
			test_id: session[:test_id],
			question_id: params[:question_id],
		}
	end
	def updateAnswerTimeLimit
		Question.find(params[:question_id]).update(:timelimit=>params[:timelimit])		
		render json: {
			type: 'updateAnswerTimeLimit',
			status: 'success'
		}
	end
end
