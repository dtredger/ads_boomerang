class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def payola_can_modify_subscription?(subscription)
	  subscription.owner == current_advertiser
  end

end
