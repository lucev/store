class Admin::OrdersController < AdminController

  def index
    if(params[:status].nil? or params[:status] == "")
      @orders = Order.all.order_by(:updated_at.desc)
    else
      @status = params[:status]
      @orders = Order.where(:status => @status).order_by(:updated_at.desc)
    end
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