require 'rails_helper'

RSpec.describe "Followings", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_users) { FactoryBot.create_list(:user, 20) }

  before do #(後にベタ書き修正?)
    other_users[0..9].each do |other_user|
      user.active_relationships.create!(followed_id: other_user.id)
      user.passive_relationships.create!(follower_id: other_user.id)
    end
  end

  scenario "The number of following and followers is correct" do
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    link = find('.dropdown-toggle')
    link.click
    click_on "Profile"
    click_on "following"
    expect(user.following.count).to eq 10
    user.following.each do |u| #(後にベタ書き修正?)
      expect(page).to have_link u.name, href: user_path(u)
    end

    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    link = find('.dropdown-toggle')
    link.click
    click_on "Profile"
    click_on "followers"
    expect(user.followers.count).to eq 10
    user.followers.each do |u| #(後にベタ書き修正?)
      expect(page).to have_link u.name, href: user_path(u)
    end
  end

  scenario "When user clicks on Unfollow, the number of following increases by -1" do
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit user_path(other_users.first.id)
    expect do
      click_on "Unfollow"
      expect(page).not_to have_link "Unfollow"
      visit current_path
    end.to change(user.following, :count).by(-1)
  end

  scenario "When user clicks on Follow, the number of following increases by 1" do
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    visit user_path(other_users.last.id)
    expect do
      click_on "Follow"
      expect(page).not_to have_link "Follow"
      visit current_path
    end.to change(user.following, :count).by(1)
  end
end
