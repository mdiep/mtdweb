
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
    
    def new
        @page_title = "New Contact"
    end
    
    def create
        @contact = Contact.new(params[:contact])
        @contact.user = current_user
        if @contact.spouses_name == ''
            @contact.spouses_name = nil
        end
        @contact.save
        
        if not @contact.errors.empty?
            render :action => 'new'
        else
            redirect_to :action => 'show', :id => @contact.id
        end
    end
end
