class OrdersController < ApplicationController

  before_filter :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    @order.line_items = current_cart.line_items
    @order.build_address
    @cart = current_cart
    if current_user.default_address.nil?
      @order.address = Address.new
    else
      @order.address = current_user.default_address
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])

  end

  # POST /orders
  # POST /orders.json
  def create

    if current_cart.empty?
      redirect_to show_cart_url
      return
    else
      @order = Order.new(params[:order])
      @order.line_items = current_cart.line_items
      @order.ip_address = request.remote_ip
      @address = Address.new(params[:order][:address_attributes])
      current_user.addresses.push @address unless current_user.has_address @address
    end

    respond_to do |format|
      if @order.save
        if @order.purchase
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          redirect_to edit_order_url @order
          break
        end
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    if current_cart.empty?
      redirect_to show_cart_url
      return
    else
      # @order = current_cart.order
      # @order.cart = current_cart
      @order.ip_address = request.remote_ip
      @address = Address.new(params[:order][:address_attributes])
      current_user.addresses.push @address unless current_user.has_address @address
    end

    respond_to do |format|
      if @order.update_attributes(params[:order])
       if @order.purchase
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          redirect_to edit_order_url @order
          break
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
