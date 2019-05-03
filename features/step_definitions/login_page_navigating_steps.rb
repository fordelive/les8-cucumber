Given 'User opens the Home page' do
  HomePage.open
end

When 'User clicks Login link on menu' do
  HomePage.on {menu_section.login}
end

Then 'The Login page is opened' do
  expect(LoginPage).to be_displayed
end