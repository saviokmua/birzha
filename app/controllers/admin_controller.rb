class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :access


def access
  unless current_user.admin
    redirect_to root_path
  end
end

end
