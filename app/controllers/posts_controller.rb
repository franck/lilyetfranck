class PostsController < ApplicationController
  
  before_filter :get_top_page_photos
  
  def index  
    @posts = Post.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
end
