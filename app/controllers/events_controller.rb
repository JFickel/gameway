class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    event = current_user.events.new(event_params)
    if event.save
      redirect_to event.associate
    else
      redirect_to request.referer, alert: event.errors.full_messages
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    if event.update_attributes(event_params)
      redirect_to event.associate
    else
      redirect_to request.referer, alert: event.errors.full_messages
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to request.referer, notice: 'Event deleted'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :start_hour, :start_minute, :start_period, :starts_at, :ends_at, :team_id, :group_id)
  end
end
