class UsersController < ApplicationController

    def login
      user=User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        token = JWT.encode({id:user.id}, Rails.application.credentials.jwt_key, 'HS256')
        render json: {id: user.id, first_name: user.first_name, last_name: user.last_name,token: token}, status: :created
      else
        render json: { error: 'failed to login' }, status: :not_acceptable
      end
    end
    
    def create
        user = User.create(user_params)
        if user.valid?
          token = JWT.encode({id:user.id}, Rails.application.credentials.jwt_key, 'HS256')
          render json: {id: user.id, first_name: user.first_name, last_name: user.last_name,token: token}, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def show
      token = request.headers['Authorization'].split(' ')[1]
      decoded_token = JWT.decode token, Rails.application.credentials.jwt_key, true, { algorithm: 'HS256' }
      user_id=decoded_token[0]['id']
      user=User.find(user_id)
      if user
          render json: {id: user.id, first_name: user.first_name,last_name: user.last_name, token: token}
      else 
          render json: {error: 'invalid token'}
      end

    end

    def events
      user = User.find(params[:id])
      render json:  user.events
    end
     
    def search
        search = params[:q].split(' ')
        users= User.all.where("first_name LIKE ? OR last_name LIKE ?", "%#{search[0]}%", "%#{search[1]}%")
        render json: users
    end


    private

    def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
    end
    
end
