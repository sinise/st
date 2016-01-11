class Users::StressTestController < ApplicationController
	before_action :set_company
	before_filter :validate_company

	def show
		@stress_test ||= Clients::StressTest.new(results: {})

		if current_user
			# just show the test page
		else
			invitation = Clients::ClientInvitation.where(uuid: params[:uuid]).first
			if invitation && invitation.is_valid?
				invitation.clicked
				@uuid = invitation.uuid
			else
				redirect_to users_test_expired_path
			end
		end

		
	end

	def feedback
		build_stress_test

		if validate
			if current_user
				@stress_test.user = current_user
				@stress_test.save
				if @stress_test.stressed?
					current_user.stress_state = :stressed
				else
					current_user.stress_state = nil
				end
				current_user.save
				render 'users/stress_test/feedback'
			else
				@stress_test.save
				invitation = Clients::ClientInvitation.where(uuid: params[:uuid]).first
				if invitation
					invitation.confirm
				end
				redirect_to new_user_registration_path(company_id: @company._id, \
								test_result: @test_result, stress_test_id: @stress_test._id)
			end
		else
			render 'users/stress_test/show'
			flash.clear
		end
	end

	private
	def validate
		if params[:clients_stress_test].nil? || params[:clients_stress_test].length < 30
			flash[:error] = t("stress_test.test_not_complete")
			false
		else
			true
		end
	end

	def build_stress_test
		# only get the questions in params
		@res = Hash.new
		params[:clients_stress_test].each do |key, value|
			if key.start_with?("q")
				@res[key] = value
			end
		end unless params[:clients_stress_test].nil?

		#Remember the result
		@stress_test = Clients::StressTest.new(results: @res, version: params[:clients_stress_test][:version])
		@stress_test.company = @company
		@stress_test.created = Time.now
		@test_result = @stress_test.cal_test_result
	end

	def set_company
		@company= Admins::Company.where(url: request.base_url).first
		#@company = Admins::Company.find(params[:company_id]) if params[:company_id]
	end

	def validate_company
		redirect_to root_path unless @company
	end


end