class PostsController < ApplicationController
    def index
        @user = current_user
    end

    def new
        @user = current_user
        @post = Post.new
    end

    def create
        byebug
        @user = current_user
        @post = Post.new(post_params)
        if @post.save
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def confirm
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def csv
        @user = current_user
    end

    private
        def post_params
            params.require(:post).permit(:title , :description , :create_user_id, :updated_user_id)
        end
end
