class CreateContacts < ActiveRecord::Migration
    def self.up
        create_table :contacts do |t|
            t.integer :user_id
            t.string  :first_name,   :limit => 25, :null => false
            t.string  :spouses_name, :limit => 25
            t.string  :last_name,    :limit => 25, :null => false
            t.integer :referred_by
            t.text    :notes
            t.date    :created_on
        end
    end

    def self.down
        drop_table :contacts
    end
end
