class CompaniesController < ApplicationController
  # GET /companies
  def index
    @companies = Company.all
    authorize @companies
  end

  # GET /companies/:id
  def show
    @company = Company.find(params[:id])
    authorize @company
    render :show
  end

  # GET /companies/new
  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company

    return redirect_to @company if @company.save

    render :new
  end

  # GET /companies/:id/edit
  def edit
    @company = Company.find(params[:id])
    authorize @company
  end

  # PATCH /companies/:id
  def update
    @company = Company.find(params[:id])
    authorize @company

    return redirect_to @company if @company.update(company_params)

    render :edit
  end

  # DELETE /companies/:id
  def destroy
    @company = Company.find(params[:id])
    authorize @company

    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country, :cover)
  end
end
