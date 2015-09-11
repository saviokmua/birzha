class Mailer < ApplicationMailer
  
  def feedback_email params
    email='alex@webit.in.ua'
    @params = params
    mail(to: email, subject: 'Повідомлення з сайту (зворотній зв\'язок)')
  end
end
