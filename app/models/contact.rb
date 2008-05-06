
class Contact < ActiveRecord::Base
    belongs_to :user
    has_many   :notes
    has_many   :phone_numbers

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
end
