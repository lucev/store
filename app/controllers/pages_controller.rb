class PagesController < ApplicationController
  include Admin::TaxonomiesHelper

  def home
    # @variants = Variant.all
    if params[:taxonomies].present?
      ids = []
      params[:taxonomies].each do |taxonomy_id|
        ids << Moped::BSON::ObjectId(taxonomy_id)
      end
      @variants = Variant.all('product.taxonomy_ids' => ids)
    else
      @variants = Variant.all
    end
    # @root_taxonomies = Taxonomy.where(parent_id: nil).order_by('created_at ASC')
    @taxonomies = sorted_taxonomies
  end
end
