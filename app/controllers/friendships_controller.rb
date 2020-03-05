class FriendshipsController < ApplicationController
   
    def create
        friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
        if !friendship
            new_friendship = Friendship.create(friendship_params)
            friend_request = FriendRequest.where(requestor_id: params[:friend_id], receiver_id: params[:user_id])
            friend_request.delete_all
            friend=User.find(params[:friend_id])
            render json: friend
        else
            render json: {error: 'already a friend'}
        end
    end

    def delete
        friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
        friendship.destroy
        render json: {message: 'friendship deleted'}
    end

    private

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end
end
