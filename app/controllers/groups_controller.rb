class GroupsController < ApplicationController
  before_action :set_group, only:  [:show, :edit, :update, :destroy, :near_people]

  # GET /groups
  def index
    @title = t('view.groups.index_title')
    @groups = Group.all.page(params[:page])
  end

  # GET /groups/1
  def show
    @title = t('view.groups.show_title')
  end

  # GET /groups/new
  def new
    @title = t('view.groups.new_title')
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @title = t('view.groups.edit_title')
  end

  # POST /groups
  def create
    @title = t('view.groups.new_title')
    @group = Group.new(create_group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: t('view.groups.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /groups/1
  def update
    @title = t('view.groups.edit_title')

    respond_to do |format|
      if @group.update(update_group_params)
        format.html { redirect_to @group, notice: t('view.groups.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_group_url(@group), alert: t('view.groups.stale_object_error')
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: t('view.groups.correctly_destroyed')
  end

  def near_people
    locations = @group.last_locations_except_for_me(current_user)

    render json: locations.to_json
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def create_group_params
      _params = params.require(:group).permit(:name, :longitude, :latitude)
      _params[:owner_id] = current_user.id
      _params
    end

    def update_group_params
      params.require(:group).permit(:name, :longitude, :latitude)
    end
end
