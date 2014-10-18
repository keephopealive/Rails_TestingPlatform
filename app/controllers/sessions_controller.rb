class SessionsController < ApplicationController
    include SessionsHelper

  # L O G I N 

  def new
    # Renders view page for new login form
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      redirect_to '/'
    else
      sign_in user
    end
  end

  def show
    deny_access if (session[:user_id] == nil)
    @user = User.find(session[:user_id])
    @nonfriends = User.all-@user.friends
  end

  def destroy
    sign_out_redirect
  end

end
