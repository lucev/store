class VariantsController < ApplicationController

  def show
    @variant = Variant.find(params[:id])
    @product_variants = Variant.where(master_id: @variant.master_id)
  end
  
end
