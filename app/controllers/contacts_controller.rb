
class ContactsController < ApplicationController
    before_filter :login_required
    
    def index
        @page_title = "Contacts"
    end
end
