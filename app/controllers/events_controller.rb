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

    def update
        event = Event.find(params[:id])
        event.update(event_params)
        render json: event
    end

    def destroy
        event = Event.find(params[:id])
        event.destroy()
        render json: {message: 'event deleted successfully'}
    end

    private

    def event_params
        params.require(:event).permit(:name, :location, :time, :date,:details, :user_id)
    end
end
