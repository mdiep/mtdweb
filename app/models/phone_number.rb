
class PhoneNumber < ActiveRecord::Base
    def PhoneNumber.labels
        return [
            'home',
            'mobile',
            'work',
        ]
    end
    
    belongs_to :contact
    validates_inclusion_of :label, :in => PhoneNumber.labels
end

