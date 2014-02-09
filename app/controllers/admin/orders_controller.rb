class Admin::OrdersController < AdminController

  def index
    @orders = Order.all.order_by(:updated_at.desc)
  end

  def show
    @order = Order.find(params[:id])
  end
  
end