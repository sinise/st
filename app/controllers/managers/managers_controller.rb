#encoding: utf-8
class Managers::ManagersController < ApplicationController
	layout "manager"
	before_filter :authenticate_manager!

	def index
		render 'managers/index' 
	end

	def invoices
		render 'managers/invoices'
	end

	def employees
		if current_manager.has_department?
			employees = current_manager.department.users
		else
			employees = current_manager.company.users
		end
		
		@employees = employees.in_treatment.page(params[:page])

		render 'managers/employees'
	end

	def approve_employee
		employee = User.find(params[:id])
		employee.approve_state = :approved
		if employee.save
			flash[:notice] = 'Employee was successfully approved.'
			ClientMailer.approved(employee).deliver
			#TherapistMailer.new_client(employee).deliver
		end
		redirect_to managers_index_path 
	end

	def reject_employee
		employee = User.find(params[:id])
		employee.approve_state = :rejected
		if employee.save
			flash[:notice] = 'Employee was successfully rejected.'
		end
		redirect_to managers_index_path 
	end



end