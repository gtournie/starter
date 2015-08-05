class Admin < ActiveRecord::Base
  include NameConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :timeout_in => 30.minutes

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  strip_fields :first_name, :last_name, :email
  validate_max_length_auto :first_name, :last_name, :email

end
