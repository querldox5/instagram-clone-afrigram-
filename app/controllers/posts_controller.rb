class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy]

  def index
    @posts = Post.all.limit(10).includes(:user).order('created_at desc')
    @post = Post.new
  end

  def create
    @post = current_user.posts.create!(post_params)
    @post.images.attach(params[:post][:images])
    if @post.save
      redirect_to :posts
      flash[:notice] = 'Saved ---'
    else
      flash[:alert] = 'Something went wrong .....'
      redirect_to :posts
    end
  end

  def show; end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      flash[:alert] = "Sorry, you're not permitted to edit this post"
      redirect_to :root
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'Post successfully updated'
      redirect_to :post
    else
      flash[:alert] = 'Something went wrong'
      render('edit')
    end
    # @post = current_user.posts.update!(post_params)
    # if @post.save
    #   redirect_to :posts
    #   flash[:notice] = 'Saved ---'
    # else
    #   flash[:alert] = 'Something went wrong .....'
    #   redirect_to :posts
    # end
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted'
      else
        flash[:alert] = 'Something went wrong'
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to :root
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post

    flash[:danger] = 'Post does not exist!'
    redirect_to :root
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
