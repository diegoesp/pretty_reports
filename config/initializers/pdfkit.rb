############################################################################
#
# Configures the PDFKit in producting evironment, pointing it to the
# location of the wkhtmltopdf binary
#
############################################################################

if Rails.env == "production"

  PDFKit.configure do |config|
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  end

end