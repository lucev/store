class Admin::ProductTaxonomiesController < AdminController
  include Admin::TaxonomiesHelper

  def index
    @master_variant = Variant.find(params[:product_id])
    @taxonomies = @master_variant.product.taxonomies
  end

  def new
    @master_variant = Variant.find(params[:product_id])
    @taxonomy = Taxonomy.new
    @taxonomies = sorted_taxonomies
  end

  def update
    @master_variant = Variant.find(params[:product_id])
    @taxonomy = Taxonomy.find(params[:variant][:taxonomy][:taxonomy])
    @master_variant.product.taxonomies << @taxonomy
    @master_variant.product.taxonomies << @taxonomy.ancestors
    
    respond_to do |format|
      if @master_variant.product.save
        format.html { redirect_to admin_product_taxonomies_url(@master_variant), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @taxonomy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @master_variant = Variant.find(params[:product_id])
    @taxonomy = @master_variant.product.taxonomies.find(params[:id])
    @master_variant.product.taxonomies.find(@taxonomy.children).delete rescue ''
    @master_variant.product.taxonomies.delete(@taxonomy) rescue ''

    respond_to do |format|
      format.html { redirect_to admin_product_taxonomies_url(@master_variant), notice: 'Taxonomy was successfull removed.'}
      format.json { head :no_content}
    end
  end

end