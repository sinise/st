#encoding: utf-8
class Clients::ClientsController < ApplicationController
	before_filter :authenticate_user!
#	before_filter :client_approved?, except: [:unapproved]

	def index
		@articles = current_user.client_articles
		@company = current_user.company
		@tests = current_user.stress_tests
		
		render 'clients/index'
	end

	def stress_test
		@stress_test = Clients::StressTest.find(params[:id])
		@test_result = @stress_test.test_result
		render 'clients/stress_test'
	end

	def unapproved
		render 'clients/unapproved'
	end

	def diaryboard
		show_dashboard(params[:date] || Date.today)
	end

	def statistics
		render 'clients/statistics'
	end

	def appointments
		@appointments = current_user.appointments.desc(:appoint_datetime)
		
		@therapist = current_user.therapist
    @date = params[:month] ? Date.parse(params[:month]) : Date.new(Date.today.year, Date.today.month) 

    # current month timeslots
    timeslots = []
    if @therapist
    	timeslots = @therapist.timeslots.where(:state => "open", :start_at.gt => @date)
 		end
    
    # Copy to a tmp array, to avoid mass lazy loading
    tmp_timeslots = []
    timeslots.each do |t|
    	tmp_timeslots << t
    end

    @timeslots_hash = {}
    (@date.beginning_of_month..@date.end_of_month).each do |d|
    	timeslots_day = []
    	tmp_timeslots.each do |t|
    		if t.start_at.day == d.day && t.start_at.month == d.month
    			timeslots_day << t
    		end
    	end
    	@timeslots_hash[d.day] = timeslots_day
    end

		render 'clients/appointments'
	end

	private
	def show_dashboard(date)
		@current_diary = current_user.diaries.where(date: date).first || \
										 current_user.diaries.build(date: date)

		@current_diary.build_sleep     unless @current_diary.sleep
		@current_diary.build_exercise  unless @current_diary.exercise
		@current_diary.build_stress    unless @current_diary.stress

		render 'clients/diaryboard'
	end

end