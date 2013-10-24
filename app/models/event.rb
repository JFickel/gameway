class Event < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  belongs_to :group

  attr_accessor :start_date, :start_hour, :start_minute, :start_period,
                :end_date, :end_hour, :end_minute, :end_period
  validate :start_hour_is_in_range, :start_minute_is_in_range, :numeric_presence_of_start_hour, :numeric_presence_of_start_minute, :presence_of_start_date
  before_save :set_starts_at

  def set_starts_at
    self.starts_at = DateTime.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def presence_of_start_date
    unless start_date.present?
      errors.add(:tournament, 'date is not present')
    end
  end

  def start_hour_is_in_range
    if start_hour.to_i < 1 || start_hour.to_i > 12
      errors.add(:tournament, 'hour entered is invalid')
    end
  end

  def start_minute_is_in_range
    if start_minute.to_i < 0 || start_minute.to_i > 59
      errors.add(:tournament, 'minute entered is invalid')
    end
  end

  def numeric_presence_of_start_hour
    if !start_hour.match(/\A[+-]?\d+\Z/)
      errors.add(:tournament, 'hour is not present or is not numeric')
    end
  end

  def numeric_presence_of_start_minute
    if !start_hour.match(/\A[+-]?\d+\Z/)
      errors.add(:tournament, 'minute is not present or is not numeric')
    end
  end
end
