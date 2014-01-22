class AdminController < ApplicationController
  before_filter :authorized?

  def authorized?
    redirect_to root_path(I18n.locale)
  end

end