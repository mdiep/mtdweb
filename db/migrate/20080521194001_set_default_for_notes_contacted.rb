
class SetDefaultForNotesContacted < ActiveRecord::Migration
    def self.up
        remove_column :notes, :contacted
        add_column :notes, :contacted, :boolean, :null => false, :default => false
    end

    def self.down
        remove_column :notes, :contacted
        add_column :notes, :contacted, :boolean
    end
end
