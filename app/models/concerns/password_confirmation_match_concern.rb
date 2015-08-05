module PasswordConfirmationMatchConcern
  extend ActiveSupport::Concern

private

  def password_confirmation_matches
    if !password_confirmation.nil? && password_confirmation != password
      errors.add(:password, I18n.t("errors.messages.confirmation"))
    end
  end
end