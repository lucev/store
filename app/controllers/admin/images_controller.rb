class Admin::ImagesController < AdminController

  def index
    @master_variant = Variant.find(params[:product_id])
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
    else
      @variant = Variant.find(params[:id])
    end
    @path = admin_product_images_path
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

end