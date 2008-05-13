
class CreateEmailAddresses < ActiveRecord::Migration
    def self.up
        create_table :email_addresses do |t|
            t.integer :contact_id, :null => false
            t.string  :label,   :limit => 10
            t.string  :address, :limit => 75
        end
    end

    def self.down
        drop_table :email_addresses
    end
end
