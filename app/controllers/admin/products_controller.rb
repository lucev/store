class Admin::ProductsController < AdminController

  # GET /products
  # GET /products.json
  def index
    @master_variants = Variant.where(is_master: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @master_variants }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @master_variant = Variant.find(params[:id])

    respond_to do |format|
      format.html { redirect_to edit_admin_product_path(I18n.locale, @master_variant)}
      format.json { render json: @variant }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @master_variant = Variant.new(is_master: true)
    @product = @master_variant.build_product

    @path = admin_products_path
    @submit_text = t(:create_product)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @master_variant }
    end
  end

  # GET /products/1/edit
  def edit
    @master_variant = Variant.find(params[:id])
    @path = admin_product_path(I18n.locale, @master_variant)
    @submit_text = t(:update_product)
  end

  # POST /products
  # POST /products.json
  def create
    params[:variant][:is_master] = true
    @master_variant = Variant.new(params[:variant])
    @master_variant.master_id = @master_variant.id

    @path = admin_products_path

    respond_to do |format|
      if @master_variant.save
        format.html { redirect_to edit_admin_product_path(I18n.locale, @master_variant),
          notice: 'Product was successfully created.' }
        format.json { render json: @master_variant, status: :created, location: @master_variant }
      else
        format.html { render action: "new" }
        format.json { render json: @master_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @master_variant = Variant.find(params[:id])
    
    @path = edit_admin_product_path(@master_variant)

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
        format.html { redirect_to admin_product_path(I18n.locale, @master_variant), notice: 'Product was successfully updated.' }
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
      format.html { redirect_to admin_products_url(I18n.locale) }
      format.json { head :no_content }
    end
  end
end
