class Admins::CompaniesController < ApplicationController
  layout Proc.new { current_admin ? "admin" : "application" }

  before_filter :authenticate_admin!, except: [:validate_code]
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def validate_code
    company = Admins::Company.where(code: params[:company_code]).first
    if company
      #redirect_to new_user_registration_path(company_code: params[:company_code])
      redirect_to stresstest_path(company_id: company._id)
    else
      flash[:error] = t('errors.company.invalid_company')
      @test_result = params[:test_result]
      #render 'users/stress_test/feedback'
      render 'home/index'
    end
  end

  # GET /companies
  # GET /companies.json
  def index
    @companies = Admins::Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Admins::Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Admins::Company.new(company_params)

    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render action: 'new'
    end
    
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    redirect_to admins_companies_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Admins::Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:admins_company).permit(:name, :phone, :email, :code, :session_hourly_rate, :currency, :url)
  end
end
