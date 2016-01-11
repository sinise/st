class ManagerMailer < ActionMailer::Base
  default from: "no-reply@stressmind.com"
  default :template_path => 'mailer/managers'

  def new_employee(manager)
    @manager = manager
    mail(to: @manager.email, subject: 'Ny StressMind anmodning')
  end

end
