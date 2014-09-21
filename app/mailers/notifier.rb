class Notifier < ActionMailer::Base
	default from: "robot@gatewaygamer.com"

	def send_new_event_notification(event)
		@event = event
		mail( 
			:to => "mebrelsford@gmail.com",
			:subject => 'Thanks for signing up for our amazing app' 
		)
	end

	def send_report(url)
		mail( 
			:to => "mebrelsford@gmail.com",
			:subject => 'Someone reported content' 
		)
	end
end
