#encoding: utf-8
class Clients::UserDetailsController < ApplicationController
	before_filter :authenticate_user!

	def update
		set_user_detail(params[:user][:user_detail_attributes])
		if current_user.save
			if params[:source] == "update_profile"
				redirect_to edit_user_registration_path, :notice => t("devise.registrations.updated")
			else
				redirect_to root_path, :notice => t("devise.registrations.updated")
			end
		else
			flash[:error] = current_user.errors.full_messages
			if params[:source] == "unapproved_client"
				render 'clients/unapproved'
			else
				render 'users/registrations/edit'
			end
		end
	end

	private
  def set_user_detail(params)
  	current_user.build_user_detail(first_name:        params[:first_name],
                                   last_name:         params[:last_name],
                                   gender:            params[:gender],
                                   mobile:            params[:mobile],
                                   family_situation:  params[:family_situation],
                                   job_situation:     params[:job_situation],
                                   major_events:      params[:major_events])
  end
end