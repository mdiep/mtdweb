class UsersController < ApplicationController
    before_filter :admin_required

    def new
        @page_title = "Create New User"
    end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.is_admin = params[:user][:is_admin] == "1" ? true : false
    @user.save
    if @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Created user #{@user.login}"
    else
      render :action => 'new'
    end
  end

end
