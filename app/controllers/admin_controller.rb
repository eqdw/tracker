class AdminController < ApplicationController



  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:admin] = user.admin?
        redirect_to_index(:controller => session[:admin] ? "admin" : "bugs")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:admin] = nil
    redirect_to_index :notice => "Logged Out Successfully"
  end

  def index
    @bugs = nil
    if request.post?
      @bugs = Bug.find_all_by_user_id(User.find_by_name(params[:username]))
    end
  end

end
