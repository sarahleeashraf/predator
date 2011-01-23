class CreateDataPoints < ActiveRecord::Migration
  def self.up
    create_table :data_points do |t|
      t.date :date, :null => false
      t.integer :oil_amt
      t.integer :gas_amt
      t.integer :well_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :data_points
  end
end
