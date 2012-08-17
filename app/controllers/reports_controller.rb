require 'net/http'

class ReportsController < ApplicationController

  respond_to :json

  CONVERT_API_BASE_URL = 'http://do.convertapi.com/web2pdf?'

  def index
    @reports = Report.order("created_at")
  end

  def show
    @report = Report.find(params[:id])
  end

  def download
    url = CONVERT_API_BASE_URL + "curl=http://www.mozilla.org/en-US/firefox/14.0.1/releasenotes/"
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
    send_data(resp.body, :filename => "Report.pdf", :type => "application/pdf")
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
    @report.attributes = params[:report].except(:items, :id)

    @report.items = @report.items.build(params[:report][:items])

    @report.save

    render json: @report.to_json(include: :items)
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    redirect_to reports_url
  end

end
