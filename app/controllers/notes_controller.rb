
class NotesController < ApplicationController
    before_filter :login_required
    
    def create
        @note = Note.new(params[:note])
        @note.timestamp = Time.now()
        @note.save()
        
        redirect_to @note.contact
    end
    
    def edit
        @note = Note.find(params[:id])        
    end
    
    def update
        @note = Note.find(params[:id])
      
        if @note.update_attributes(params[:note])
            redirect_to @note.contact
        else
            flash[:error] = "Unable to update note"
            render :action => 'edit'
        end
    end

end
