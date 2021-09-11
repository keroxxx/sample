require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  scenario "「/」 にアクセスした場合,タイトルは「sample」です" do
    visit root_path
    aggregate_failures do
      expect(page.title).to eq "sample"
      expect(page).to have_link "sample app", href: root_path
      expect(page).to have_link "Sign up now!", href: signup_path
    end
  end
end
