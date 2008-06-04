class ContactsImportController < ApplicationController
  require 'FasterCSV'
  
  before_filter :login_required
  
  def index
  end
    
  def import 
    filename = params[:import][:filename]
    
    if csv_import(filename)
      flash[:notice] = "Import successful"
    else
      flash[:notice] = "Import failed"
    end
        
    redirect_to contacts_url
  
  end

# add ability to rollback if the import fails...
  def csv_import(filename)
    n = 0
    FasterCSV.parse(filename.read,:headers => true) do |row|
      c = Contact.new
      c.first_name = row["First Name"]
      c.last_name  = row["Last Name"]
      if c.valid?
        n = n + 1
        GC.start if n % 50 == 0
      else
        return false
      end
    end
    logger.info "Parsed: " + n.to_s
  end

end
