class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @company = Admins::Company.find(params[:company_id])
    @stress_test = Clients::StressTest.find(params[:stress_test_id])
    
    if @stress_test.test_result != params[:test_result]
      redirect_to root_path
      return
    end

    if @company && @stress_test
      super
    else
      redirect_to root_path
      return
    end
  end

  def create
    # create user first, so details can be added to the user
    build_resource(sign_up_params)

    @company = Admins::Company.find(params[:company_id])
    @stress_test = Clients::StressTest.find(params[:stress_test_id])
    unless @company && @stress_test
      redirect_to root_path
      return
    end

    build_detail(params[:user][:user_detail_attributes], @stress_test.test_result)
    
    super
    client = current_user
    if client
      # Link user to stress test reault
      @stress_test.user = client
      @stress_test.department = @department if @department
      @stress_test.save

      ClientMailer.welcome(client).deliver 
      #ManagerMailer.new_employee(client.company.default_manager).deliver     
    end
  end

  protected
  # Override
  def build_resource(hash=nil)
    self.resource ||= resource_class.new_with_session(hash || {}, session)
  end

	private
  def build_detail(user_params, test_result)
    self.resource.build_user_detail(first_name:       user_params[:first_name],
                                   last_name:         user_params[:last_name],
                                   gender:            user_params[:gender],
                                   mobile:            user_params[:mobile],
                                   family_situation:  user_params[:family_situation],
                                   job_situation:     user_params[:job_situation],
                                   major_events:      user_params[:major_events])
    self.resource.company = @company
    therapist = Therapist.first
    self.resource.therapist = therapist

    if @company.has_departments?
      @department = Admins::Department.find(params[:user][:department_id])
      self.resource.department = @department

      if @department.has_sections?
        @section = Admins::Section.find(params[:user][:section_id])
        self.resource.section = @section
      end
    end

    if test_result == 'high_stress_high_env' || test_result =='high_stress_low_env'
      self.resource.stress_state = :stressed
    end
  end
end