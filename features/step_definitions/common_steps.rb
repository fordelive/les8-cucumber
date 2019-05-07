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

When 'User reopens browser and opens Homepage' do
  session_cookies = Capybara.page.driver.browser.manage.all_cookies
  Capybara.current_session.reset_session!

  HomePage.open
  HomePage.on {driver.browser.manage.delete_all_cookies}

  session_cookies.each {|cookie| HomePage.on {driver.browser.manage.add_cookie(cookie)}}
  HomePage.on {driver.refresh}
end

And 'User logs out' do
  HomePage.on {menu_section.logout}
end

####################################
#              CHECKS              #
####################################

Then(/^Login should be (.*)$/) do |state|
  case state
  when 'successful'
    expect HomePage.on {menu_section.login_successful?}
  when 'failed'
    expect LoginPage.on {login_failed?} #########
  end
end

Then 'User should be logged out' do
  expect HomePage.on {menu_section.logout_successful?}
end