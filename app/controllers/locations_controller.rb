class LocationsController < ApplicationController

  def index
    @title = t('view.locations.index_title')
    @locations = Location.all.page(params[:page])
  end

  def create
    @location = Location.create(location_params)

    render nothing: true
  end

  private
    def location_params
      _params = params.require(:location).permit(:latitude, :longitude)
      _params[:user_id] = current_user.id
      _params
    end
end
