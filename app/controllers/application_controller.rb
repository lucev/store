class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :set_cart
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

  def set_cart
    @cart = current_cart
  end

  def empty_cart
    session[:cart_id] = nil
  end

  private
    def current_cart
      Order.find(session[:cart_id])
    rescue
      order = Order.create
      session[:cart_id] = order.id
      order
    end
end
