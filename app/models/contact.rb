
class Contact < ActiveRecord::Base
    belongs_to :user
    has_many   :notes,           :dependent => :destroy
    has_many   :phone_numbers,   :dependent => :destroy
    has_many   :email_addresses, :dependent => :destroy
    has_many   :taggings,        :dependent => :destroy
    has_many   :tags, :through => :taggings

    after_update :save_phone_numbers, :save_email_addresses
    
    validates_presence_of :first_name,  :on => :create, :message => "can't be blank"
    validates_presence_of :last_name,   :on => :create, :message => "can't be blank"
    
    
    def <=>(right)
        retval = self.last_name <=> right.last_name
        return retval != 0 ? retval : self.first_names <=> right.first_names
    end
    
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
    
    def last_contact
        note = self.notes.sort.find { |note| note.contacted }
        return note.nil? ? nil : note.timestamp
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
    
    def tag_with(new)
        existing = self.tags.collect { |t| t.name }
        deleted  = existing - new
        added    = new - existing
        
        deleted.each do |name|
            tag = Tag.find_by_name(name)
            Tagging.find_by_tag_id_and_contact_id(tag.id, self.id).destroy
            if tag.contacts.empty?
                tag.destroy
            end
        end
        
        added.each do |name|
            tag = Tag.find_or_create_by_name_and_user_id(name, self.user.id)
            self.tags.push(tag)
        end
        
        self.reload
    end
    
    def Contact.find_all_by_user_id_tagged(user_id, tags)
        user_id  = user_id.to_i
        tag_list = tags.collect { |t| quote_value(t) }.join(",")
        sql = "SELECT #{Contact.table_name}.*
                 FROM #{Contact.table_name},
                      (SELECT #{Tagging.table_name}.contact_id AS contact_id,
                              COUNT(*) AS count
                         FROM #{Tagging.table_name},
                              #{Tag.table_name}
                        WHERE #{Tagging.table_name}.tag_id = #{Tag.table_name}.id
                          AND #{Tag.table_name}.name IN (#{tag_list})
                          AND #{Tag.table_name}.user_id = #{user_id}
                     GROUP BY #{Tagging.table_name}.contact_id) AS taggings
                WHERE taggings.contact_id = #{Contact.table_name}.id
                  AND taggings.count = #{tags.size}";
                  
        return Contact.find_by_sql(sql)
    end
end
