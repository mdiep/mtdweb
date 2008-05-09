
class MakePhoneNumberLabelADropdown < ActiveRecord::Migration
    def self.up
        remove_column :phone_numbers, :label
        add_column    :phone_numbers, :label, :string, :limit => 10
    end

    def self.down
        remove_column :phone_numbers, :label
        add_column    :phone_numbers, :label, :string, :limit => 10
    end
end
