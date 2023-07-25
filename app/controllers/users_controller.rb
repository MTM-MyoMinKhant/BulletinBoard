class UsersController < ApplicationController
  require 'will_paginate/array'

  # don;t know how
  def user_lists 
    byebug
    flash_data = params[:flash]
    flash[:success] = flash_data[:success] if flash_data && flash_data[:success]
    @member = current_user
    @q = User.ransack(params[:q])
    @users_list = @q.result.where(deleted_at: nil).paginate(page: params[:page], per_page: 5)
    # @user_lists = UsersService.new.user_lists(flash: params[:flash], q: params[:q], page: params[:page])
  end

  # no need
  def new
    @member = current_user
    @user = User.new()
  end

  # done
  def confirm_post
    @member = current_user
    @user = User.new(user_params)
    unless @user.valid?
      return render :new , status: :unprocessable_entity
    end
    @user = UsersService.new.create_acc(user_params)
    if @user
      redirect_to users_confirm_users_path(user: user_params[:email])
    end
  end

  # no need
  def confirm
    @member = current_user
    @fetch = params[:user]
    @user = User.find_by(email: @fetch)
  end

  # no need
  def acc_create
    @member = current_user
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_user_lists_users_path
    else 
      render :new, status: :unprocessable_entity  
    end
  end

  # no need
  def show
    @member = current_user
    @user = User.find(params[:id])
  end

  # no need
  def edit
    @member = current_user
    @user = User.find(params[:id])
  end

  # still need fixing
  def update
    @member = current_user
    @user = User.find(params[:id])
    @wew = edit_params
    if @user.update(edit_params)
        redirect_to user_path(@user.id) , flash: {success: "User Successfully Updated"}
    else
        render :edit, status: :unprocessable_entity 
    end 
  end

  # done
  def soft_delete
    @member = current_user
    @delete = UsersService.new.soft_delete(params[:id] , params[:delete_id])
    if @delete
      redirect_to users_user_lists_users_path , flash: {success: "User Successfully Deleted"}
    end
  end

  # no need
  def change_password
    @member = current_user
    @user = User.find(params[:id])
  end

  # no need
  def password_update
    @member = current_user
    @user = User.find(params[:id])
    @params = params[:user][:old_password]
    if password_params[:password] == ""
        @user.errors.add(:password ," cannot be blank") 
        render :change_password , status: :unprocessable_entity 
    else
      if @user.valid_password?(@params)        
        if @user.update(password_params)
          redirect_to users_user_lists_users_path , flash: {success: "Password is Successfully Updated"}
        else
          render :change_password , status: :unprocessable_entity
        end
      else
        @user.errors.add(:old_password, "Old Password can't be blank and need to same with your password")
        render :change_password , status: :unprocessable_entity
      end
    end  
  end

  private
    def user_params
      params.require(:user).permit(:name , :email , :password , :password_confirmation ,
                                    :phone , :address , :dob , :avatar ,
                                    :role , :create_user_id, :updated_user_id)
    end
    
    def edit_params
      params.require(:user).permit(:name , :email , :phone , :address , :dob , :avatar ,
                                    :role , :create_user_id, :updated_user_id)
    end

    def password_params
      params.require(:user).permit(:password , :password_confirmation)
    end
end
