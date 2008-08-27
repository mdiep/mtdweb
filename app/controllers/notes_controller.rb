
class NotesController < ApplicationController
    before_filter :login_required
    
    def create
        @note = Note.new(params[:note])
        @note.timestamp = Time.now()
        @note.save()
        
        redirect_to @note.contact
    end
    
    def edit
        @page_title = "Edit Gift"
        @gift       = Gift.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @gift.contact.user != current_user
            redirect_to '/', :status => 401
        end
    end
    
    def update
        @gift = Gift.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @gift.contact.user != current_user
            redirect_to '/', :status => 401
        end
      
        if @gift.update_attributes(params[:gift])
            redirect_to @gift.contact
        else
            flash[:error] = "Unable to update note"
            render :action => 'edit'
        end
    end

    def destroy
        @gift = Gift.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @gift.contact.user != current_user
            redirect_to '/', :status => 401
            return
        end

        @gift.destroy
        render :update do |page|
            page.visual_effect :fade, 'gift-' + params[:id]
        end
    end
end
