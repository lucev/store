class Admin::ProductsController < AdminController

  # GET /products
  # GET /products.json
  def index
    @variants = Variant.where(is_master: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @variants }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @variant = Variant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @variant = Variant.new(is_master: true)
    @variant.build_product

    @path = admin_products_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /products/1/edit
  def edit
    @variant = Variant.find(params[:id])
    @path = admin_product_path(@variant)
  end

  # POST /products
  # POST /products.json
  def create
    params[:variant][:is_master] = true
    @variant = Variant.new(params[:variant])

    respond_to do |format|
      if @variant.save
        format.html { redirect_to admin_product_path(@variant), notice: 'Product was successfully created.' }
        format.json { render json: @variant, status: :created, location: @variant }
      else
        format.html { render action: "new" }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @master_variant = Variant.find(params[:id])
    
    respond_to do |format|
      if @master_variant.update_attributes(params[:variant])

        @variants = Variant.where(:master_id => @master_variant.id)
        unless @variants.empty?
          @variants.each do |v|
            v.product.update_attributes(
              :name => @master_variant.product.name,
              :description => @master_variant.product.description)
          end
        end
        format.html { redirect_to admin_product_path(@master_variant), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @master_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @master_variant = Variant.find(params[:id])
    @variants = Variant.where(:master_id => @master_variant.id)
    unless @variants.empty?
      @variants.each do |v|
        v.destroy
      end
    end
    @master_variant.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
