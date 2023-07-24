class PostsController < ApplicationController
  # don't know how 
  def index 
    @test = "succeed"
    require 'csv' 
    @q = Post.ransack(params[:q])
    @member = current_user
    if @member.role == 0
      @posts = @q.result.where(deleted_at: nil).includes(:create_user, :updated_user).paginate(page: params[:page], per_page: 3)
      @excel_admin_posts = Post.all()
      @test = "Succeed"
    elsif @member.role == 1
      @posts = @q.result.where(deleted_at: nil , create_user_id: @member.id).includes(:create_user, :updated_user).paginate(page: params[:page], per_page: 3)
      @excel_admin_posts = Post.all()
    else
      byebug
    end
    #@posts = PostsService.post_lists(@q , current_user , params[:page])
  end

  # no need
  def new
    @member = current_user
    @post = Post.new
  end

  # no need
  def confirm_post
    @member = current_user
    @post = Post.new(post_params)
    if @post.valid?
        redirect_to posts_confirm_posts_path(post: {title: @post.title , description: @post.description ,
                                              status: @post.status ,  create_user_id: @post.create_user_id ,
                                              updated_user_id: @post.updated_user_id})
    else
        render :new, status: :unprocessable_entity  
    end   
  end

  #no need
  def confirm
    @member = current_user
    @post = Post.new(post_params)
  end

  #no need
  def create
    @member = current_user
    @post = Post.new(post_params)
    if @post.save
        redirect_to posts_path , flash: {success: "Post Successfully Created"}
    else
        render :new, status: :unprocessable_entity 
    end
  end

  #no need
  def edit
    @member = current_user
    @post = Post.find(params[:id])
  end

  #no need
  def edit_confirm_post
    @member = current_user
    @post = Post.new(post_params)
    @post.id = (params[:id])
    if @post.valid?
        redirect_to edit_confirm_post_path(post: {title: @post.title , description: @post.description ,
                                              status: @post.status ,  create_user_id: @post.create_user_id ,
                                              updated_user_id: @post.updated_user_id}, id: params[:id])
    else
        render :edit, status: :unprocessable_entity  
    end  
  end

  #no need
  def edit_confirm
    @member = current_user
    @post = Post.new(post_params)
    @post.id = (params[:id])
  end

  #no need
  def update
    @member = current_user
    @post = Post.find(params[:id])
    if @post.update(post_params)
        redirect_to posts_path , flash: {success: "Post Successfully Updated"}
    else
        render :edit, status: :unprocessable_entity 
    end 
  end

  #done 
  def soft_delete
    @post_delete = PostsService.soft_delete(current_user , params)
    redirect_to posts_path , flash: {success: "Post Successfully Deleted"}
  end

  # done
  def csv
    @member = current_user
  end

  # don't know how 
  def csv_upload   
    @member = current_user 
    @file = params[:file]   
    if @file == nil
      return redirect_to posts_csv_posts_path, notice: "Need to add CSV File"
    elsif @file.content_type == "text/csv"
      file = File.open(@file)
      csv = CSV.parse(file , headers: true)
      if csv.headers == ["title" , "description" , "status" , "create_user_id" , "updated_user_id"]
        csv.each do |row|
          post_hash = Hash.new
          post_hash[:title] = row["title"]  
          post_hash[:description] = row["description"]
          post_hash[:status] = row["status"]
          post_hash[:create_user_id] = row["create_user_id"]
          post_hash[:updated_user_id] = row["updated_user_id"] 
          Post.create(post_hash)
        end
        redirect_to posts_path, flash: {success: "CSV Upload Successfully"}
      else
        return redirect_to posts_csv_posts_path, notice: "Columns are not the same"
      end
    else
      return redirect_to posts_csv_posts_path, notice: "Only CSV file stupid"
    end
  end

  private
    def post_params
      params.require(:post).permit(:title , :description , :status , :create_user_id, :updated_user_id)
    end
end
