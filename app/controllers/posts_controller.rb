class PostsController < ApplicationController
    def index
        @user = current_user       
        @q = Post.ransack(params[:q])
        if @user.role == 0
            @posts = @q.result.includes(:create_user, :updated_user).where(status: 1).paginate(page: params[:page], per_page: 3)
        elsif @user.role == 1
            @posts = @q.result.includes(:create_user, :updated_user).where(create_user_id: @user.id).paginate(page: params[:page], per_page: 3)
        else
            byebug 
        end
        @test = ""
    end

    def new
        @user = current_user
        @post = Post.new
    end

    def confirm_post
        @user = current_user
        @post = Post.new(post_params)
        if @post.valid?
            redirect_to posts_confirm_path(post: {title: @post.title , description: @post.description ,
                                                  status: @post.status ,  create_user_id: @post.create_user_id ,
                                                  updated_user_id: @post.updated_user_id})
        else
            render :new, status: :unprocessable_entity  
        end   
    end

    def confirm
        @user = current_user
        @post = Post.new(post_params)
    end

    def create
        @user = current_user
        @post = Post.new(post_params)
        if @post.save
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
        @user = current_user
        @post = Post.find(params[:id])
    end

    def edit_confirm_post
        @user = current_user
        @post = Post.new(post_params)
        @post.id = (params[:id])
        @test = "success"
        if @post.valid?
            redirect_to edit_confirm_path(post: {title: @post.title , description: @post.description ,
                                                  status: @post.status ,  create_user_id: @post.create_user_id ,
                                                  updated_user_id: @post.updated_user_id}, id: params[:id])
        else
            render :edit, status: :unprocessable_entity  
        end  
    end

    def edit_confirm
        @user = current_user
        @post = Post.new(post_params)
        @post.id = (params[:id])
        @test = "success"
    end

    def update
        @user = current_user
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to posts_path
        else
            render :edit, status: :unprocessable_entity 
        end 
    end

    def csv
        @user = current_user
    end

    private
        def post_params
            params.require(:post).permit(:title , :description , :status , :create_user_id, :updated_user_id)
        end
end
