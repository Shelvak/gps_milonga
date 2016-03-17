class LocationsController < ApplicationController
  before_action :set_location, only:  [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    @title = t('view.locations.index_title')
    @locations = Location.all.page(params[:page])
  end

  # GET /locations/1
  def show
    @title = t('view.locations.show_title')
  end

  # GET /locations/new
  def new
    @title = t('view.locations.new_title')
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @title = t('view.locations.edit_title')
  end

  # POST /locations
  def create
    @title = t('view.locations.new_title')
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: t('view.locations.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /locations/1
  def update
    @title = t('view.locations.edit_title')

    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: t('view.locations.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_location_url(@location), alert: t('view.locations.stale_object_error')
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    redirect_to locations_url, notice: t('view.locations.correctly_destroyed')
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude, :user_id)
    end
end
