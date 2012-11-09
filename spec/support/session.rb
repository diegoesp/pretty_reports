def sign_up(user, password = nil)  
  visit new_user_registration_path

  if password.blank?
    password = "password"
  end

  fill_in "user_last_name", :with => user.last_name
  fill_in "user_first_name", :with => user.first_name
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password

  click_button("Register")
  puts page.html
end

def sign_in(user, password = nil)  
  visit new_user_session_path

  if password.blank?
    password = "password"
  end

  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => password
  click_button("Sign in")
end

def sign_out
  visit destroy_user_session_path
end