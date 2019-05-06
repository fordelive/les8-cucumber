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

When(/^User logs in with (.*) login and (.*) password and (.*) remember me checkbox$/) do |login, password, remember|
  case login
  when 'correct'
    login = Howitzer.app_test_user
  when 'incorrect'
    login = 'blabla@mail.net'
  when 'empty'
    login = ''
  end

  case password
  when 'correct'
    password = Howitzer.app_test_pass
  when 'incorrect'
    password = '123456'
  when 'empty'
    password = ''
  end

  if remember == 'checked'
    LoginPage.on {log_user_in login, password, true}
  else
    LoginPage.on {log_user_in login, password}
  end
end

####################################
#              CHECKS              #
####################################

Then(/^Login should be (.*)$/) do |state|
  case state
  when 'successful'
    expect(HomePage.current_page).to be_login_successful
  when 'failed'
    expect(HomePage.current_page).to be_login_failed
  end
end