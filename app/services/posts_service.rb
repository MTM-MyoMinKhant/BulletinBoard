class PostsService
  def self.post_lists(q , current_user , p)
    @q = q
    @member = current_user

    if @member.role == 0
      @posts = @q.result.where(deleted_at: nil).includes(:create_user, :updated_user).paginate(page: p, per_page: 3)
      @excel_admin_posts = Post.all()
    elsif @member.role == 1
      @posts = @q.result.where(deleted_at: nil , create_user_id: @member.id).includes(:create_user, :updated_user).paginate(page: p, per_page: 3)
      @excel_admin_posts = Post.all()
    else
      byebug
    end
  end

  def self.soft_delete(current_user , params)
    @member = current_user
    @post = Post.find(params[:id]);
    @post.update_column(:deleted_at , Time.now) 
    @post.update_column(:deleted_user_id , params[:delete_id])
  end
end
