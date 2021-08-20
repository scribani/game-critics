class CompaniesController < ApplicationController
  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/:id
  def show
    @company = Company.find(params[:id])
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    return redirect_to @company if @company.save

    render :new
  end

  # GET /companies/:id/edit
  def edit
    @company = Company.find(params[:id])
  end

  # PATCH /companies/:id
  def update
    @company = Company.find(params[:id])
    return redirect_to @company if @company.update(company_params)

    render :edit
  end

  # DELETE /companies/:id
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country)
  end
end
