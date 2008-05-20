
class CreateTags < ActiveRecord::Migration
    def self.up
        create_table :tags do |t|
            t.string  :name, :limit => 25
            t.integer :user_id
        end
        
        create_table :taggings do |t|
            t.integer :tag_id
            t.integer :contact_id
        end
    end

    def self.down
        drop_table :tags
        drop_table :taggings
    end
end
