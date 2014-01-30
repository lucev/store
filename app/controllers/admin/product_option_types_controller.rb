class Admin::ProductOptionTypesController < AdminController

  def index
    @master_variant = Variant.find(params[:product_id])
    @option_types = @master_variant.product.option_types
  end

  def new
    @master_variant = Variant.find(params[:product_id])
    @option_types = OptionType.all
    @option_type = OptionType.new
  end

  def create
    @master_variant = Variant.find(params[:product_id])
    @option_type = OptionType.find(params[:variant][:option_type][:id])

    @master_variant.product.option_types << @option_type

    respond_to do |format|
      format.html { redirect_to admin_product_option_types_url(@master_variant), notice: 'Product was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @master_variant = Variant.find(params[:product_id])
    @option_type = @master_variant.product.option_types.find(params[:id])
    @master_variant.product.option_types.delete(@option_type) rescue ''
    @master_variant.product.save

    respond_to do |format|
      format.html { redirect_to admin_product_option_types_url(@master_variant), notice: 'Product was successfully updated.' }
      format.json { head :no_content }
    end
  end
end