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
    session[:testNo] = Test.find(@test.id)
    session[:testSize] = @test.questions.count
    @questions = @test.questions 
  end

  def results
    puts "- - PARAMS - - "
    puts YAML::dump(params)
    puts "- - END OF PARAMS - - "
    
    # if params[0]

    # Param 0 == Test ID
    # Test.first.answers.where(:correct=>true).each do |answer|
    #   answer.id
    # end
    
    # Param 1.. == Test Questio ID

    @myArray = Array.new
    @myArray.push(1) # Push in Test ID
    Test.first.answers.select(:id, :question_id).where(:correct=>true).each do |line| 
      @myArray.push(line.id) # Push in Answer # for each question inline.
    end
    puts "Correct Answer Array: #{@myArray}"

    @myArray.each_with_index { |x, index|

    }

    params.each_with_index do |param, index|
      if index > 0 && index <= session[:testSize].to_i
        if param[1].to_i === @myArray.at(index).to_i
          puts "ANSWER CORRECT #{@myArray.at(index)}"
        else
          puts "ANSWER INCORRECT"
        end

      end

    #   puts " ARRAY #{@myArray[index]}"
      # if param[0] != '0'
    #     puts "index #{index} key #{param[0]} value #{param[1]}"
    #     if @myArray[index] == param[1]
    #       puts "CORRECT #{@myArray[index]} #{param[1]}"
    #     else
    #       puts "INCORRECT"
    #     end
    #     # This is the test ID = param[1]
    #   else 
    #     # Test.first.answers.where(:correct=>true, :question_id=>param[0]).id
    #     puts "TEST NUMBER index #{index} key #{param[0]} value #{param[1]}"
    #   end
    end


    render :text => "RESULTS"
  end

  def show # Show Test Results
   	  	
  end

end
