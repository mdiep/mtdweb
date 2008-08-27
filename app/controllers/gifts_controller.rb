
class GiftsController < ApplicationController
    before_filter :login_required
    
    def create
        @gift = Gift.new(params[:gift])
        @gift.save()
        @contact = @gift.contact
        
        render :update do |page|
            page.replace_html 'contact-content', :partial => 'contacts/gifts'
            page['gift_check_number'].clear
            page['gift_amount'].clear
            page['gift_memo'].clear
        end
    end
    
    def edit
        @page_title = "Edit Note"
        @note       = Note.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @note.contact.user != current_user
            redirect_to '/', :status => 401
        end
    end
    
    def update
        @note = Note.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @note.contact.user != current_user
            redirect_to '/', :status => 401
        end
      
        if @note.update_attributes(params[:note])
            redirect_to @note.contact
        else
            flash[:error] = "Unable to update note"
            render :action => 'edit'
        end
    end

    def destroy
        @note = Note.find(params[:id])
        
        # Security: make sure this note belongs to this user
        if @note.contact.user != current_user
            redirect_to '/', :status => 401
            return
        end

        @note.destroy
        render :update do |page|
            page.visual_effect :fade, 'note-' + params[:id]
        end
    end
end
