require 'net/http'

class ReportsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def index
    @reports = Report.my_reports(current_user).order("created_at")
  end

  def show
    @report = Report.my_reports(current_user).find(params[:id])
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Report.as_pdf(report_url(@report))
        send_data pdf
      end
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report].except(:items))
    @report.items = @report.items.build(params[:report][:items])

    @report.user_id = current_user.id

    @report.save

    render json: @report.to_json(include: :items)
  end

  def edit
    @report = Report.my_reports(current_user).find(params[:id])
  end

  def update
    @report = Report.my_reports(current_user).find(params[:report][:id])
    @report.attributes = params[:report].except(
      :items, :id, :user_id)

    @report.items = @report.items.build(params[:report][:items])

    @report.save

    render json: @report.to_json(include: :items)
  end

  def destroy
    @report = Report.my_reports(current_user).find(params[:id])
    @report.destroy

    redirect_to reports_url
  end
end