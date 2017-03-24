class UsersController < ApplicationController
  def main
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/songs'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to root_path
    end
  end

  def login
    user = User.find_by_email(params[:email])
    if user.nil?
      flash[:errors] = ['User Not Found']
      redirect_to root_path
    else
      if user.authenticate params[:password]
        session[:user_id] = user.id
        redirect_to '/songs'
      else
        flash[:errors] = ['Incorrect Password']
        redirect_to root_path
      end
    end
  end

  def show
    @user = User.includes(:songs).find(params[:id])
    @songs = @user.songs.find_by_sql("select * from songs group by title")
    @count = Playlist.group(:song_id).count
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
