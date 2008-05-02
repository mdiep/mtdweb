class CreateNotes < ActiveRecord::Migration
    def self.up
        rename_column :contacts, :notes, :about
        
        create_table :notes do |t|
            t.integer  :contact_id, :null => false
            t.boolean  :contacted
            t.text     :text
            t.datetime :timestamp, :null => false
        end
    end

    def self.down
        rename_column :contacts, :about, :notes
        
        drop_table :notes
    end
end
