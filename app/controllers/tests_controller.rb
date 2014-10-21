class TestsController < ApplicationController
  require 'builder'
  layout "student"

  def index # Landing Page
  	# Take Test Form Redirect to Create
    reset_session
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
    session[:testNo] = Test.find(@test.id)
    session[:testID] = @test.id.to_i
    session[:testSize] = @test.questions.count
    @questions = @test.questions 
  end

  def results
    puts "- - PARAMS - - "
    puts YAML::dump(params)
    puts "- - END OF PARAMS - - "

    @myArray = Array.new
    @myArray.push(1) # Push in Test ID
    Test.first.answers.select(:id, :question_id).where(:correct=>true).each do |line| 
      @myArray.push(line.id) # Push in Answer # for each question inline.
    end

    countCorrect = 0;
    countIncorrect = 0;

    params.each_with_index do |param, index|
      puts " "
      if index > 0 && index <= session[:testSize].to_i
        puts " - - - - = = = = Question ##{param[0]} = = = = - - - - "
        puts "Question: ##{param[0]} (presented to user)"
        puts "Answer: ##{param[1]} (chosen by user)"
        puts "Actual: ##{@myArray.at(index).to_i} (actual answer)"
        if param[1].to_i === @myArray.at(index).to_i
          puts "Result: - = CORRECT = -"
          countCorrect += 1
        else
          puts "Result: - = INCORRECT = -"
          countIncorrect += 1
        end
        puts " - - - - = = = = END = = = = - - - - "
        puts " "
      end
    end

    countTotalQuestions = (countCorrect.to_f + countIncorrect.to_f)
    countScore = "#{countCorrect} / #{countTotalQuestions}"
    test_number = "#{session[:testID]}"
    percentGradetemp = countCorrect/countTotalQuestions
    (percentGradetemp).round(2)
    percentGrade = percentGradetemp * 100
    finalGrade = percentGrade.round(2)
    xml_markup = Builder::XmlMarkup.new
    xml_markup.instruct! :xml, :encoding => "UTF-8", :version => "1.0"
    xml_markup.student do |student|
      student.first_name("#{session[:first_name]}")
      student.last_name("#{session[:last_name]}")
      student.test_number("#{test_number}")
      student.totalQuestions("#{countTotalQuestions}")
      student.totalCorrect("#{countCorrect}")
      student.totalIncorrect("#{countIncorrect}")
      student.grade("#{finalGrade}")
    end

    Result.create(:test_id=>session[:testID], :xml_result => xml_markup)


    render :text => "<div class='formatted-div'><h3>Score Results</h3><h5>Number of Correct: #{countCorrect}</h5><h5>Number of Incorrect: #{countIncorrect}</h5><h2>Final Score: #{finalGrade}%</h2></div>"
  end

  def show # Show Test Results
   	  	
  end


end
