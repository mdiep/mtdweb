
class ContactsController < ApplicationController
    before_filter :login_required
    protect_from_forgery :except => ['tags', 'list', 'auto_complete_for_contact_referred_by', 'auto_complete_for_organization_name']
    
    def index
        @page_title = "Contacts"
        @contacts   = Contact.find_all_by_user_id(current_user.id).sort
        @tags       = Tag.find_all_by_user_id(current_user.id).sort
    end
    
    def show
        @contact    = Contact.find(params[:id])
        @tags       = Tag.find_all_by_user_id(current_user.id)
        @page_title = @contact.full_name
        
        # Security: make sure this contact belongs to the user
        if @contact.user != current_user
            redirect_to '/', :status => 401
        end
    end
    
    def new
        @page_title = "New Contact"
        @contacts   = Contact.find_all_by_user_id(current_user.id).sort { |a,b| a.last_name <=> b.last_name }
        @contact    = Contact.new
        2.times { @contact.phone_numbers.build   }
        2.times { @contact.email_addresses.build }
        1.times { @contact.addresses.build }
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
            @contact.organization_name = params[:organization][:name]
            redirect_to :action => 'show', :id => @contact.id
        end
    end

    def edit
        @contacts     = Contact.find_all_by_user_id(current_user.id).sort { |a,b| a.last_name <=> b.last_name }
        @contact      = Contact.find(params[:id])
        @organization = @contact.organization
        @page_title   = @contact.full_name
        
        # Security: make sure this contact belongs to the user
        if @contact.user != current_user
            redirect_to '/', :status => 401
        end
    end

    def update
        @contact = Contact.find(params[:id])
        if params[:contact][:spouses_name] == ''
            params[:contact][:spouses_name] = nil
        end
        
        # Security: make sure this contact belongs to the user
        if @contact.user != current_user
            render :text => '', :status => 401
            return
        end
        
        if @contact.update_attributes(params[:contact])
            @contact.organization_name = params[:organization][:name]
            redirect_to @contact
        else
            render :action => 'edit'
        end
    end
    
    def tags
        @contact = Contact.find(params[:id])
        
        # Security: make sure this contact belongs to the user
        if @contact.user != current_user
            render :text => '', :status => 401
            return
        end
        
        if params[:tags]
            @contact.tag_with(params[:tags].values)
        else
            @contact.tag_with([])
        end
        render :partial => 'tags'
    end
    
    def list
        if params[:tags]
            @contacts = Contact.find_all_by_user_id_tagged(current_user.id, params[:tags].values)
        else
            @contacts = Contact.find_all_by_user_id(current_user.id)
        end
        
        if params[:name]
            regexp = /#{Regexp.escape(params[:name])}/i;
            @contacts = @contacts.find_all { |c| regexp.match(c.full_name) }
        end
        
        if params[:org]
            regexp = /#{Regexp.escape(params[:org])}/i;
            @contacts = @contacts.find_all { |c| regexp.match(c.organization.name) }
        end
        
        if params[:referred_by]
            regexp = /#{Regexp.escape(params[:referred_by])}/i
            @contacts = @contacts.find_all { |c| regexp.match(c.referred_by.full_name) }
        end
        
        @contacts = case params[:sort]
            when "last_contact" then @contacts.sort_by { |c| [c.last_contact.nil? ? Time.at(0) : c.last_contact, c.last_name] }
            else                     @contacts.sort
        end
        
        render :partial => 'contacts'
    end
    
    def auto_complete_for_organization_name
        name  = params[:organization][:name]
        @orgs = Organization.find(:all,
            :conditions => [ "LOWER(name) LIKE ? AND user_id = ?", "%#{name.downcase}%", current_user.id ],
            :order      => "name ASC",
            :limit      => 10
        )
        
        render :inline => "<%= auto_complete_result @orgs, 'name' %>"
    end
end
