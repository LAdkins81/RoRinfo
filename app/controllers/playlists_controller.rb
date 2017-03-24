class PlaylistsController < ApplicationController
  def create
    playlist = Playlist.new
    playlist.song_id = params[:song_id]
    playlist.user_id = session[:user_id]
    if playlist.save
      redirect_to '/songs'
    else
      flash[:errors] = playlist.errors.full_messages
      redirect_to '/songs'
    end
  end
end
