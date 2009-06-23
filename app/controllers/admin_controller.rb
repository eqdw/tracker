class AdminController < ApplicationController



  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:admin] = user.admin?
        redirect_to_index(:controller => (session[:admin] ? "admin" : "bugs"))
      else
        redirect_to_index :notice => "Invalid Username/Password Combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:admin] = nil
    redirect_to_index :notice => "Logged Out Successfully"
  end

  def index
    @companies = Company.find(:all)
    @users = User.find(:all)
    if request.post?

      if( ! params[:user][:id].blank?)
        @bugs = Bug.find_all_by_user_id(params[:user][:id])
      elsif ( ! params[:company][:id].blank?)
        @bugs = Bug.find_all_by_user_id(
                   User.find_all_by_company_id(params[:company][:id]))
      else
        @bugs = Bug.find(:all)
      end
      
    end
  end

  


########################################################################
######################KEPT FOR POSTERITY################################
########################################################################

# this code will no longer work. However, it was kept to show how awesome
# Stef and Burke are at rails, compared to Tim.


# # Stef's trying too!
#   def index
#     params[:user] ||= {}
#     params[:bug] ||= {}
    
#     conditions = {}
#     conditions[:"users.company_name"] = params[:user][:company_name] if params[:user][:company_name]
#     conditions[:"users.name"] = params[:user][:name] if params[:user][:name]
#     conditions[:"bugs.submitter"] = params[:bug][:submitter] if params[:bug][:submitter]
    
#     @bugs = Bug.find( :all, :joins => :user, :conditions => conditions)
#   end
 


  
# # Thanks, burke!
#   def index
#     if request.post?

#       mappings = Hash.new{|k,v|v}

#       user_attrib = {:company_name => params[:user][:company_name],
#         :name => params[:user][:name]}.reject{|k,v| v.blank?}

#       bug_attrib  = {:submitter => params[:bug][:submitter]}.reject{|k,v| v.blank?}
      
#       if user_attrib
#         user = User.find(:first, :conditions => user_attrib)
#         bug_attrib.merge!({:user_id => user})
#       end

#       @bugs = Bug.find(:all, :conditions => bug_attrib)
#     end
#   end

  
#   def index
#     @bugs = nil
#     if request.post?

#       if( params[:user][:company_name].blank? &&
#           params[:user][:name].blank? &&
#           params[:bug][:submitter].blank? )

#         @bugs = Bug.find(:all)

#       elsif( params[:user][:name].blank? &&
#              params[:bug][:submitter].blank? )
#         @bugs = Bug.find_all_by_user_id(
#                    User.find_by_company_name(params[:user][:company_name]))

#       elsif( params[:user][:company_name].blank? &&
#              params[:bug][:submitter].blank? )

#         @bugs = Bug.find_all_by_user_id(
#                   User.find_by_name(params[:user][:name]))

#       elsif( params[:user][:company_name].blank? &&
#              params[:user][:name].blank? )

#         @bugs = Bug.find_all_by_submitter(params[:bug][:submitter])

#       elsif (params[:user][:company_name].blank? )

#         @bugs = Bug.find(:all,
#                    :conditions => ["user_id = ? and submitter = ?",
#                                    User.find_by_name(params[:user][:name]),
#                                    params[:bug][:submitter]])

#       elsif (params[:user][:name].blank?)

#         @bugs = Bug.find(:all,
#                    :conditions => ["user_id = ? and submitter = ?",
#                                    User.find_by_company_name(params[:user][:company_name]),
#                                    params[:bug][:submitter]])

#       elsif (params[:bug][:submitter].blank?)

#         @bugs = Bug.find_all_by_user_id(
#                    User.find_by_company_name_and_name(
#                                             params[:user][:company_name],
#                                             params[:user][:name]))
#       else #if all are selected
      
#         @bugs = Bug.find(:all,
#                    :conditions => ["user_id = ? and submitter = ?",
#                      User.find_by_company_name_and_name(
#                                          params[:user][:company_name],
#                                          params[:user][:name]),
#                      params[:bug][:submitter]])
#       end
#     end
#   end
end
