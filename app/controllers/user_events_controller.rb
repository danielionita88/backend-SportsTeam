class UserEventsController < ApplicationController
    
    def create
        user_event = UserEvent.find_by(event_id: params[:event_id], user_id: params[:user_id])
        if !user_event
            user_event=UserEvent.create(event_id: params[:event_id], user_id: params[:user_id])
            render json: user_event
        else
            render json: {message: "You've already joined this event"}
        end
    end

end
