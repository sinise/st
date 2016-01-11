class Admins::SectionsController < ApplicationController
  layout Proc.new { current_admin ? "admin" : "application" }

  before_action :set_company
  before_action :set_department
  before_action :set_section, only: [:edit, :update, :destroy]


  def new
    @section = Admins::Section.new
    render 'admins/companies/departments/sections/new'
  end

  def create
    @section = @department.sections.build(section_params)

    if @section.save
      redirect_to admins_company_department_path(@company,@department), notice: 'Section was successfully created.'
    else
      render 'admins/companies/departments/sections/new'
    end
  end

	def edit
		render 'admins/companies/departments/sections/edit'
  end

  def update
    if @section.update_attributes(section_params)
      redirect_to admins_company_department_path(@company,@department), notice: 'Section was successfully updated.'
    else
      render 'admins/companies/departments/sections/edit'
    end
  end

  def destroy
    @section.destroy
    redirect_to admins_company_department_path(@company,@department)
  end

  private
  def set_company
    @company = Admins::Company.find(params[:company_id])
  end

  def set_department
    @department = Admins::Department.find(params[:department_id])
  end

  def set_section
    @section = Admins::Section.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def section_params
    params.require(:admins_section).permit(:name, :phone, :email, :code)
  end
end
