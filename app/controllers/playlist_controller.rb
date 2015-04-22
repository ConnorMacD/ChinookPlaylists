class PlaylistController < ActionController::API
  def index
    @playlists = Playlist.where(ApiKey: params[:ApiKey])
    render json: @playlists.to_json(:include => :playlisttracks)
  end

  def show
    @playlist = Playlist.find(params[:id])
    render json: @playlist.to_json(:include => :playlisttracks)
  end

  def create
    @playlist = Playlist.new('Name' => params[:Name], 'ApiKey' => params[:ApiKey])
    if (params.has_key?(:Tracks))
      params[:Tracks].each do |t|
        @playlist.playlisttracks << PlaylistTrack.new('PlaylistId' => @playlist.PlaylistId, 'TrackId' => t)
      end
    end
    if @playlist.save
      message = 'Playlist Created!'
      render json: message
    else
      message = 'Creation failed!'
      render json: message
    end
  end

  def update
    if (Playlist.exists?(:PlaylistId => params[:id], :ApiKey => params[:ApiKey]))
      @playlist = Playlist.find(params[:id])
      if (params.has_key?(:DeleteTracks))
        params[:DeleteTracks].each do |t|
          PlaylistTrack.delete_all(PlaylistId: @playlist.PlaylistId, TrackId: t)
        end
      end
      if (params.has_key?(:AddTracks))
        params[:AddTracks].each do |t|
          @playlist.playlisttracks << PlaylistTrack.new('PlaylistId' => @playlist.PlaylistId, 'TrackId' => t)
        end
      end

      if (params.has_key?(:Name))
        @playlist.update('Name' => params[:Name])
      end

      message = 'Playlist Updated!'
      render json: message
    else
      message = 'Invalid Playlist ID, API key, or an error has occured.'
      render json: message
    end
  end

  def destroy
    if (Playlist.exists?(:PlaylistId => params[:id], :ApiKey => params[:ApiKey]))
      @playlist = Playlist.find(params[:id])
      if @playlist.destroy
        message = 'Playlist destroyed!'
        render json: message
      else
        message = 'Destroy failed!'
        render json: message
      end
    else
      message = 'Invalid Playlist ID or API key.'
      render json: message
    end
  end
end
