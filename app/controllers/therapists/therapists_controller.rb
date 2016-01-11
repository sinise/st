#encoding: utf-8
class Therapists::TherapistsController < ApplicationController
	layout Proc.new { current_admin ? "admin" : "therapist" }
	before_filter :authenticate_therapist!, except: [:assign]
	before_filter :authenticate_admin!, only: [:assign]

	def index
		render 'therapists/index' 
	end

	def clients
		@clients = current_therapist.clients.page(params[:page])
		

		render 'therapists/clients' 
	end

	def appointments
		@appointments = current_therapist.appointments
		render 'therapists/appointments' 
	end

	def client
		@client = User.find(params[:id])
		build_diary_view(params[:date] || Date.today)
		@assignments = @client.assignments.asc(:status).page(params[:assignment_page])
		@articles = @client.client_articles
		@stress_test = @client.stress_tests.first

		render 'therapists/client/view' 
	end

	def add_note
		@client = User.find(params[:id])
		if @client.user_detail
			@client.user_detail.note = params[:note]
		else
			@client.build_user_detail(note: params[:note])
		end
		@client.save

		redirect_to therapists_path(@client)
	end

	def add_diary_comment
		client = User.find(params[:id])
		diary = Diaries::Diary.find_or_initialize_by(_id: params[:diary_id])
		diary.date = params[:date]
		diary.user = client unless diary.user

		diary.comments.build(comment: params[:comment],
																 created: Time.now,
																 therapist: current_therapist)
		diary.save

		redirect_to therapists_path(client, date: diary.date.to_s)
	end

	# assign a client to a therapist
	def assign
		client = User.find(params[:client_id])
		client.therapist_id = params[:therapist_id]
		client.save

		redirect_to admins_clients_path
	end

	private
	def build_diary_view(date)
		@current_diary = @client.diaries.where(date: date).first_or_initialize
		@stress = @current_diary.stress || Diaries::Stress.new
		@sleep = @current_diary.sleep || Diaries::Sleep.new
		@exercise = @current_diary.exercise || Diaries::Exercise.new
	end

end