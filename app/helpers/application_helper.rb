module ApplicationHelper

  # Display devise error messages BUT remove the title.
  def devise_error_messages_without_title
    return [] if resource.errors.empty?

    resource.errors.full_messages
  end

end
