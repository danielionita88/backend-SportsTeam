class FriendshipsController < ApplicationController
   
    def create
        friendship = Friendship.create(friendship_params)
        friend_request = FriendRequest.where(requestor_id: params[:friend_id], receiver_id: params[:user_id])
        friend_request.destroy()
        render json :friendship
    end

    private

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id)
    end
end
