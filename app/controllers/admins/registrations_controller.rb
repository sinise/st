class Admins::RegistrationsController < Devise::RegistrationsController
  layout "admin"

  # Only allows admin do change password
	
  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end

  def destory
    redirect_to root_path
  end

  def cancel
    redirect_to root_path
  end
end