class UsersController < ApplicationController
    def index
        @user = current_user
        if @user.role == 0
            redirect_to admin_index_path
        end
    end

    def user_lists
        @user = current_user
        @q = User.ransack(params[:q])
        @users_list = @q.result.page(params[:page])
    end

    def show
    end
end
