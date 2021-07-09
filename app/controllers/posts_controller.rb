require 'pry'
class PostsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create,:destroy]
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: {errors: @post.errors.full_messages.join(", ")}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    #binding.pry
    if post_params[:likes].uniq.length != post_params[:likes].length
      render json: {errors: "You already liked this post"}, status: :unprocessable_entity
    elsif @post.update(post_params)
      render json: @post
    else
      render json: {errors: @post.errors.full_messages.join(", ")}, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :files, likes: [])
    end
end
