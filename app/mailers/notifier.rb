class Notifier < ActionMailer::Base
	default from: "admin@gatewaygamer.com"

	def send_new_event_notification(event)
		@event = event
		mail( 
			:to => "admin@gatewaygamer.com",
			:subject => 'New Event Created' 
		)
	end
	def send_contact(email, contents)
		mail( 
			:to => "admin@gatewaygamer.com",
			:subject => 'Contact Form'
		)do |format|
		  format.text { render text: "From: #{email} \n  Contents: #{contents}" }
		  format.html { render text: "<p>From: #{email}</p>  <p>Contents: #{contents}</p>" }
		end

	end


	def send_report(url)
		mail( 
			:to => "admin@gatewaygamer.com",
			:subject => 'Reported Content'
		)do |format|
		  format.text { render text: "#{url}" }
		  format.html { render text: "<a href=\"#{url}\">#{url}</a>" }
		end
	end
end
