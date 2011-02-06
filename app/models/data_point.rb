class DataPoint < ActiveRecord::Base
	belongs_to :well
	
	validates_presence_of :date
	validates_numericality_of :oil_amt, :gas_amt
	validate :well_exists
	
	def self.find_by_well_id(well_id)
		DataPoint.find(:all, :conditions => ["well_id = ?", well_id])
	end
	
	def self.data_point_exists(well_id, date)
		already_exists = DataPoint.find(:first, :conditions => ["date = :date and well_id = :well_id", {:date => date, :well_id => well_id}])
	end
	
	def self.get_last_30_days()
		today = Date.new
		puts today	
	end
	
	defl self.get
	
	protected
		def well_exists
			errors.add(:well_id, 'this well does not exist') if !Well.well_exists well_id
		end
	
		def unique_date_well
			if (id)
				already_exists = DataPoint.find(:first, :conditions => ["date = :date and well_id = :well_id", {:date => date, :well_id => well_id}])
				errors.add(:date, 'A data point already exists for this date and well') if already_exists
			end
		end
end
