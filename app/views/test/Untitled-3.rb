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

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_user_lists_path
        else 
            render :new, status: :unprocessable_entity  
        end         
    end

    def show
    end

    private
        def user_params
            params.require(:user).permit(:name , :email , :password , :password_confirmation ,
                                         :phone , :address , :dob , :avatar ,
                                         :role , :create_user_id, :updated_user_id)
        end


        
