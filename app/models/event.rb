class Event < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :team
  belongs_to :user
  belongs_to :group

  attr_accessor :start_date, :start_hour, :start_minute, :start_period,
                :end_date, :end_hour, :end_minute, :end_period
  validates_with TimeValidator, on: :create
  validates_with TimeValidator, on: :update, if: :time_parameters?
  before_save :set_starts_at

  def set_starts_at
    self.starts_at = DateTime.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def time_parameters?
    start_hour.present? || start_minute.present? || start_date.present?
  end

  def associate
    if group.present?
      group
    elsif team.present?
      team
    end
  end
end
