
class Contact < ActiveRecord::Base
    belongs_to :user
    has_many   :notes,          :dependent => :destroy
    has_many   :phone_numbers,  :dependent => :destroy

    after_update :save_phone_numbers
    
    def first_names
        if spouses_name.nil?
            return first_name
        else
            return first_name + ' and ' + spouses_name
        end
    end

    def full_name
        return first_names + ' ' + last_name
    end
    
    def phone_number_attributes=(phone_number_attributes)
        phone_number_attributes.each do |attributes|
            if attributes[:id].blank?
                phone_numbers.build(attributes)
            else
                phone_number = phone_numbers.detect { |pn| pn.id == attributes[:id].to_i }
                phone_number.attributes = attributes
            end
        end
    end

    def save_phone_numbers
        phone_numbers.each do |pn|
            pn.save(false) # false = no validation
        end
    end
end
