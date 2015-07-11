class Dashboard::EntitiesController < Dashboard::BaseController
  before_filter :find_entity, only: [:edit, :update, :destroy]

  def index
    @entities = Entity.page params[:page]
  end

  def new
    @entity = current_user.entities.new
  end

  def create
    @entity = policy_scope(Entity).new entity_param
    authorize @entity
    if @entity.save
    else
    end
  end

  def edit
  end

  def update
    authorize @entity
    if @entity.update_attributes entity_param
    else
    end
  end

  def destroy
    authorize @entity
  end

  private
  def entity_param
    params.require(:entity).permit!
  end

  def find_entity
    @entity  = policy_scope(Entity).find params[:id]
  end
end
