class UsersController < ApplicationController
    include SessionsHelper
       layout "student"


  # R E G I S T R A T I O N
  
  def index
    reset_session
    flash.discard
  end

  def new
  end

  def create
    @user = User.new
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    if @user.save
      # USER CREATION - SUCCESS # render :text => 'SAVED'
      render json: { message: "Validation Failed - Please ensure all fields are populated.", status: 'success' }
    else
      # USER CREATION - FAILED # render :text => 'REROUTE'
      render json: { message: "Validation Failed - Please ensure all fields are populated.", status: 'failed' }
    end 

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
