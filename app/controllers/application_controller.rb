class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def after_sign_out_path_for(resource_or_scope)
    '/login'
  end

end
