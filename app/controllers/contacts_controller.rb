class ContactsController < ApplicationController

  helper_method :message

  def new
  end

  def create
    message.attributes = params[:message]
    if message.valid?
      Notifier.contact(message).deliver_later
      flash['notice'] = "TODO"
      redirect_to(new_contact_path)
    else
      render action: :new
    end
  end

private
  def message
    @message ||= Message.new
  end
end