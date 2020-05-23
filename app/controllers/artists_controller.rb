class ArtistsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    if @artist.save
      redirect_to artist_path(@artist), notice: '投稿に成功しました。'
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    if @artist.user != current_user
      redirect_to artists_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to artist_path(@artist),notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy
    redirect_to artists_path
  end

  private
  def artist_params
    params.require(:artist).permit(:title, :body, :image)
  end
end
