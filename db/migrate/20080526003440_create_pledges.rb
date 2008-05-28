
class CreatePledges < ActiveRecord::Migration
    def self.up
        create_table :pledges do |t|
            t.integer :contact_id, :null => false
            t.date    :start_date, :null => false
            t.date    :end_date
            t.decimal :amount, :scale => 2, :null => false
            t.string  :frequency, :limit => 1, :null => false
            t.boolean :lifelink, :default => false, :null => false
        end
    end

    def self.down
        drop_table :pledges
    end
end
