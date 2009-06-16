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
      @bugs = Bug.find(:all)
      bugsbycompany = \
        (params[:user][:company_name].blank? ? nil : Bug.find_all_by_user_id( \
                       User.find_by_company_name(params[:user][:company_name])))
      
      bugsbyname = \
        (params[:user][:name].blank? ? nil : Bug.find_all_by_user_id( \
                    User.find_by_name(params[:user][:name])))
      
      bugsbysubmitter = \
        (params[:bug][:submitter].blank? ? nil : Bug.find_all_by_submitter( \
                                                    params[:bug][:submitter]))

      @bugs.delete_if {|x| !bugsbycompany.include?(x)} if bugsbycompany
      @bugs.delete_if {|x| !bugsbyname.include?(x)} if bugsbyname
      @bugs.delete_if {|x| !bugsbysubmitter.include?(x)} if bugsbysubmitter
      
    end
  end

end
