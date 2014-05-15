class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    if current_user
      @id=current_user.id
    end
  end
    def location
  if params[:location].blank?
    if Rails.env.test? || Rails.env.development?
  
    else
      @location ||= request.location
    end
  else
    params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
    @location ||= Geocoder.search(params[:location]).first
    @location
  end
end 


end
