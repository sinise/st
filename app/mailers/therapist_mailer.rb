class TherapistMailer < ActionMailer::Base
  default from: "no-reply@stressmind.com"
  default :template_path => 'mailer/therapists'

  def new_client(therapist)
    @therapist = therapist
    mail(to: @therapist.email, subject: 'Du har fået en ny klient')
  end

  def appointment_cancelled(client, therapist, appointment)
    @client = client
    @therapist = therapist
    @appointment = appointment
    mail(to: @user.email, subject: 'You appointment has been cancelled')
  end

end
