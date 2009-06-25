class BugsController < ApplicationController
!
  # GET /bugs
  # GET /bugs.xml
  def index
    @bugs = Bug.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /bugs/1
  # GET /bugs/1.xml
  def show
    @bug = Bug.find(params[:id])
    if(session[:admin] || session[:user_id] == @bug.user_id)
      respond_to do |format|
        format.html # show.html.erb
      end
    else
      redirect_to :action => "index"
     end
  end

  # GET /bugs/new
  # GET /bugs/new.xml
  def new
    @bug = Bug.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /bugs
  # POST /bugs.xml
  def create
    @bug = Bug.new(params[:bug])
    @bug.user_id = session[:user_id]

    respond_to do |format|
      if @bug.save
        flash[:notice] = 'Bug was successfully created.'
        format.html { redirect_to(@bug) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  # PUT /bugs/1
  # PUT /bugs/1.xml
  def update
    @bug = Bug.find(params[:id])

    
    respond_to do |format|
      if @bug.update_attributes(params[:bug])
        notice = "Bug marked as solved" if params[:bug][:solved] == "1"
        format.html { redirect_to_index :controller => "admin", :notice => notice }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end





  
  protected
  def authorize_admin
  end

  
end
