class AdminMailer < ApplicationMailer
  default from: 'kfr@narola.email'

  def send_email
    email = params[:email]
    @subject = params[:subject]
    @description = params[:description]
    params[:attach].each do | key, value |
       attachments.inline[key] = File.read(value)
    end
    @attach_list = params[:attach]
    mail(to: email, subject: @subject)
  end
end
