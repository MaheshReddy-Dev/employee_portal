def create
    @session = Stripe::Checkout::Session.create({
      success_url: root_url,
      cancel_url: manage_posts_url,
      payment_method_types: ['card'],
      line_items: [{
          name: "Roommate Posting",
          amount: 2000,
          currency: "inr",
          quantity: 1
      }],
      mode: 'payment',
      metadata: {project_id: params[:project_id]},
      customer_email: current_user.email,
      success_url: manage_posts_url,
      cancel_url: manage_posts_url
    })
  
    respond_to do |format|
      format.turbo_stream
    end
  end
  