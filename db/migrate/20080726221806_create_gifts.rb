
class CreateGifts < ActiveRecord::Migration
    def self.up
        create_table :gifts do |t|
            t.integer :contact_id, :null => false
            t.decimal :amount, :scale => 2, :null => false
            t.integer :check_number
            t.date    :date
            t.string  :memo, :limit => 40
        end
    end

    def self.down
        drop_table :gifts
    end
end
