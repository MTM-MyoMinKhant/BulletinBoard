class UsersController < ApplicationController
    require 'will_paginate/array'
    def index
        
    end

    def user_lists
        @q = User.ransack(params[:q])
        @users_list = @q.result.to_a.paginate(page: params[:page], per_page: 2)
    end

    def new
        @user = User.new()
    end

    def confirm_post
        @user = User.new(user_params)
        @test = "Success"
        if @user.valid?
            redirect_to users_confirm_path(user: {name: @user.name , email: @user.email , password: @user.password ,
                                                 password_confirmation: @user.password_confirmation , phone: @user.phone,
                                                 address: @user.address , dob: @user.dob , avatar: @user.avatar , role: @user.role ,
                                                 create_user_id: @user.create_user_id , updated_user_id: @user.updated_user_id
                                                 })
        else
            render :new, status: :unprocessable_entity  
        end   
    end

    def confirm
        @user = User.new(user_params)
        @test = "Success"
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_user_lists_path
        else 
            render :new, status: :unprocessable_entity  
        end         
    end

    def show
      @user = User.find(params[:id])
      test  = "success"
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @wew = edit_params
        @test2 = "Succeed2"
        @test = "Succeed"
        if @user.update(edit_params)
            redirect_to user_path(@user.id)
        else
            render :edit, status: :unprocessable_entity 
        end 
    end

    def change_password
      @user = User.find(params[:id])
    end

    def password_update
      @user = User.find(params[:id])
      @params = params[:user][:old_password]
      @test = "success"

      if @user.authenticate(@params)        
        if @user.update(password_params)
          redirect_to users_user_lists_path
        else
          render :change_password , status: :unprocessable_entity
        end
      else
        @user.errors.add(:old_password, "Old Password can't be blank and need to same with your password")
        render :change_password , status: :unprocessable_entity
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
