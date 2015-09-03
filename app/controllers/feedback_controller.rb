class FeedbackController < ApplicationController

def index
  @feedback = Feedback.new
end


def create
  @feedback = Feedback.new(params[:feedback])
  if @feedback.valid?
    # TODO send message here
    redirect_to root_url, notice: "Message sent! Thank you for contacting us."
  else
    render :index
  end
end

end
