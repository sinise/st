class Managers::RegistrationsController < Devise::RegistrationsController
  layout Proc.new { current_admin ? "admin" : "manager" }
	
  # Only admin can signup company managers
  def new
    if current_admin
      super
    else
      redirect_to root_path
    end
  end
end