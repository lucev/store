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

  def edit
    @master_variant = Variant.find(params[:product_id])
    @option_type = OptionType.find(params[:id])
    # @option_value = OptionValue.new
    # @product_option_values = @master_variant.product.option_values.where(option_type_id: @option_type.id)
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

  def update
    @master_variant = Variant.find(params[:product_id])
    @option_value = OptionValue.find(params[:option_type][:option_value][:id])

    @master_variant.product.option_values << @option_value
    @master_variant.product.save

    respond_to do |format|
      format.html { redirect_to admin_product_option_types_url(@master_variant), notice: 'Product was successfully updated.'}
      format.json { head :no_content}
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