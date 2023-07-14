class UsersController < ApplicationController
  require 'will_paginate/array'
  def user_lists 
    flash_data = params[:flash]
    flash[:success] = flash_data[:success] if flash_data && flash_data[:success]
    @member = current_user
    @q = User.ransack(params[:q])
    @users_list = @q.result.where(deleted_at: nil).paginate(page: params[:page], per_page: 5)
  end

  def new
    @member = current_user
    @user = User.new()
  end

  def confirm_post
    byebug
    @member = current_user
    @user = User.new(user_params)
  
    @test = "Success"
    if @user.save
      redirect_to users_confirm_users_path(user: @user.email)
    else
      render :new, status: :unprocessable_entity  
    end   
  end

  def confirm
    byebug
    @member = current_user
    @fetch = params[:user]
    @user = User.find_by(email: @fetch)
    @test = "Succeed"
  end

  def acc_create
    byebug
    @member = current_user
    @user = User.find(params[:id])
    @test = 'Succeed'
    if @user.destroy
      redirect_to users_user_lists_users_path
    else 
      render :new, status: :unprocessable_entity  
    end
  end

  def show
    @member = current_user
    @user = User.find(params[:id])
    test  = "success"
  end

  def edit
    @member = current_user
    @user = User.find(params[:id])
  end

  def update
    @member = current_user
    @user = User.find(params[:id])
    @wew = edit_params
    @test2 = "Succeed2"
    @test = "Succeed"
    if @user.update(edit_params)
        redirect_to user_path(@user.id) , flash: {success: "User Successfully Updated"}
    else
        render :edit, status: :unprocessable_entity 
    end 
  end

  def soft_delete
    @member = current_user
    @user = User.find(params[:id]);
    @user.update_column(:deleted_at, Time.now)
    @user.update_column(:deleted_user_id, params[:delete_id])
    redirect_to users_user_lists_path , flash: {success: "User Successfully Deleted"}
  end

  def change_password
    @member = current_user
    @user = User.find(params[:id])
  end

  def password_update
    byebug
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
