class UsersController < ApplicationController
  require 'will_paginate/array'
  def user_lists 
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
    @img_file = user_params[:avatar]
  
    @test = "Success"
    if @user.valid?
      session[:avatar_data] = @img_file
      redirect_to users_confirm_users_path(user: {name: @user.name , email: @user.email , password: @user.password ,
                                                  password_confirmation: @user.password_confirmation , phone: @user.phone,
                                                  address: @user.address , dob: @user.dob , avatar: @user.avatar, role: @user.role ,
                                                  create_user_id: @user.create_user_id , updated_user_id: @user.updated_user_id
                                                  })
    else
      render :new, status: :unprocessable_entity  
    end   
  end

  def confirm
    byebug
    @member = current_user
    @user = User.new(user_params)  
    @img = session[:avatar_data]    
    @file_path = user_params[:avatar] 
    session.delete(:avatar_data)
  end

  def acc_create
    byebug
    @member = current_user
    @user = User.new(user_params)
    @test = 'Succeed'
    if @user.save
      @id = User.find_by(email: @user.email)
      @folder_path = "public/uploads/user/avatar/" + @id.id.to_s 
      @id.update(avatar: user_params[:avatar])
      Dir.mkdir(@folder_path) unless File.exist?(@folder_path)
      redirect_to users_user_lists_users_path , flash: {success: "User Profile Successfully Created"}
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
