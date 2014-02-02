class PagesController < ApplicationController
  include Admin::TaxonomiesHelper

  def home
    @variants = Variant.where(:is_master => :true)
    if params[:taxonomies].present?
      taxonomy_ids = []
      params[:taxonomies].each do |parent_taxonomy|
        parent_taxonomy.values.each_with_index do |t, index|
          taxonomy_ids[index] = []
          t.each do |taxonomy_id|
            taxonomy_ids[index] << Moped::BSON::ObjectId(taxonomy_id)
          end
        end
      end

      taxonomy_selector = nil
      taxonomy_ids.each_with_index do |ids, index|
        taxonomy_selector = Variant.in({'product.taxonomy_ids' => taxonomy_ids[index]}).selector,
                              taxonomy_selector
      end
      @variants = @variants.and(taxonomy_selector)
    end

    if params[:option_values].present?
      option_value_ids = []
      params[:option_values].each do |option_type|
        option_type.values.each_with_index do |o, index|
          option_value_ids[index] = []
          o.each do |option_value_id|
            option_value_ids[index] << Moped::BSON::ObjectId(option_value_id)
          end
        end
      end

      option_value_selector = nil
      option_value_ids.each_with_index do |ids, index|
        option_value_selector = Variant.in({'product.option_value_ids' => option_value_ids[index]}).selector,
                                  option_value_selector
      end
      @variants = @variants.and(option_value_selector)
    end
    @taxonomies = sorted_taxonomies
    @option_types = OptionType.all
  end
end