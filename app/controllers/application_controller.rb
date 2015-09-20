class ApplicationController < ActionController::Base
  #rescue_from ActiveRecord::RecordNotFound, with: :not_found
   rescue_from ActiveRecord::RecordNotFound do |exception|
      not_found
   end

  protect_from_forgery with: :exception
  @a=Article.block


def not_found
  render "errors/error404", status: 404
end

end
