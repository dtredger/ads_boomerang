class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit

	def user_for_paper_trail
		current_advertiser.id if current_advertiser
	end

  def payola_can_modify_subscription?(subscription)
	  subscription.owner == current_advertiser
  end

end
