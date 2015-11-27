class Mailer < ApplicationMailer
  
  def feedback_email params
    email=Rails.application.config.birzha_settings[:email]
    @params = params
    mail(to: email, subject: 'Повідомлення з сайту (зворотній зв\'язок)', from: "feedback@birzha.km.ua")
  end
end
