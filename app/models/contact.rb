
class Contact < ActiveRecord::Base
    def full_name
        if spouses_name.nil?
            return first_name + ' ' + last_name
        else
            return first_name + ' and ' + spouses_name + ' ' + lastname
        end
    end
end
