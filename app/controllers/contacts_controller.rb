
class ContactsController < ApplicationController
    before_filter :login_required
    protect_from_forgery :except => ['tags']
    
    def index
        @page_title = "Contacts"
        @contacts   = Contact.find_all_by_user_id(current_user.id)
    end
    
    def show
        @contact    = Contact.find(params[:id])
        @tags       = Tag.find_all_by_user_id(current_user.id)
        @page_title = @contact.full_name
    end
    
    def new
        @page_title = "New Contact"
        @contact    = Contact.new
        2.times { @contact.phone_numbers.build   }
        2.times { @contact.email_addresses.build }
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

    def edit
        @contact    = Contact.find(params[:id])
        @page_title = @contact.full_name
    end

    def update
        @contact = Contact.find(params[:id])
        if params[:contact][:spouses_name] == ''
            params[:contact][:spouses_name] = nil
        end
        
        if @contact.update_attributes(params[:contact])
            redirect_to @contact
        else
            render :action => 'edit'
        end
    end
    
    def tags
        @contact = Contact.find(params[:id])
        if params[:tags]
            @contact.tag_with(params[:tags].values)
        else
            @contact.tag_with([])
        end
        render :partial => 'tags'
    end
end
