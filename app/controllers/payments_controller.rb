class PaymentsController < ApplicationController

  # layout 'authorize_net'
  helper :authorize_net
  protect_from_forgery :except => :relay_response

  # GET
  # Displays a payment form.
  def payment
    @amount = 10.00
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :hosted_payment_form => true)
    @sim_transaction.set_hosted_payment_receipt(AuthorizeNet::SIM::HostedReceiptPage.new(:link_method => AuthorizeNet::SIM::HostedReceiptPage::LinkMethod::GET, :link_text => 'Continue', :link_url => payments_thank_you_url(:only_path => false)))

  end
  
  # GET
  # Displays a thank you page.
  def thank_you
    @auth_code = params[:x_auth_code]
  end

  def authorize_net_callback
    @order = Order.find(params[:x_order_id])
    if params[:x_amount] = @order.total
      @order.update_attributes(:status => :paid)
      redirect_to payments_thank_you_path
    else

    end
  end

end