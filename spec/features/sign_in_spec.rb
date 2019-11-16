require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
  # ユーザーのログイン・ログアウトに成功する
  scenario "user log in successful" do
    user = FactoryBot.create(:user)
    sign_in_as(user)

    expect(page).to have_content "ログアウト"

    click_link "ログアウト"

    expect(current_path).to eq root_path
    expect(page).to have_content "ログイン"
  end
end
