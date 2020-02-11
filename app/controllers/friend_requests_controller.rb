class FriendRequestsController < ApplicationController

    def create
        request = FriendRequest.create(request_params)
        if request.valid?
            render json: request
        else
            render json: {error: 'could not send request!'}
        end
    end

    private

    def request_params
        params.require(:friend_request).permit(:requestor_id, :receiver_id)
    end

end
