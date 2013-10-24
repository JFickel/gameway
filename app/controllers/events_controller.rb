class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    event = current_user.events.new(event_params)
    if event.save && event.group.present?
      redirect_to event.group
    elsif event.save && event.team.present?
      redirect_to event.team
    else
      redirect_to request.referer
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :start_hour, :start_minute, :start_period, :starts_at, :ends_at, :team_id, :group_id)
  end
end
