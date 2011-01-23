class WellsController < ApplicationController

  # GET /wells
  # GET /wells.xml
  def index
    @wells = Well.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wells }
    end
  end

  # GET /wells/1
  # GET /wells/1.xml
  def show
    @well = Well.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @well }
    end
    
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid well #{params[:id]}")
  	flash[:notice] = "Invalid well"
  	redirect_to :action => "index"
  end

  # GET /wells/new
  # GET /wells/new.xml
  def new
    @well = Well.new
    @fields = Field.find(:all, :order => 'name')

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @well }
    end
  end

  # GET /wells/1/edit
  def edit
    @well = Well.find(params[:id])
  end

  # POST /wells
  # POST /wells.xml
  def create
    @well = Well.new(params[:well])

    respond_to do |format|
      if @well.save
        flash[:notice] = 'Well was successfully created.'
        format.html { redirect_to(@well) }
        format.xml  { render :xml => @well, :status => :created, :location => @well }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @well.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wells/1
  # PUT /wells/1.xml
  def update
    @well = Well.find(params[:id])

    respond_to do |format|
      if @well.update_attributes(params[:well])
        flash[:notice] = 'Well was successfully updated.'
        format.html { redirect_to(@well) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @well.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wells/1
  # DELETE /wells/1.xml
  def destroy
    @well = Well.find(params[:id])
    @well.destroy

    respond_to do |format|
      format.html { redirect_to(wells_url) }
      format.xml  { head :ok }
    end
  end
  
  def view_data
  	@well = Well.find(params[:id])
  	#@data_points = DataPoint.find_by_well_id(@well.id)
  	
  	if (!params[:year]) then params[:year] = Date.today.year end
  	if (!params[:month]) then params[:month] = Date.today.month end
  	
  	date = Date.civil(Integer(params[:year]), Integer(params[:month]));
  	
  	@month = date.month
  	@year = date.year
  	
  	#calculate the next & prev year
  	
  	@next_year = date.year + 1
  	@prev_year = date.year - 1
  	
  	#calculate the next month
  	
  	if (date.month == 12) then
  	  @next_month = { :month => 1, :year => date.year + 1}
  	else
  	  @next_month = { :month => date.month + 1, :year => date.year }
  	end
  	
  	#calculate prev month
  	
  	if (date.month == 1) then
  		@prev_month = { :month => 12, :year => date.year - 1}
  	else
  		@prev_month = { :month => date.month - 1, :year => date.year }
  	end
  	
  	#get the pretty name of the current month
  	
  	month_names = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
  	
  	@current_month_name = month_names[date.month - 1]
  	
  	@dates = Array.new
  	
  	while date.month == @month do
		#find if there is a datapoint for this day and this well
		data = DataPoint.data_point_exists(@well.id, date)
		@dates << {:date => date, :data => data}
  		date += 1
  	end
  end
  
  
  def add_data
    @well = Well.find(params[:id])
    
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid well #{params[:id]}")
    flash[:notice] = "Invalid Well"
    redirect_to :action => "index"
  end
  
   protected
  
    def authorize
      unless User.find_by_id(session[:user_id]).role == "admin" || User.find_by_id(session[:user_id]).role == "data_entry"
        flash[:notice] = "You are not authorized to view this section"
        redirect_to :controller => 'reports'
      end
    end
end