
class CreateAddresses < ActiveRecord::Migration
    def self.up
        create_table :addresses do |t|
            t.integer :contact_id, :null => false
            t.string  :label,  :limit => 1, :null => false
            t.string  :street, :limit => 25
            t.string  :city,   :limit => 25
            t.string  :state,  :limit => 20
            t.string  :zip,    :limit => 15
        end
    end

    def self.down
        drop_table :addresses
    end
end
