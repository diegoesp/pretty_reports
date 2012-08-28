require 'pdfkit'

class HomeController < ApplicationController

  respond_to :json

  def index    
  end

  def pdfkit 
  end

  def pdf
    url = params[:url]
    @kit = PDFKit.new(url, "use-xserver" => "--quiet")
    # Respond with PDF
    send_data(@kit.to_pdf, :filename => "pretty_report.pdf")
  end

end
