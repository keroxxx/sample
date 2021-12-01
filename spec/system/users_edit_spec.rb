require 'rails_helper'

RSpec.describe 'UsersEdits', type: :system do
  let(:user) { FactoryBot.create(:user) }

  scenario 'it fails edit with wrong information' do
    visit login_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    find('.dropdown-toggle').click
    click_on 'Settings'
    fill_in 'Name', with: ' '
    fill_in 'Email', with: 'user@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Password confirmation', with: 'bar'
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
      expect(page).to have_selector "img[src$='default.png']"
    end
  end

  scenario 'it succeeds edit with correct information' do
    visit login_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    find('.dropdown-toggle').click
    click_on 'Settings'
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/inu.png"
    click_on 'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_selector("img[src$='inu.png']")
    end
  end
end
