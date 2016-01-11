class Admins::DepartmentsController < ApplicationController
  layout Proc.new { current_admin ? "admin" : "application" }

  before_action :set_company
  before_action :set_department, only: [:edit, :update, :destroy, :show]

  def show
    render 'admins/companies/departments/show'
  end

  def new
    @department = Admins::Department.new
    render 'admins/companies/departments/new'
  end

  def create
    @department = @company.departments.build(department_params)

    if @department.save
      redirect_to @company, notice: 'Department was successfully created.'
    else
      render 'admins/companies/departments/new'
    end
  end

	def edit
		render 'admins/companies/departments/edit'
  end

  def update
    if @department.update_attributes(department_params)
      redirect_to @company, notice: 'Department was successfully updated.'
    else
      render 'admins/companies/departments/edit'
    end
  end

  def destroy
    @department.destroy
    redirect_to @company
  end

  private
  def set_company
    @company = Admins::Company.find(params[:company_id])
  end

  def set_department
    @department = Admins::Department.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def department_params
    params.require(:admins_department).permit(:name, :phone, :email, :code)
  end
end
