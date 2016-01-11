#encoding: utf-8
class Therapists::JournalsController < ApplicationController
	layout "therapist", only: [:add_journal]
	before_filter :authenticate_therapist!

	def add_journal
		@client = User.find(params[:id])
		journal = @client.journals.build(therapist: current_therapist,
																		 date: Time.now,
													 					 message: params[:message])

		journal.save
		redirect_to therapists_path(@client, :anchor => "tab_journal")
	end

end