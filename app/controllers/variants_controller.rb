class VariantsController < ApplicationController
  include Admin::TaxonomiesHelper

  def show
    @variant = Variant.find(params[:id])
    @variants = Variant.where(master_id: @variant.master_id)

    @taxonomies = sorted_taxonomies
    @option_types = OptionType.all
  end
  
end
