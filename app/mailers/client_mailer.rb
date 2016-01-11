class ClientMailer < ActionMailer::Base
  default from: "no-reply@stressmind.com"
  default :template_path => 'mailer/clients'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Velkommen til StressMind')
  end

  def approved(user)
  	@user = user
    mail(to: @user.email, subject: 'Din StressMind anmodning er blevet godkendt')
  end

  def appointment_cancelled(user, therapist, appointment)
    @user = user
    @therapist = therapist
    @appointment = appointment
    mail(to: @user.email, subject: 'You appointment has been cancelled')
  end

  def test_invitation(email, link_path)
    @link_path = link_path
    @email = email
    mail(to: email, subject: 'Invitation to do a free stress evaluation.')
  end
end
