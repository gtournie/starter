# encoding: utf-8
class Staff
  EMAILS = {
    'hostname' => 'email'
  }

  MOBILES = {
    'hostname' => '+33 6 12 34 56 78'
  }

  def self.email
    hostname = %x(hostname).strip.split('.').first.downcase
    EMAILS[hostname] || EMAILS.values.first
  end

  def self.mobile
    hostname = %x(hostname).strip.split('.').first.downcase
    MOBILES[hostname] || MOBILES.values.first
  end
end