class UsersController < ApplicationController

    def login
      user=User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        token = JWT.encode({id:user.id}, 'secret', 'HS256')
        render json: {id: user.id, first_name: user.first_name, last_name: user.last_name,token: token}, status: :created
      else
        render json: { error: 'failed to login' }, status: :not_acceptable
      end
    end
    
    def create
        user = User.create(user_params)
        if user.valid?
          token = JWT.encode({id:user.id}, 'secret', 'HS256')
          render json: {id: user.id, first_name: user.first_name, last_name: user.last_name,token: token}, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end
     
    private

    def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
    end
    
end
