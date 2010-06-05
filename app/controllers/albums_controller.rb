class AlbumsController < ApplicationController
  
  before_filter :get_top_page_photos
  
  def index
    @albums = Album.find(:all, :order => "created_at desc")
  end
  
  def show
    @album = Album.find(params[:id])
  end
  
  def new
    @album = Album.new
  end
  
  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to @album
    else
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      redirect_to @album
    else
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_path
  end
  
end
