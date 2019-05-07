#############################################################
#                      PREREQUISITES                        #
#############################################################

Given 'User visits Login page' do
  LoginPage.open
end

####################################
#              ACTIONS             #
####################################

When(/^User logs in with (.*) login and (.*) password and (.*) remember me checkbox$/) do |login, password, remember|
  login_hash = { login: resolve_login(login), password: resolve_password(password), remember: 'checked'.match?(remember) }
  LoginPage.on { log_user_in(login_hash) }
end

When 'User reopens browser and opens Homepage' do
  session_cookies = Capybara.page.driver.browser.manage.all_cookies
  Capybara.current_session.reset_session!

  HomePage.open
  HomePage.on {driver.browser.manage.delete_all_cookies}

  session_cookies.each {|cookie| HomePage.on {driver.browser.manage.add_cookie(cookie)}}
  HomePage.on { reload }
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
    # expect HomePage.on {menu_section.login_successful?}
    HomePage.on { expect(menu_section).to be_login_successful }
  when 'failed'
    # expect LoginPage.on {login_failed?}
    LoginPage.on { is_expected.to be_login_failed }
  end
end

Then 'User should be logged out' do
  # expect HomePage.on {menu_section.logout_successful?}
  HomePage.on { expect(menu_section).to be_logout_successful }
end


def resolve_login(login)
  possible_login = { 'correct': Howitzer.app_test_user, 'incorrect': 'blabla@mail.net', 'empty': ''}
  possible_login[login.to_sym]
end

def resolve_password(password)
  possible_password = { 'correct': Howitzer.app_test_pass, 'incorrect': '12345678', 'empty': ''}
  possible_password[password.to_sym]
end