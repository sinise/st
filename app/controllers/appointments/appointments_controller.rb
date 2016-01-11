class Appointments::AppointmentsController < ApplicationController
	layout Proc.new { current_therapist ? "therapist" : "application" }

  before_filter :resource_signed_in?
  before_filter :authenticate_therapist!, only:   [:therapist_appointments]
  before_filter :authenticate_user!,      only:   [:client_appointments]


  def client_appointments
    @appointments = current_user.appointments.desc(:appoint_datetime)
  end

  def therapist_appointments
    current_therapist.appointments.desc(:appoint_datetime)
  end

  def cancel
    appointment = Appointments::Appointment.find(params[:id])
    appointment.cancel(params[:comment])
  end
end