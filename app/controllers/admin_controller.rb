class AdminController < ApplicationController
    def index
        @user = current_user
        if @user.role == 1
            redirect_to users_path
        end
    end
end
