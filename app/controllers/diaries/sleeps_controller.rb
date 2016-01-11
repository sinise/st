class Diaries::SleepsController < ApplicationController
	before_filter :resource_signed_in?
	before_action :set_client

	def sleeps
		render json: get_last_7_sleeps, :only => [:date, :hours]
	end

	private
	def set_client
		if current_user
			@client = current_user
		else
			@client = User.find(params[:id])
		end
	end

	def get_last_7_sleeps
		return nil unless @client
		sleeps = []
			
		last_7_diaries = @client.diaries.asc(:date).limit(7)
		last_7_diaries.each do |diary|
			unless diary.sleep.nil?
				diary.sleep.date = diary.date 
			sleeps << diary.sleep
			end	
		end
		sleeps
	end

end