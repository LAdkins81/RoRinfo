class SongsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @songs = Song.find_by_sql("select * from songs group by title")
    @count = Song.group(:title).count
  end

  def create
    song = Song.new(song_params)
    song.added = 1
    if song.save
      flash[:notice] = "You have successfully added a song!"
      redirect_to '/songs'
    else
      flash[:errors] = song.errors.full_messages
      redirect_to '/songs'
    end
  end

  def show
    @song = Song.includes(:users).find(params[:id])
    @count = Playlist.group(:user_id).count
  end

  private
  def song_params
    params.require(:song).permit(:artist, :title)
  end
end
