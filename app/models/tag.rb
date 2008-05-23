
class Tag < ActiveRecord::Base
    belongs_to :user
    has_many :taggings, :dependent => :destroy
    has_many :contacts, :through => :taggings
    
    def <=>(right)
        return self.name <=> right.name
    end
end
