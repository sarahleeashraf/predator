class ReportsController < ApplicationController
  def index
    #pull the information for everything aggregated
    
    DataPoints.get_last_30_days
  end

end
