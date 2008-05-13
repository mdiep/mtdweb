
class EmailAddress < ActiveRecord::Base
    def EmailAddress.labels
        return [
            'home',
            'work',
            'other',
        ]
    end
    
    belongs_to :contact
    validates_inclusion_of :label, :in => EmailAddress.labels
end
