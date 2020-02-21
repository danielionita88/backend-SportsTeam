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
      query = params[:q].split(' ')
      if query[1].blank?
        users = User.search(query[0])
      else 
        users = User.search(query[0]).push(User.search(query[1])).flatten.uniq
      end
      render json: users
    end

    def friend_requests
      user = User.find(params[:id])
      requestors = user.requests.map{|req| User.find(req.requestor_id)}
      render json: requestors
    end

    def friends 
      user = User.find(params[:id])
      render json: user.friends
    end


    private

    def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
    end
    
end
