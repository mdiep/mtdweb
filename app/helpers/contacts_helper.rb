
module ContactsHelper
    def fields_for_phone_number(pn, &block)
        prefix = pn.new_record? ? 'new' : 'existing'
        fields_for("contact[#{prefix}_phone_number_attributes][]", pn, &block)
    end
    
    def add_partial_link(name, id, partial, object)
        link_to_function name, nil, :class => 'add-partial' do |page|
            page.insert_html :bottom, id, :partial => partial, :object => object
        end
    end
end
