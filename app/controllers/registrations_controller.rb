class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def build_resource(*args)
      super
      if session[:omniauth]
        @user.apply_omniauth(session[:omniauth])
        @user.valid?
      end
  end
    

  protected

  def after_update_path_for(resource)
    flash[:notice] = "Successfully updated user info."
    user_path(resource)
  end


end
