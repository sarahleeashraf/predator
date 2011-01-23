class AdminController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        session[:user_role] = user.role
        redirect_to(:action => 'index')
      else
        flash.now[:notice] = "Invalid email/password combination"
      end
    end
  end

  def logout
  end

  def index
  end

end
