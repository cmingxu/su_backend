class Api::EntitiesController < Api::BaseController
  respond_to :json
  
  def index
    @entities = Entity.visible.site_level.page params[:page]
  end
end
