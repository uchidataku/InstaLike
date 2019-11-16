require 'rails_helper'

RSpec.describe User, type: :model do
  let(:sample_user){ FactoryBot.create(:user) }

  # フルネーム、ユーザーネーム、メールアドレス、パスワードがあれば有効
  it "is valid with name, user_name, email, password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # フルネーム50文字以上は無効
  it "is invalid with name over 50 characters" do
    user = FactoryBot.build(:user, name: "a"*51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end

  # フルネームがなければ無効
  it "is invalid without name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  # ユーザーネームがなければ無効
  it "is invalid without user_name" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user.errors[:user_name]).to include("を入力してください")
  end

  # ユーザーネーム50文字以上は無効
  it "is invalid with name over 50 characters" do
    user = FactoryBot.build(:user, user_name: "a"*51)
    user.valid?
    expect(user.errors[:user_name]).to include("は50文字以内で入力してください")
  end

  # 重複したユーザーネームは無効
  it "is invalid with duplicate user_name" do
    FactoryBot.create(:user, user_name: "sample")
    user = FactoryBot.build(:user, user_name: "sample")
    user.valid?
    expect(user.errors[:user_name]).to include("はすでに存在します")
  end

  # メールアドレスの有効性
  describe "email validation" do
    user = FactoryBot.build(:user)

    # 無効なメールアドレス
    context "with invalid email addresses" do
      it "should reject" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                              foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).to_not be_valid
        end
      end
    end

    # 有効なメールアドレス
    context "with valid email addresses" do
      it "should accept" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
                          first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end
  end

  # メールアドレスがなければ無効
  it "is invalid without email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # 重複したメールアドレスは無効
  it "is invalid with duplicate email" do
    FactoryBot.create(:user, email: "sample@example.com")
    user = FactoryBot.build(:user, email: "sample@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  # パスワードがなければ無効
  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  # パスワードが一致しなければ無効
  it "is invalid when password_confirmation doesn't match password" do
    user = FactoryBot.build(:user, password: "password", password_confirmation: "hogehoge")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
end