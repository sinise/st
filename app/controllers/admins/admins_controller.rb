#encoding: utf-8
class Admins::AdminsController < ApplicationController
	layout "admin"
	before_filter :authenticate_admin!

	def index

		render 'admins/index' 
	end

	def clients
		@companies = Admins::Company.all
		@therapists = Therapist.all
		render 'admins/clients/clients' 
	end

	def therapists
		@therapists = Therapist.all
		render 'admins/therapists/therapists' 
	end

	def therapist
		@therapist = Therapist.find(params[:id])

		render 'admins/therapists/therapist'
	end

end