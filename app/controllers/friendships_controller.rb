class FriendshipsController < ApplicationController
   
    def create
        friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
        if !friendship
            new_friendship = Friendship.create(friendship_params)
            friend_request = FriendRequest.where(requestor_id: params[:friend_id], receiver_id: params[:user_id])
            friend_request.delete_all
            render json: new_friendship
        else
            render json: {message: 'already a friend'}
        end
    end

    private

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end
end
