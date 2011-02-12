class ReportsController < ApplicationController
  
  def index  
  
    #pull the information for everything aggregated
        
    @days = build_report(DataPoint.find(:all, :order => 'date'))    

  end
  
  def fields
  	@fields = Field.find(:all, :order => 'name')
  end
  
  def wells
  	@field = Field.find_by_id(params[:id])
  	@wells = Well.find(:all, :conditions => ["field_id = ?", params[:id]])
  end
  
  def well_report
  	@well = Well.find_by_id(params[:id])
  	
  	@days = build_report(DataPoint.find(:all, :conditions => ["well_id = ?", @well], :order => 'date'))
  	
  end
  
  def field_report
  	@field = Field.find_by_id(params[:id])
  
  	wells = Well.find(:all, :conditions => ["field_id = ?", params[:id]])
 
 	data = Array.new
 
  	for well in wells
  		data = data | DataPoint.find(:all, :conditions => ["well_id = ?", well], :order => 'date')
  	end
  	
  	data.sort! {|a,b| a.date <=> b.date}
  
  	@days = build_report(data)
  
  end
  
  protected
  
  	def build_report(all_data)
  		
  		return ? all_data = nil
  		
  		
  		first_day = all_data[0].date
    	
    	time_length = Date.today - first_day
      	
  		days = Array.new
  	
  		x = 0
  	
  		while x <= time_length
  			days[x] = {:date => Date.today - x , :oil_amount => 0, :gas_amount => 0}
  			x += 1
  		end
  	
  
  	
  		for data_point in all_data
						
  			if (data_point.oil_amt)
				days[Date.today - data_point.date][:oil_amount] += data_point.oil_amt
			end
		  		
  			if (data_point.gas_amt)
  				days[Date.today - data_point.date][:gas_amount] += data_point.gas_amt
  			end
  		end
  	

		days[time_length][:oil_sum] = days[time_length][:oil_amount]
		days[time_length][:gas_sum] = days[time_length][:gas_amount]
    	x = time_length - 1
    
   		while x >= 0
  			days[x][:oil_sum] = days[x + 1][:oil_sum] + days[x][:oil_amount]
  			days[x][:gas_sum] = days[x + 1][:gas_sum] + days[x][:gas_amount]
  		
  			x -= 1
  		end
  		
  		days
  	end
  	
  	

end
