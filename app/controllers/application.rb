# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c1f0f401ddbd580f2bdcaee14807935a'
  
    def admin_required
        unless logged_in? && current_user.is_admin
            redirect_to '/', :status => 401
        end
    end
end
