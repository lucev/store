class VariantsController < ApplicationController
  include Admin::TaxonomiesHelper

  def show
    @variant = Variant.find(params[:id])
    @variants = Variant.where(master_id: @variant.master_id)

    @taxonomies = sorted_taxonomies
    @option_types = OptionType.all

    @options = Hash.new
    @variant.option_values.each do |option_value|
      unless @options.has_key?(option_value.option_type)
        @options[option_value.option_type] = []
      end
      @options[option_value.option_type] << option_value
    end

  end
  
end
