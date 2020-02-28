class ShareNoteMailer < ApplicationMailer
  default from: 'kfr@narola.email'

  def share_notes_email
    email = params[:email]
    @subject = params[:subject]
    @note = params[:note]
    @url = params[:url]
    @description = params[:description]
    mail(to: email, subject: @subject)
  end

end
