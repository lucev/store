class Admin::ImagesController < AdminController

  def index
    @master_variant = Variant.find(params[:product_id])
    
    if(params[:id])
      @variant = Variant.find(params[:id])
    else
      @variant = @master_variant
    end

    @variants = Variant.where(:master_id => @master_variant.id)
    @images = @master_variant.images
    
    unless @variants.empty?
      @variants.each do |v|
        @images << v.images unless v.images.empty?
      end
    end
  end

  def new
    @image = Image.new
    if params[:id].nil?
      @variant = Variant.find(params[:product_id])
      @cancel_path = admin_product_path(I18n.locale, @variant)
    else
      @variant = Variant.find(params[:id])
      @cancel_path = admin_product_variant_path(I18n.locale, @variant.master_id, @variant)
    end
    @path = admin_product_images_path
    @submit_text = t(:create_image)
  end

  def create
    @master_variant = Variant.find(params[:product_id])
    if @master_variant.images.nil?
      @master_variant.images.build
    end
    @image = @master_variant.images.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_product_images_path, notice: 'Image was successfully created.' }
      else
        format.html { render action: "new" }
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