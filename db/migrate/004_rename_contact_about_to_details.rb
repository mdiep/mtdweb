
class RenameContactAboutToDetails < ActiveRecord::Migration
    def self.up
        rename_column :contacts, :about, :details
    end

    def self.down
        rename_column :contacts, :details, :about
    end
end
