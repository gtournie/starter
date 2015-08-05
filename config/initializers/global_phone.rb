# sudo gem install global_phone_dbgen
# sudo vi /var/lib/gems/2.1.0/gems/global_phone_dbgen-1.0.0/bin/global_phone_dbgen
# in http://libphonenumber.googlecode.com/svn/trunk/resources/PhoneNumberMetaData.xml
#   replace PhoneNumberMetaData into PhoneNumberMetadata
# global_phone_dbgen > db/global_phone.json

require 'global_phone'
GlobalPhone.db_path = Rails.root.join('db/global_phone.json')

module I18n

  def self.territory_name
    loc = self.locale.to_s
    (loc.length >= 5 ? loc[3, 5] : loc).upcase
  end

  def self.format_phone(phone)
    return phone if phone.blank?
    territory_name = I18n.territory_name
    begin
      number = GlobalPhone.parse(phone, territory_name)
      return phone unless number
      number.send(number.territory.name.upcase != territory_name ? :international_format : :national_format).gsub(/\s+/, ' ')
    rescue
      phone
    end
  end

end