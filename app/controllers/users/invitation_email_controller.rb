#encoding: utf-8
class Users::InvitationEmailController < ApplicationController
	
	def start_email
		if user_signed_in?
			redirect_to clients_diaryboard_path
		elsif therapist_signed_in?
			redirect_to therapists_index_path
		elsif manager_signed_in?
			redirect_to managers_index_path
		elsif admin_signed_in?
			redirect_to admins_index_path
		else
			#show start mail page
		end
		
	end

	def send_invitation_email
		email = params[:email]
		if is_a_valid_email?(email)
			# send email
			uuid = SecureRandom.uuid
			company= Admins::Company.where(url: request.base_url).first
			path = request.base_url << stresstest_path << '?uuid=' << uuid
			ClientMailer.test_invitation(email, path).deliver 
		  
		  invitation = Clients::ClientInvitation.new(email: email, uuid: uuid, company_id: company.id)
		  invitation.save

			redirect_to users_invitation_email_sent_path(email: email)
		else
			flash[:error] = 'Invalid email.'
      render 'users/invitation_email/start_email'
		end
		
	end

	def invitation_email_sent
		@email = params[:email]
	end

	def test_expired
		@company= Admins::Company.where(url: request.base_url).first
	end

	private
	def is_a_valid_email?(email)
    email_regex = %r{^.+@.+$}

    (email =~ email_regex)
	end

end