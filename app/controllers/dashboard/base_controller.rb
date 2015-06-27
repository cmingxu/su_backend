class Dashboard::BaseController < ApplicationController
  layout "dashboard"
  before_filter :authenticate_user!

  def index
    @folders = current_user.folders
  end
end
