class Admin::VariantOptionValuesController < AdminController

  def edit
    @master_variant = Variant.find(params[:product_id])
    @variant = Variant.find(params[:variant_id])
    @option_type = OptionType.find(params[:id])
    @option_value = OptionValue.new
  end

  def create
    @option_value = OptionValue.find(params[:option_value][:id])
    @master_variant = Variant.find(params[:product_id])
    @variant = Variant.find(params[:variant_id])

    @variant.option_values << @option_value
    @variant.save

    redirect_to edit_admin_product_variant_path(@master_variant, @variant)
  end

end