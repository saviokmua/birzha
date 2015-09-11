class FeedbackController < ApplicationController

def index
  @feedback = Feedback.new
end


def create
  @feedback = Feedback.new(params[:feedback])
  if @feedback.valid?
    email = 'alex@webit.in.ua'
    Mailer.feedback_email(params[:feedback]).deliver_now
    redirect_to feedback_send_done_path
  else
    render :index
  end
end


def send_done

end


end
