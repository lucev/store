module CartsHelper
    def current_cart_total
    total = 0
    total = @cart.total unless @cart.nil?

    total
  end
end
