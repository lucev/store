class PagesController < ApplicationController

  def home
    @master_variants = Variant.where(is_master: true)
  end
end
