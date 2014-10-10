class TestsController < ApplicationController
  
  def index # Landing Page
  	# Take Test Form Redirect to Create
  	@alltests = Test.all
  end


  def create # Creates Test Instance from DB
  	session[:test_name] = params[:test_name]
  	session[:first_name] = params[:first_name]
  	session[:last_name] = params[:last_name]
  	redirect_to '/tests/new' # Redirects to New Test
  end

  def new # New Test
  	@test = Test.find_by_name(session[:test_name])
    session[:testSize] = @test.questions.count
    @questions = @test.questions 
  end

  def results
    puts params.inspect
    puts YAML::dump(params)
    render :text => "RESULTS"
  end

  def show # Show Test Results
   	  	
  end

end
