class EventsController < ApplicationController
    def index
        events = Event.all 
        render json: events
    end

    def create
        event = Event.create(event_params)
        if event.valid?
            render json: event
        else
            render json: {error: 'failed to create event'}
        end
    end

    private

    def event_params
        params.require(:event).permit(:name, :location, :time, :date,:details, :user_id)
    end
end
