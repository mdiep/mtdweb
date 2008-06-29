
class AddReferredByField < ActiveRecord::Migration
    def self.up
        remove_column :contacts, :referred_by
        add_column :contacts, :referred_by_id, :integer
    end

    def self.down
        add_column :contacts, :referred_by, :integer
        remove_column :contacts, :referred_by_id
    end
end
