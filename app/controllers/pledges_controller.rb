
class PledgesController < ApplicationController
    before_filter :login_required
    
    def new
        @pledge     = Pledge.new(:contact => Contact.find(params[:id]))
        @page_title = "Add Pledge"
    end
    
    def create
        @pledge = Pledge.new(params[:pledge])
        @pledge.save()
        
        if not @pledge.errors.empty?
            @page_title = "Add Pledge"
            render :action => 'new'
        else
            redirect_to @pledge.contact
        end
    end
    
    def edit
        @pledge     = Pledge.find(params[:id])
        @page_title = "Edit Pledge"
        
        # Security: make sure this pledge belongs to the user
        if @pledge.contact.user != current_user
            redirect_to '/', :status => 401
        end
    end
    
    def update
        @pledge = Pledge.find(params[:id])
        
        # Security: make sure this pledge belongs to the user
        if @pledge.contact.user != current_user or params[:pledge][:contact_id]
            redirect_to '/', :status => 401
            return
        end
        
        if @pledge.update_attributes(params[:pledge])
            redirect_to @pledge.contact
        else
            flash[:error] = "Unable to update pledge"
            @page_title = "Edit Pledge"
            render :action => 'edit'
        end
    end
end
