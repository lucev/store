module Admin::TaxonomiesHelper

  def sorted_taxonomies
    taxonomies = []
    @root_taxonomies = Taxonomy.where(parent_id: nil).order_by('created_at ASC')
    @root_taxonomies.each do |root_taxonomy|
      taxonomies << root_taxonomy
      root_taxonomy.get_descendants(taxonomies)
    end
    taxonomies
  end

  def root_taxonomies
    Taxonomy.where(parent_id: nil).order_by('created_at ASC')
  end
end