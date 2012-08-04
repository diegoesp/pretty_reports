require 'net/http'

class ReportsController < ApplicationController

  CONVERT_API_BASE_URL = 'http://do.convertapi.com/web2pdf?'

  def show
    @report = Report.find(params[:id])
  end

  def download
    authenticated_url = report_url(params[:id]).sub 'http://', 'http://user:lacasadelarte@'
    logger.debug ">>>>>>>>>>>>>>>>>>>"
    logger.debug authenticated_url
    url = CONVERT_API_BASE_URL + "curl=#{authenticated_url}"
    resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
    send_data(resp.body, :filename => "Report.pdf", :type => "application/pdf")
  end

  def new
    @report = Report.new
  end

end
