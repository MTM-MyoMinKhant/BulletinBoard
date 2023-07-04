class PostsController < ApplicationController
    def index   
      require 'csv' 
      @q = Post.ransack(params[:q])
      @posts = @q.result.includes(:create_user, :updated_user).paginate(page: params[:page], per_page: 3)
      @excel_admin_posts = Post.all()
    end

    def new
      @post = Post.new
    end

    def confirm_post
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
      @post = Post.new(post_params)
    end

    def create
      @post = Post.new(post_params)
      if @post.save
          redirect_to posts_path
      else
          render :new, status: :unprocessable_entity 
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def edit_confirm_post
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
      @post = Post.new(post_params)
      @post.id = (params[:id])
      @test = "success"
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
          redirect_to posts_path
      else
          render :edit, status: :unprocessable_entity 
      end 
    end

    def csv
    end

    def csv_upload
      
      @file = params[:file]
      file = File.open(@file)
      csv = CSV.parse(file , headers: true)
      csv.each do |row|
          post_hash = Hash.new
          post_hash[:title] = row["title"]  
          post_hash[:description] = row["description"]
          post_hash[:status] = row["status"]
          post_hash[:create_user_id] = row["create_user_id"]
          post_hash[:updated_user_id] = row["updated_user_id"] 
          Post.create(post_hash)
      end
      @test = "Success"
      return redirect_to posts_csv_path, notice: "Only CSV please" unless @file.content_type == "text/csv"
      redirect_to posts_path
    end

    private
      def post_params
        params.require(:post).permit(:title , :description , :status , :create_user_id, :updated_user_id)
      end
end
