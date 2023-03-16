class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
  
      begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
      rescue JSON::ParserError => e
        status 400
      return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts "Signature error"
        p e
        return
      end
  
      # Handle the event
      case event.type
      when 'checkout.session.completed'
        session = event.data.object
        project = Project.find_by(id: session.metadata.project_id)
        project.is_paid = true
        project.save!
      end
  
      render json: { message: 'success' }
    end
  end 
  