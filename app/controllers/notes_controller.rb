
class NotesController < ApplicationController
    before_filter :login_required
    
    def create
        @note = Note.new(params[:note])
        @note.timestamp = Time.now()
        @note.save()
        
        redirect_to @note.contact
    end
end
