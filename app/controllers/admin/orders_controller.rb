class Admin::OrdersController < AdminController

  def index
    @orders = Order.all.order_by(:updated_at.desc)
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])

    @order.update_attributes(:status => params[:order][:status])
    redirect_to admin_orders_path
  end
end