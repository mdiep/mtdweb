
class AddStreet2FieldToAddress < ActiveRecord::Migration
    def self.up
        add_column :addresses, :street2, :string, :limit => 25
    end

    def self.down
        remove_column :addresses, :street2
    end
end
