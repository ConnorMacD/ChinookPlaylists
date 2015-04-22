class TracksController < ActionController::API
  def index
    @tracks = Track.all.limit(50)
    render json: @tracks
  end
end
