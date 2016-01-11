class Therapists::RegistrationsController < Devise::RegistrationsController
  layout Proc.new { current_admin ? "admin" : "therapist" }
  before_filter :authenticate_admin!
	
  def new
  	if current_admin
  		super
  	else
  		redirect_to root_path 
  	end
  end

  def create
    redirect_to root_path unless current_admin

    # create user first, so details can be added to the user
    build_resource(sign_up_params)

    build_detail(params[:therapist][:therapist_detail])
    
    super
  end

  protected
  # Override
  def build_resource(hash=nil)
    self.resource ||= resource_class.new_with_session(hash || {}, session)
  end

  def sign_up(resource_name, resource)
  	#do nothing. Override, do not sign in resource
  end

  def after_sign_up_path_for(resource)
  	admins_therapist_path
  end

  def after_inavtice_sign_up_path_for(resource)
  	admins_therapist_path
  end

  private
  def build_detail(user_params)
    self.resource.build_therapist_detail(first_name:       user_params[:first_name],
                                   last_name:         user_params[:last_name],
                                   gender:            user_params[:gender],
                                   mobile:            user_params[:mobile])
  end

end