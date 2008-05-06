
class CreatePhoneNumbers < ActiveRecord::Migration
     def self.up
        create_table :phone_numbers do |t|
            t.integer :contact_id, :null => false
            t.string  :label,  :limit => 10
            t.string  :number, :limit => 25
        end
    end

    def self.down
        drop_table :phone_numbers
    end
end

