class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id])
  end

  # GET /blogs
  # GET /blogs.json
  def index
    if @user == current_user
      @blogs = current_user.blogs
    else
      @blogs = @user.blogs.published
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    if @user == current_user
      @blog = @user.blogs.find(params[:id])
    else
      @blog = @user.blogs.published.find(params[:id])
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)
    if params[:commit] == "Save as Draft"
      @blog.published_at = nil
    else
      @blog.published_at = Time.now
    end

    respond_to do |format|
      if @blog.save
        format.html {
          redirect_to [@user, @blog], notice: 'Blog was successfully created.'
        }
        format.json { render action: 'show', status: :created, location: [@user, @blog] }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to [@user, @blog], notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    unless @user == current_user
      return redirect_to user_blogs_url(@user)
    end

    @blog.destroy
    respond_to do |format|
      format.html { redirect_to user_blogs_url(@user) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :topics, :user_id)
    end
end
