
module ContactsHelper
    def fields_for_phone_number(pn, &block)
        prefix = pn.new_record? ? 'new' : 'existing'
        fields_for("contact[#{prefix}_phone_number_attributes][]", pn, &block)
    end
end
