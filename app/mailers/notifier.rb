# encoding: utf-8
require "staff"

class Notifier < ActionMailer::Base
  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  INTERNAL_SUBJECT_PREFIX = "[#{Settings.app_name.upcase}]"

  layout "notifier"

  default :from => "#{Settings.app_name} <#{Settings.reply_email}>", :charset => "utf-8"


# FRONT
  def contact(message)
    @message = message
    mail(:to => internal_email, :subject => "#{INTERNAL_SUBJECT_PREFIX}[CONTACT]")
  end

# DEVISE
  def confirmation_instructions(resource, token, options)
    @resource = resource
    @name = resource.first_name
    @token = token
    subject = 'Confirmation_instructions'
    mail(:to => format_recipient(resource.email, resource.name), :subject => subject)
  end

  def reset_password_instructions(resource, token, options)
    @resource = resource
    @token = token
    @name = resource.first_name
    subject = 'Reset_password_instructions'
    mail(:to => format_recipient(resource.email, resource.name), :subject => subject)
  end

private

  def internal_email
    Rails.env.development? ? Staff.email : Settings.admin_email
  end

  def format_recipient(email, name = nil)
    Rails.env.production? ? (name.blank? ? email : "#{name} <#{email}>") : Staff.email
  end
end
