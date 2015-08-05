class User < ActiveRecord::Base
  include PasswordConfirmationMatchConcern
  include NameConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  strip_fields :first_name, :last_name, :email
  validate_max_length_auto :first_name, :last_name, :email

  validates :last_name, :first_name, :presence => true
  validates :email, :uniqueness => true, :presence => true, :email => true
  validates :password,
    :presence => { :unless => Proc.new { |u| u.password.nil? } },
    :length => { :in => 8..20, :unless => Proc.new { |u| u.password.nil? } }
  validate :password_confirmation_matches

end
