class Diaries::StressesController < ApplicationController
	before_filter :resource_signed_in?
	before_action :set_client

	def stresses
		render json: get_last_7_stresses, :only => [:date, :level_1, :level_2, :level_3]
	end

	private
	def set_client
		if current_user
			@client = current_user
		else
			@client = User.find(params[:id])
		end
	end

	def get_last_7_stresses
		return nil unless @client
		stresses = []
			
		last_7_diaries = @client.diaries.asc(:date).limit(7)
		last_7_diaries.each do |diary|
			unless diary.stress.nil?
				diary.stress.date = diary.date 
				stresses << diary.stress
			end
		end
		stresses
	end

end