class PagesController < ApplicationController

  def home
    @variants = Variant.all
  end
end
