
class CreateOrganizations < ActiveRecord::Migration
    def self.up
        create_table :organizations do |t|
            t.integer :user_id, :null => false
            t.string :name, :limit => 40, :blank => false, :null => false
        end
        
        add_column :contacts, :organization_id, :integer, :blank => false
    end

    def self.down
        remove_column :contacts, :organization_id
        drop_table :organizations
    end
end
