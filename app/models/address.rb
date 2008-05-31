
class Address < ActiveRecord::Base
    def Address.labels
        return {
            'h' => 'home',
            'w' => 'work',
        }
    end
    
    belongs_to :contact
    validates_inclusion_of :label, :in => Address.labels.keys
end
