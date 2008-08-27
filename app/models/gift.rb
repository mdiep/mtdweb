
class Gift < ActiveRecord::Base
    belongs_to :contact    
    validates_presence_of :date, :amount
    
    def <=>(other)
        return other.date <=> self.date
    end
end
