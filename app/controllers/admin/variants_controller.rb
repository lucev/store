class Admin::VariantsController < AdminController

  # GET /variants.json
  def index
    @master_variant = Variant.find(params[:product_id])
    @variants = Variant.where(:master_id => @master_variant.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @variants }
    end
  end

  # GET /variants/1
  # GET /variants/1.json
  def show
    @variant = Variant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /variants/new
  # GET /variants/new.json
  def new
    @variant = Variant.new
    @master_variant = Variant.find(params[:product_id])
    @variant.prices = @master_variant.prices
    @path = admin_product_variants_path(@master_variant)
    @cancel_path = admin_product_variants_path(@master_variant)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /variants/1/edit
  def edit
    @variant = Variant.find(params[:id])
    @master_variant = Variant.find(@variant.master_id)
    @path = admin_product_variant_path(@variant.master_id, @variant)
    @cancel_path = request.env['HTTP_REFERER'] || admin_product_variants_path(@variant.master_id)
  end

  # POST /variants
  # POST /variants.json
  def create
    @master_variant = Variant.find(params[:product_id])
    params[:variant][:is_master] = false
    params[:variant][:master_id] = @master_variant.id
    params[:variant][:product] = @master_variant.product
    @variant = Variant.new(params[:variant])

    respond_to do |format|
      if @variant.save
        format.html { redirect_to admin_product_variants_path(@variant.master_id), notice: 'Variant was successfully created.' }
        format.json { render json: admin_product_variant_path(@variant.master_id, @variant),
                              status: :created, location: admin_product_variant_path(@variant.master_id, @variant) }
      else
        @path = admin_product_variants_path(@master_variant)
        format.html { render action: "new" }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /variants/1
  # PUT /variants/1.json
  def update
    @variant = Variant.find(params[:id])

    respond_to do |format|
      if @variant.update_attributes(params[:variant])
        format.html { redirect_to admin_product_variants_path(@variant.master_id),
          notice: 'Variant was successfully updated.' }
        format.json { head :no_content }
      else
        @path = admin_product_variant_path(@variant.master_id, @variant)
        format.html { render action: "edit" }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variants/1
  # DELETE /variants/1.json
  def destroy
    @variant = Variant.find(params[:id])
    @variant.destroy

    respond_to do |format|
      format.html { redirect_to admin_product_variants_url(@variant.master_id) }
      format.json { head :no_content }
    end
  end
end
