class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  def not_rails_admin
    @not_rails_admin = true
  end
end
