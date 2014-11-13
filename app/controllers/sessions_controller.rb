class SessionsController < ApplicationController
  include SessionsHelper
  
  # L O G I N 

  def new
    # Renders view page for new login form
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
      session[:error] = "Invalid Credentials."
      redirect_to '/'
    else
      session[:user_id] = user.id
      redirect_to '/admintests'
    end
  end

  def show # Change - Delete all unnecessary lins of code / unsued code

  end

  def destroy
    session[:user_id] = nil
    current_user = nil
    redirect_to '/'
  end

end
