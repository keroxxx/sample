require 'rails_helper'

RSpec.describe 'UsersSignups', type: :system do
  scenario "Don't create new data when user submits invalid information" do
    visit signup_path
    fill_in 'Name', with: ' '
    fill_in 'Email', with: 'user@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Password confirmation', with: 'bar'
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page).to have_content 'Sign up'
      expect(page).to have_content 'The form contains 4 errors'
    end
  end

  scenario 'Create new data when user submits valid information' do
    visit signup_path
    fill_in 'Name', with: 'Example User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Password confirmation', with: 'foobar'
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(has_css?('.alert-info')).to be_truthy
      visit current_path
      expect(has_css?('.alert-info')).to be_falsy
    end
  end
end
