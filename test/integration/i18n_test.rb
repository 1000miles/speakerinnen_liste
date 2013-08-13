require 'test_helper'

class InternationalisationTest < ActionController::IntegrationTest

  test "locale de works" do
    skip('until we finish the translations')
    visit '/'
    click_link('DE')
    assert page.has_content?('Anmelden'), 'in Application.html.erb translation does not work'
    assert page.has_content?('Suche'), 'in yield Translation does not work'
  end

  test "locale en works" do
    skip('until we finish the translations')
    visit '/'
    click_link('DE')
    click_link('EN')
    assert page.has_content?('Login'), 'in Application.html.erb translation does not work'
    assert page.has_content?('Search'), 'in yield Translation does not work'
  end
end