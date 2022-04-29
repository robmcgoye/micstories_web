class OnOrAfterTodayValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.present? && (value >= Date.current)
      record.errors.add(attribute, "date is in the past")
    end
  end


end