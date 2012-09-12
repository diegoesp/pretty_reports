module ReportViewHelper

  def human_report_type(report_type)
    report_type.gsub('-', ' ').split(' ').each do |word|
      word.capitalize!
    end.join(' ')
  end


end