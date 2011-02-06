class ReportsController < ApplicationController
  
  def index  
  
    #pull the information for everything aggregated
    
    
    
    all_data = DataPoint.find(:all, :order => 'date')
        
    first_day = all_data[0].date
    
    
    time_length = Date.today - first_day
      	
  	@days = Array.new
  	
  	x = 0
  	
  	while x <= time_length
  		@days[x] = {:date => Date.today - x , :oil_amount => 0, :gas_amount => 0}
  		x += 1
  	end
  	
  
  	
  	for data_point in all_data
				
		puts @days[Date.today - data_point.date]
		
  		if (data_point.oil_amt)
			@days[Date.today - data_point.date][:oil_amount] += data_point.oil_amt
		end
		  		
  		if (data_point.gas_amt)
  			@days[Date.today - data_point.date][:gas_amount] += data_point.gas_amt
  		end
  	end
  	

	@days[time_length][:oil_sum] = @days[time_length][:oil_amount]
	@days[time_length][:gas_sum] = @days[time_length][:gas_amount]
    x = time_length - 1
    
    while x >= 0
  		@days[x][:oil_sum] = @days[x + 1][:oil_sum] + @days[x][:oil_amount]
  		@days[x][:gas_sum] = @days[x + 1][:gas_sum] + @days[x][:gas_amount]
  		
  		x -= 1
  	end
  	

  end
  
  def fields
  	@fields = Fields.find(:all, :order => "name")
  end
  
  def field_report
  
  end
  
  protected
  
  	def self.build_report(data)
  		first_day = all_data[0].date
    	
    	time_length = Date.today - first_day
      	
  		days = Array.new
  	
  		x = 0
  	
  		while x <= time_length
  			days[x] = {:date => Date.today - x , :oil_amount => 0, :gas_amount => 0}
  			x += 1
  		end
  	
  
  	
  		for data_point in all_data
				
			puts @days[Date.today - data_point.date]
		
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
