class DeliveryMethods::System < Noticed::DeliveryMethods::Base
  include CableReady::Broadcaster
  def deliver
    cable_ready[channel].notification(
             title: "My App",
             options: {
               body: notification.message
             }
           ).broadcast_to(recipient)
  end

  def channel
      @channel ||= begin
        value = options[:channel]
        case value
        when String
          value.constantize
        else
          Noticed::NotificationChannel
        end
      end
  end
end
