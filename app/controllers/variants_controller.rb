class VariantsController < ApplicationController

  def show
    @master_variant = Variant.find(params[:id])
    @variants = Variant.where(master_id: @master_variant.id)
  end
  
end
