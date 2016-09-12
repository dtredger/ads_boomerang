# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BeeswaxChannel < ApplicationCable::Channel

  def subscribed
    stream_from "beeswax_channel_#{current_advertiser.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end


# ActionCable.server.broadcast("beeswax_channel_1", {message:'cat'})