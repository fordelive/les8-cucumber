#############################################################
#                      PREREQUISITES                        #
#############################################################

Given 'User visits Login page' do
  LoginPage.open
end

Given 'I have entered {float} into the calculator' do |_input|
  pending
end

####################################
#              ACTIONS             #
####################################

When 'User logs in with (.*) login and (.*) password and (.*) remember me checkbox' do |login, password, remember|
  case login
  when 'correct'
    login = CORRECT_LOGIN
  when 'incorrect'
    login = INCORRECT_LOGIN
  when 'empty'
    login = ''
  end

  case password
  when 'correct'
    password = CORRECT_PASSWORD
  when 'incorrect'
    password = INCORRECT_PASSWORD
  when 'empty'
    password = ''
  end

  if remember == 'checked'
    LoginPage.on {log_user_in login, password, true}
  else
    LoginPage.on {log_user_in login, password}
  end
end

When 'I press {word}' do |_button|
  pending
end

####################################
#              CHECKS              #
####################################

Then 'the result should be {float} on the screen' do |_output|
  pending
end

Then 'Login should be (.*)' do |state|
  pending
end