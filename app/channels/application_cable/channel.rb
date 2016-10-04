module ApplicationCable
  class Channel < ActionCable::Channel::Base


	  # http://stackoverflow.com/questions/38366040/disable-rails-log-for-actioncable-events
	  def dispatch_action(action, data)
		  #logger.info action_signature(action, data)

		  if method(action).arity == 1
			  public_send action, data
		  else
			  public_send action
		  end
	  end

  end
end
