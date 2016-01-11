class Therapists::TherapistDetailsController < ApplicationController
  layout "therapist"
  before_filter :authenticate_therapist!

	def update
		set_therapist_detail(params[:therapist][:therapist_detail])
    if current_therapist.save
      redirect_to edit_therapist_registration_path, :notice => t("devise.registrations.updated")
    else
      flash[:error] = current_therapist.errors.full_messages
      render 'therapists/registrations/edit'
    end
  end

  private
  def set_therapist_detail(params)
  	current_therapist.build_therapist_detail(
  										first_name: params[:first_name],
  										last_name:  params[:last_name],
  										gender: 		params[:gender],
  										mobile: 		params[:mobile],
            					about_me:   params[:about_me])
  end

end