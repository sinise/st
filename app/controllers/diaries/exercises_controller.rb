class Diaries::ExercisesController < ApplicationController
	before_filter :resource_signed_in?
	before_action :set_client

	def exercises
		render json: get_last_7_exercises, :only => [:date, :hours]
	end

	private
	def set_client
		if current_user
			@client = current_user
		else
			@client = User.find(params[:id])
		end
	end

	def get_last_7_exercises
		return nil unless @client
		exercises = []	
		
		last_7_diaries = @client.diaries.asc(:date).limit(7)
		last_7_diaries.each do |diary|
			unless diary.exercise.nil?
				diary.exercise.date = diary.date 
				exercises << diary.exercise
			end
		end
		exercises
	end

end