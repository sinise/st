class Diaries::DiariesController < ApplicationController
#	before_filter :client_approved?, except: [:monthly_diaries_json]
	before_filter :resource_signed_in?, only: [:monthly_diaries_json]

	# show latest 7 days diaries
	def diaries
		@diaries = current_user.diaries.desc(:date).limit(7)

		render 'clients/diary/diaries' 
	end

	def show
		@current_diary = Diaries::Diary.find(params[:id])

		render 'clients/index' 
	end

	def update_diary	
		diary = Diaries::Diary.find_or_initialize_by(_id: params[:id])
		if diary.user
			diary.update(diary_params)
		else
			diary = current_user.diaries.create(diary_params)
		end
		
		redirect_to '/clients/date/' << diary.date.to_s
	end

	def add_comment
		diary = Diaries::Diary.find_or_initialize_by(_id: params[:id])
		diary.date = params[:date]
		diary.user = current_user unless diary.user

		diary.comments.build(comment: params[:comment],
												 created: Time.now,
												 user: current_user)
		diary.save

		redirect_to '/clients/date/' << diary.date.to_s + '#comments'
	end

	def monthly_diaries
		month = params[:month]|| Time.now.month
		if current_user
			client = current_user
		else
			client = User.find(params[:id])
		end

		first_day = Date.new(Time.now.year, month.to_i, 1)
		last_day = first_day.end_of_month

		diaries = client.diaries.where(:date => {'$gte' => first_day ,'$lt' => last_day})

		mon_diaries = {}
		# Initialize all days
		(first_day..last_day).each do |day|
			info = Diaries::DiaryInfo.new
			info.date = day.strftime("%-d/%m/%Y")
			info.hasDiary = false
			info.hasComments = false
			mon_diaries[day] = info
		end

		diaries.each do |d|
			info = Diaries::DiaryInfo.new
			info.date = d.date.strftime("%-d/%m/%Y")
			info.hasDiary = d.has_diary?
			info.hasComments = d.has_comments?
			mon_diaries[d.date] = info
		end
		render json: mon_diaries.values
	end

	private
		def diary_params
      params.require(:diaries_diary)
      			.permit(:date, :diary,
      							sleep_attributes: 	 [:hours_str, :quality, :description],
      							exercise_attributes: [:hours_str, :intensity, :description],
      							stress_attributes:   [:level_1, :level_1_comment, 
      																		:level_2, :level_2_comment, 
      																	  :level_3, :level_3_comment])
    end
end