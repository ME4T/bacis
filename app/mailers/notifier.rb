class Notifier < ActionMailer::Base
	default from: "admin@gatewaygamer.com"

	def send_new_event_notification(event)
		@event = event
		mail( 
			:to => "admin@gatewaygamer.com",
			:subject => 'New Event Created' 
		)
	end

	def send_report(url)
		mail( 
			:to => "admin@gatewaygamer.com",
			:subject => 'Reported Content'
		)
	end
end
