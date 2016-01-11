#encoding: utf-8
class HomeController < ApplicationController

	def index
		if user_signed_in?
			redirect_to clients_diaryboard_path
#			if current_user.approved?
#				redirect_to clients_index_path 
#			else
#				redirect_to clients_unapproved_path 
#			end
		elsif therapist_signed_in?
			redirect_to therapists_index_path
		elsif manager_signed_in?
			redirect_to managers_index_path
		elsif admin_signed_in?
			redirect_to admins_index_path
		end
	end


end
