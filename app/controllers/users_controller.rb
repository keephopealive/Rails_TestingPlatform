class UsersController < ApplicationController
    include SessionsHelper

  # R E G I S T R A T I O N
  
  def index
    reset_session
    flash.discard
  end

  def new
  end

  def create
    @user = User.new
    @user.first_name = flash[:first_name] = params[:first_name]
    @user.last_name = flash[:last_name] = params[:last_name]
    @user.email = flash[:email] = params[:email]
    @user.password = params[:password]
    @user.save
    if @user.save
      # USER CREATION - SUCCESS # render :text => 'SAVED'
      flash.discard 
      flash[:error] = "Successful Registration"
      redirect_to '/'
    else
      # USER CREATION - FAILED # render :text => 'REROUTE'
      flash[:error] = "Successful Registration"
      redirect_to '/'
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
