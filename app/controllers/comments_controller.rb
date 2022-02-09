class CommentsController < ApplicationController

# I started with this: https://dev.to/lucysuddenly/nested-comments-in-ruby-on-rails-1k1f
# But I need to check an issue with https://blog.kiprosh.com/nested-commenting-system-without-using-any-gem/

  before_action :find_commentable, only: :create

    def new
      @comment = Comment.new
    end

    def create
      puts @commentable
      puts "read above"
      puts params[:comment_id]
      puts "read above"
      puts params[:post_id]
      puts "read above"
      puts comment_params
      puts "read above"
      @c = @commentable.comments.build(comment_params)
      @c.user_id = current_user.id

      if @c.save
        redirect_back fallback_location: root_path, notice: 'Your comment was successfully posted!'
      else
        redirect_back fallback_location: root_path, notice: "Your comment wasn't posted!"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end

end
