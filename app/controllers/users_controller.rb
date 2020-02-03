class UsersController < ApplicationController
    
    def create
        user = User.create(user_params)
        if user.valid?
          render json: user, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end
     
    private

    def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
    end
    
end
