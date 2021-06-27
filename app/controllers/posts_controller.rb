class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  skip_before_action :require_login, only: [:new, :create]
  
  before_action :correct_user, only: [:edit, :delete]

  # GET /posts or /posts.json
  def index
    # @posts = Post.search(params[:search]).where('display_public', true)
    member = Member.find_by(user_id: session[:user_id])
    if member.nil?
      @posts = Post.search(params[:search]).where('display_public', true)
    else
      @posts = Post.search(params[:search]).where('display_public', true && member.post_id)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @users = User.all
  end

  # GET /posts/1/edit
  def edit
    @users = User.all
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        #add members
        member_ids = params[:user_ids]

        if member_ids.nil?
          
        else
          member_ids.each do |member_id|
            member = Member.new()
            member.user_id = member_id
            member.post_id = Post.last.id
            member.save
          end
        end

        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end    
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        #delete members
        url_id = Post.find_by_id(params[:id])
        members = Member.where(post_id: url_id.id)

        members.each do |member|
          member.destroy
        end

        # add members
        member_ids = params[:user_ids]

        if member_ids.nil?
          
        else
          member_ids.each do |member_id|
            member = Member.new()
            member.user_id = member_id
            member.post_id = Post.last.id
            member.save
          end
        end

        format.html { redirect_to posts_path, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :display_public, :seach)
    end
end
