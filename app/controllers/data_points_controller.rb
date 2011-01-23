class DataPointsController < ApplicationController
  # GET /data_points
  # GET /data_points.xml
  def index
    @data_points = DataPoint.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_points }
    end
  end

  # GET /data_points/1
  # GET /data_points/1.xml
  def show
    @data_point = DataPoint.find(params[:id])
    @well = Well.find(@data_point.well_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_point }
    end
  end

  # GET /data_points/new
  # GET /data_points/new.xml
  def new
  	puts "making a new data point!"
    @data_point = DataPoint.new
    
    @data_point_already_exists = DataPoint.data_point_exists(params[:well_id], params[:date])

    @data_point.date = params[:date]
    @data_point.well_id = params[:well_id]
    
    @well = Well.find(@data_point.well_id)
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_point }
    end
  end

  # GET /data_points/1/edit
  def edit
    @data_point = DataPoint.find(params[:id])
  end

  # POST /data_points
  # POST /data_points.xml
  def create
    @data_point = DataPoint.new(params[:data_point])
    
    @well = Well.find(@data_point.well_id)
    
    @data_point_already_exists = DataPoint.data_point_exists(@data_point.well_id, @data_point.date)
    
    puts "creating a data point"
    puts @data_point_already_exists

    respond_to do |format|
      if @data_point_already_exists
        flash[:notice] = 'This data point was already created'
        format.html { redirect_to(:controller => "wells", :action => "view_data", :id => @well.id) }
      elsif @data_point.save
        flash[:notice] = 'DataPoint was successfully created.'
        format.html { redirect_to(@data_point) }
        format.xml  { render :xml => @data_point, :status => :created, :location => @data_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_points/1
  # PUT /data_points/1.xml
  def update
    @data_point = DataPoint.find(params[:id])

    respond_to do |format|
      if @data_point.update_attributes(params[:data_point])
        flash[:notice] = 'DataPoint was successfully updated.'
        format.html { redirect_to(@data_point) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_points/1
  # DELETE /data_points/1.xml
  def destroy
    @data_point = DataPoint.find(params[:id])
    @data_point.destroy

    respond_to do |format|
      format.html { redirect_to(data_points_url) }
      format.xml  { head :ok }
    end
  end
  
   protected
  
    def authorize
      unless User.find_by_id(session[:user_id]).role == "admin" || User.find_by_id(session[:user_id]).role == "data_entry"
        flash[:notice] = "You are not authorized to view this section"
        redirect_to :controller => 'reports'
      end
    end
  
end
