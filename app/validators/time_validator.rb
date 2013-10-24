class TimeValidator < ActiveModel::Validator
  def validate record
    presence_of_date record
    hour_is_in_range record
    minute_is_in_range record
    numeric_presence_of_hour record
    numeric_presence_of_minute record
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
