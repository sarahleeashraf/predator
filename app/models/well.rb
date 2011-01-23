class Well < ActiveRecord::Base
	belongs_to :field
	
	validates_presence_of :name
	validates_uniqueness_of :name
	validate :field_exists
	
	def self.well_exists(id)
		exists?(id)
	end
	
	protected
		def field_exists
			errors.add(:field_id, 'this field does not exist') if !Field.field_exists field_id
		end
end
