class TestsController < ApplicationController
  require 'builder'
  layout "student"

  def index # Landing Page
  	@alltests = Test.all 
  end

  def create # Creates Test Instance from DB
  	session[:test_name] = params[:test_name]
  	session[:first_name] = params[:first_name]
  	session[:last_name] = params[:last_name]
  	redirect_to '/tests/pretest' # Redirects to New Test
  end

  def pretest # New Test
    if (params[:id])
      @test = Test.find(params[:id])
    else 
      @test = Test.find_by_name(session[:test_name])
    end
    session[:testNo] = Test.find(@test.id).id
    session[:testID] = @test.id.to_i
    session[:testSize] = @test.questions.count
  end

  def new # New Test
    session[:timeA] = Time.current().to_i
    @test = Test.find(session[:testID]) # CHANGE - Test ID?
    session[:testNo] = Test.find(@test.id).id
    session[:testID] = @test.id.to_i
    session[:testSize] = @test.questions.count
    @questions = @test.questions.all
    @firstQtimelimit = @test.questions.first.timelimit
  end

  def results
    session[:timeB] = Time.current().to_i
    userTotalTime = session[:timeB] - session[:timeA]
    testTotalTime = 5

    @totalTestTime = Array.new   
    Test.find(session[:testID]).questions.each do |ques| 
      testTotalTime += ques.timelimit
    end

    if(userTotalTime > testTotalTime)
      overtime = userTotalTime - testTotalTime
    else
      overtime = nil
    end

    @myArray = Array.new
    @myArray.push(session[:testID]) # Push in Test ID
    Test.find(session[:testID]).answers.select(:id, :question_id).where(:correct=>true).each do |line| 
      @myArray.push(line.id) # Push in Answer # for each question inline.
    end

    countCorrect = 0;
    countIncorrect = 0;

    params.each_with_index do |param, index|
      if index > 0 && index <= session[:testSize].to_i
        if param[1].to_i === @myArray.at(index).to_i
          countCorrect += 1
        else
          countIncorrect += 1
        end
      end
    end

    countTotalQuestions = (countCorrect.to_f + countIncorrect.to_f)
    countScore = "#{countCorrect} / #{countTotalQuestions}"
    test_number = "#{session[:testID]}"
    percentGradetemp = countCorrect/countTotalQuestions
    (percentGradetemp).round(2)
    percentGrade = percentGradetemp * 100
    finalGrade = percentGrade.round(2)
    Result.create(
      :test_id      => session[:testID], 
      :first_name   => session[:first_name],
      :last_name   => session[:last_name],
      :email   => session[:email],
      :score   => finalGrade,
      :test_name   => session[:test_name],
      :overtime => overtime
    )
    # END
    render :text => "<div class='formatted-div'><h3>Score Results</h3><h5>Number of Correct: #{countCorrect}</h5><h5>Number of Incorrect: #{countIncorrect}</h5><h2>Final Score: #{finalGrade}%</h2></div>"
  end

  def show # Show Test Results   	
  end























end
