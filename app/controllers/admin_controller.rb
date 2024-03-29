class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authorized?

  layout 'admin/layouts/application'

  def authorized?
    unless current_user.has_role? :admin
      redirect_to root_path
    end
  end
end
