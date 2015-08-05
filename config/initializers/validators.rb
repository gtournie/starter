class EmailValidator < ActiveModel::EachValidator
  REG_EMAIL = Regexp.new( # The following pattern matches about 99.99% of actual uses.
      '^[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*' +
          '@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$', 'i')

  def validate_each(record, attribute, value)
    unless value =~ REG_EMAIL
      record.errors.add attribute, (options[:message] || I18n.t('activerecord.errors.messages.invalid'))
    end
  end
end


# Sync it with validator.js
class MobileOrPhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    error = false
    begin
      number = GlobalPhone.parse(value, I18n.territory_name)
      if !number || !number.valid?
        error = true
      end
    rescue
      error = true
    end
    if error
      record.errors.add attribute, (options[:message] || I18n.t('activerecord.errors.messages.invalid'))
    end
  end
end

# Sync it with validator.js
class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    error = false
    begin
      number = GlobalPhone.parse(value, I18n.territory_name)
      if !number || !number.valid? ||
          (I18n.territory_name == number.territory.name.to_s.upcase && !!(number.national_string =~ I18n.t('mobile_format')))
        error = true
      end
    rescue
      error = true
    end
    if error
      record.errors.add attribute, (options[:message] || I18n.t('activerecord.errors.messages.invalid'))
    end
  end
end

# Sync it with validator.js
class MobileValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    error = false
    begin
      number = GlobalPhone.parse(value, I18n.territory_name)
      error = true if !number || !number.valid? ||
          (I18n.territory_name == number.territory.name.to_s.upcase && !(number.national_string =~ I18n.t('mobile_format')))
    rescue
      error = true
    end
    if error
      record.errors.add attribute, (options[:message] || I18n.t('activerecord.errors.messages.invalid'))
    end
  end
end

