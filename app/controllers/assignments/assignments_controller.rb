class Assignments::AssignmentsController < ApplicationController
	layout Proc.new { current_therapist ? "therapist" : "application" }

#  before_filter :client_approved?,        except: [:show, :assign]
  before_filter :resource_signed_in?,     only:   [:show]
  before_filter :authenticate_therapist!, only:   [:assign]

  def show
  	@assignment = Assignments::Assignment.find(params[:id])
    if @assignment
      case @assignment.name
      when 'ABC opgave'
        @assignment.result = {} unless @assignment.result
        render 'assignments/abc_assignment'
      when 'En positiv ting om dagen'
        @assignment.result = {} unless @assignment.result
        render 'assignments/ting_om_dagen_assignment'
      when 'Stressende situationer'
        @assignment.result = {} unless @assignment.result
        render 'assignments/stressende_situation_pagebreeze'
      else
        render 'assignments/client_index'
      end
    end
  end

  def assign
    client = User.find(params[:id])
    assignment = Assignments::Type1Assignment.new
    assignment.name = params[:name]
    assignment.user = client 
    assignment.therapist = current_therapist
    assignment.save

    redirect_to therapists_path(client, :anchor => "tab_assignment")
  end

  def client_index
  	@assignments = current_user.assignments.asc(:status).page(params[:assignment_page])
  	render 'assignments/client_index'
  end

  def save_type1
    @assignment = Assignments::Assignment.find(params[:id])
    anwsers = params[:assignments_type1_assignment]
    result = Hash.new

    anwsers.each do |key, value|
      if key.start_with?("q")
        result[key] = value
      end
    end unless anwsers.nil?

    @assignment.result = result
    @assignment.save
    redirect_to assignments_path(@assignment)
  end

  def submit
    @assignment = Assignments::Assignment.find(params[:id])
    @assignment.submit

    redirect_to assignments_client_index_path
  end
end