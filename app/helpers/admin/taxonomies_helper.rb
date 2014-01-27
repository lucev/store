module Admin::TaxonomiesHelper

  def sorted_taxonomies
    taxonomies = []
    @root_taxonomies = Taxonomy.where(parent_id: nil).order_by('created_at ASC')
    @root_taxonomies.each do |taxonomy|
      taxonomy.get_descendants(taxonomies)
    end
    taxonomies
  end
end