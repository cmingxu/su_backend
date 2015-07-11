class Dashboard::MaterialsController < Dashboard::BaseController
  def index
    @materials = policy_scope(Material).page params[:page]
  end
end
