
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
    
    def new_phone_number_attributes=(phone_number_attributes)
        phone_number_attributes.each do |attributes|
            if not attributes[:number].blank?
                phone_numbers.build(attributes)
            end
        end
    end
    
    def existing_phone_number_attributes=(phone_number_attributes)
        phone_numbers.reject(&:new_record?).each do |pn|
            attributes = phone_number_attributes[pn.id.to_s]
            if attributes.nil? or attributes[:number].blank?
                phone_numbers.delete(pn)
            else
                pn.attributes = attributes
            end
        end
    end

    def save_phone_numbers
        phone_numbers.each do |pn|
            pn.save(false) # false = no validation
        end
    end
end
