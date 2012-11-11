class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_customer?
      customer_dashboard_path(resource.rolable_id)
    else
      root_path
    end
  end
end
