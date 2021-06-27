class MembersController < ApplicationController

	def create
        @post = Post.find(params[:post_id])
        @member = @post.members.create(params(:member).permit(:post_id, :user_id))
        redirect_to post_path(@post)    
  end
end
