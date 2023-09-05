class UsersService
  def user_lists()
    
  end

  def create_acc(user_params)
    byebug
    @test = "success"
    @user = User.new(user_params)
    @user.save
  end
  
  def update_acc(id , edit_params)
    @user = User.find(id)
    @user.update(edit_params)
    @test = "Success"
  end

  def soft_delete(id , delete_id)
    @user = User.find(id);
    @user.update_column(:deleted_at, Time.now)
    @user.update_column(:deleted_user_id, delete_id)
  end
end
