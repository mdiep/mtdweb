
class Contact < ActiveRecord::Base
    belongs_to :user
    has_many   :notes,           :dependent => :destroy
    has_many   :phone_numbers,   :dependent => :destroy
    has_many   :email_addresses, :dependent => :destroy

    after_update :save_phone_numbers, :save_email_addresses
    
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
    
    def new_email_address_attributes=(email_address_attributes)
        email_address_attributes.each do |attributes|
            if not attributes[:address].blank?
                email_addresses.build(attributes)
            end
        end
    end
    
    def existing_email_address_attributes=(email_address_attributes)
        email_addresses.reject(&:new_record?).each do |ea|
            attributes = email_address_attributes[ea.id.to_s]
            if attributes.nil? or attributes[:address].blank?
                email_addresses.delete(ea)
            else
                ea.attributes = attributes
            end
        end
    end

    def save_email_addresses
        email_addresses.each do |ea|
            ea.save(false) # false = no validation
        end
    end
end
