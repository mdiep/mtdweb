
class Note < ActiveRecord::Base
    belongs_to :contact
    
    def <=>(right)
        return right.timestamp <=> self.timestamp
    end
end
