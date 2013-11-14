class TimeValidator < ActiveModel::Validator
  def validate record
    time_is_not_in_the_past record
    presence_of_date record
    hour_is_in_range record
    minute_is_in_range record
    numeric_presence_of_hour record
    numeric_presence_of_minute record
  end

  def time_is_not_in_the_past record
    if Time.zone.parse("#{record.start_date} #{record.start_hour}:#{record.start_minute}#{record.start_period}") < Time.current
      record.errors.add(record.class.model_name.singular, 'cannot be in the past')
    end
  end

  def presence_of_date record
    unless record.start_date.present?
      record.errors.add(record.class.model_name.singular, 'date is not present')
    end
  end

  def hour_is_in_range record
    if record.start_hour.to_i < 1 || record.start_hour.to_i > 12
      record.errors.add(record.class.model_name.singular, 'hour entered is invalid')
    end
  end

  def minute_is_in_range record
    if record.start_minute.to_i < 0 || record.start_minute.to_i > 59
      record.errors.add(record.class.model_name.singular, 'minute entered is invalid')
    end
  end

  def numeric_presence_of_hour record
    if !record.start_hour.match(/\A[+-]?\d+\Z/)
      record.errors.add(record.class.model_name.singular, 'hour is not present or is not numeric')
    end
  end

  def numeric_presence_of_minute record
    if !record.start_minute.match(/\A[+-]?\d+\Z/)
      record.errors.add(record.class.model_name.singular, 'minute is not present or is not numeric')
    end
  end
end
