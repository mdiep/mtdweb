
class Contact < ActiveRecord::Base
    belongs_to :user
    has_many   :notes

    def full_name
        if spouses_name.nil?
            return first_name + ' ' + last_name
        else
            return first_name + ' and ' + spouses_name + ' ' + last_name
        end
    end
end
