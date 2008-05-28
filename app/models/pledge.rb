
class Pledge < ActiveRecord::Base
    def Pledge.frequencies
        return {
            'a' => 'annual',
            's' => 'semi-annual',
            'q' => 'quarterly',
            'm' => 'monthly',
            'o' => 'one-time',
        }
    end
    
    def Pledge.per_periods
        return {
            'a' => '/year',
            's' => '/6 months',
            'q' => '/quarter',
            'm' => '/month',
            'o' => ''
        }
    end
    
    belongs_to :contact
    validates_inclusion_of :frequency, :in => Pledge.frequencies.keys
    validates_presence_of  :amount
end
