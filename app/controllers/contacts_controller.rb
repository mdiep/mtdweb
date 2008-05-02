
class ContactsController < ApplicationController
    before_filter :login_required
    
    def index
        @page_title = "Contacts"
        @contacts   = Contact.find_all_by_user_id(current_user.id)
    end
    
    def show
        @contact    = Contact.find(params[:id])
        @page_title = @contact.full_name
    end
end
