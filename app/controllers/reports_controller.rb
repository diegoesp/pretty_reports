require 'net/http'

class ReportsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def index
    @reports = current_user.reports.order("created_at")
  end

  # This method is particulary complex because it's the one accessed by
  # PDFKit. PDFKit cannot log in but we cannot take out access control from
  # the method because it would allow any non authenticated user to 
  # access every report, even those that are not his own. So the approach
  # taken is this one:
  #
  # 1) When accessing .pdf:
  # 
  # Full access control is enforced. Additionally, a token is generated
  # for PDFKit that uses it as a querystring parameter to generate the report 
  # as HTML and print the PDF.
  #
  # 2) When accessing .html:
  # 
  # In the case of a request without a token, full access control is enforced.
  # In the case of a request with a token, the token database is accessed
  # and then access control is enforced employing the user that owns the token.
  def show
    respond_to do |format|
      format.html do
        # If user is not logged in, then check if it's PDFKit using a token
        tokenizer_uid = params[:tokenizer_uid]      
        
        if tokenizer_uid.blank?
          authenticate_user!
        else
          tokenizer = Tokenizer.find_by_uid(tokenizer_uid)
          sign_in(:user, tokenizer.user)
        end
        @report = current_user.reports.find(params[:id])
      end
      format.pdf do
        # User must be logged in to use this feature
        authenticate_user!

        @report = current_user.reports.find(params[:id])

        # Get a token for PDFKit to use
        tokenizer = Tokenizer.create!(:user_id => current_user.id)
        # Insert the token in the URL
        url = report_url(@report) + "?tokenizer_uid=#{tokenizer}"

        # Send URL to PDFKit
        pdf = Report.as_pdf(url)
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
    @report = current_user.reports.find(params[:id])
  end

  def update
    @report = current_user.reports.find(params[:report][:id])
    @report.attributes = params[:report].except(
      :items, :id, :user_id)

    @report.items = @report.items.build(params[:report][:items])

    @report.save

    render json: @report.to_json(include: :items)
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    @report.destroy

    redirect_to reports_url
  end
end