module ApplicationHelper

  # Display devise error messages BUT remove the title.
  def devise_error_messages_without_title
    return [] if resource.errors.empty?

    resource.errors.full_messages
  end

  # Devise workaround to have a login screen everywhere
  def resource_name
    :user
  end

  # Devise workaround to have a login screen everywhere
  def resource
    @resource ||= User.new
  end

  # Devise workaround to have a login screen everywhere
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
