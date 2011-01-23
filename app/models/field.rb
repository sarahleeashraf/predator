class Field < ActiveRecord::Base
	has_many :wells
	
	validates_presence_of :name
	validates_uniqueness_of :name

	def self.field_exists(id)
		exists?(id)
	end
	
	def self.all_fields(id)
		find(:all, :order => 'name')
	end
end
