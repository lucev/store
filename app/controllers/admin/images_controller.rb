class Admin::ImagesController < AdminController

  def index
    @master_variant = Variant.find(params[:product_id])
    @variants = Variant.where(:master_id => @master_variant.id).order_by(created_at: 'asc')
  end

  def new
    if params[:id].nil?
      @variant = Variant.find(params[:product_id])
      @master_variant = @variant
      @cancel_path = admin_product_path(I18n.locale, @variant)
    else
      @variant = Variant.find(params[:id])
      @master_variant = Variant.find(@variant.master_id)
      @cancel_path = admin_product_variant_path(I18n.locale, @master_variant, @variant)
    end
    @variants = Variant.where(master_id: @master_variant.id)
    session[:variant_images_page] = request.env['HTTP_REFERER'] ||
                                      admin_product_images_path(I18n.locale, @master_variant)

    @image = @variant.images.build
    @path = admin_product_images_path
  end

  def edit
    if params[:variant_id].nil?
      @variant = Variant.find(params[:product_id])
      @master_variant = @variant
      @cancel_path = admin_product_path(I18n.locale, @variant)
    else
      @variant = Variant.find(params[:variant_id])
      @master_variant = Variant.find(@variant.master_id)
      @cancel_path = admin_product_variant_path(I18n.locale, @master_variant, @variant)
    end
    @image = @variant.images.find(params[:id])
    @path = admin_product_image_path(I18n.locale, @master_variant, @image )
    session[:variant_images_page] = request.env['HTTP_REFERER'] ||
                                      admin_product_images_path(I18n.locale, @master_variant)
  end

  def create
    @image = Image.new(params[:image])

    if params[:variant_id].empty?
      @image.is_product_image = true
      @variant = Variant.find(params[:product_id])
    else
      @variant = Variant.find(params[:variant_id])
    end
    respond_to do |format|
      if @variant.images.push @image
        format.html { redirect_to session[:variant_images_page], notice: 'Image was successfully created.' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    if params[:variant_id].nil?
      @variant = Variant.find(params[:product_id])
    else
      @variant = Variant.find(params[:variant_id])
    end
    @image = @variant.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to session[:variant_images_page], notice: 'Image was successfully updated.' }
      else
        format.html { render action: 'edit'}
      end
    end
  end

  def destroy
    @variant = Variant.find(params[:variant_id])

    @image = @variant.images.find(params[:id])
    @image.delete

    respond_to do |format|
      format.html { redirect_to admin_products_url(I18n.locale) }
      format.json { head :no_content }
    end
  end

end