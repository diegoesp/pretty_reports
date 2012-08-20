require 'net/http'

class ReportsController < ApplicationController

  def index
    @reports = Report.order("created_at")
  end

  def show
    @report = Report.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        send_file @report.file_url
      end
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report].except(:items))
    @report.items = @report.items.build(params[:report][:items])

    @report.save

    render json: @report.to_json(include: :items)
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:report][:id])
    @report.attributes = params[:report].except(
      :items, :id, :downloadAvailable, :waitingForDownload, :dirty, :generating)

    @report.items = @report.items.build(params[:report][:items])
    @report.dirty = true

    @report.save

    render json: @report.to_json(include: :items)
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    redirect_to reports_url
  end

  def download
    @report = Report.find(params[:id])

    if (@report.dirty?)
      @report.dirty = false
      @report.save
      @report.generate_pdf(report_url(@report))
    end

    if (@report.generating?)
      render json: {message: 'Not yet', code: '100'}
      return
    else
      render json: {message: 'Download ready', code: '101'}
      return
    end
  end

end
