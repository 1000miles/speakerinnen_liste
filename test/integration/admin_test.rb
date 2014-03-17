require 'test_helper'

class AdminTest < ActionController::IntegrationTest

  def setup
    @jane = profiles(:jane)
    @jane.confirmed_at = Time.now
    @jane.save
  end

  test "visit admin page with right credentials" do
    visit '/'
    assert page.has_content?('Anmelden')
    click_link('Anmelden')
    assert page.has_content?('Passwort vergessen?')
    fill_in('profile[email]', :with => 'jane_admin@server.org')
    fill_in('profile[password]', :with => 'Testpassword')
    click_button "Anmelden" 
    first(:link, 'Admin').click
    assert page.has_content?("Tags")
    assert page.has_content?("Profiles")
  end
end