require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it "ユーザー名, メールアドレスの値が入力されているか" do
    expect(user).to be_valid

    user.name = " "
    expect(user).to be_invalid

    user.email = " "
    expect(user).to be_invalid
  end

  describe "name length" do
    it "ユーザー名が50桁以下であるか" do
      user.name = "a" * 50
      expect(user).to be_valid

      user.name = "a" * 51
      expect(user).to be_invalid
    end
  end

  describe "email" do
    it "メールアドレスが191桁以下であるか" do
      user.email = "a" * 179 + "@example.com"
      expect(user).to be_valid

      user.email = "a" * 180 + "@example.com"
      expect(user).to be_invalid
    end
    
    context "メールアドレスのvalidateが正しく機能している時" do
      it "validである" do
        expect(FactoryBot.build(:user, email: "user@example.com")).to be_valid
        expect(FactoryBot.build(:user, email: "USER@foo.COM")).to be_valid
        expect(FactoryBot.build(:user, email: "A_US-ER@foo.bar.org")).to be_valid
        expect(FactoryBot.build(:user, email: "first.last@foo.jp")).to be_valid
        expect(FactoryBot.build(:user, email: "alice+bob@baz.cn")).to be_valid
      end
    end

    context "メールアドレスのvalidateが機能していない時" do
      it "invalidである" do
        expect(FactoryBot.build(:user, email: "user@example,com")).to be_invalid
        expect(FactoryBot.build(:user, email: "user_at_foo.org")).to be_invalid
        expect(FactoryBot.build(:user, email: "user.name@example.")).to be_invalid
        expect(FactoryBot.build(:user, email: "foo@bar_baz.com")).to be_invalid
        expect(FactoryBot.build(:user, email: "foo@bar+baz.com")).to be_invalid
      end
    end

    it "一意性が正しく機能しているか" do
      duplicate_user = user.dup
      user.save!
      expect(duplicate_user).to be_invalid
    end

    it "大文字を混ぜて登録されたメールアドレスが小文字に変換されているか" do
      user.email = "Foo@ExAMPle.CoM"
      user.save!
      expect(user.reload.email).to eq "foo@example.com"
    end
  end

  describe "password" do
    it "パスワードが入力されているか" do
      user.password = user.password_confirmation = "a" * 6
      expect(user).to be_valid
  
      user.password = user.password_confirmation = " " * 6
      expect(user).to be_invalid
    end

    it "パスワードが6桁以上であるか" do
      user.password = user.password_confirmation = "a" * 6
      expect(user).to be_valid

      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end

  it "ダイジェストが存在しなければfalseを返す" do
    expect(user.authenticated?(:remember, '')).to be_falsy
  end

  describe "dependent: :destroy" do
    before do
      user.save
      user.microposts.create!(content: "Lorem ipsum")
    end

    it "succeeds" do
      expect do
        user.destroy
      end.to change(Micropost, :count).by(-1)
    end
  end

  describe "follow and unfollow" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before do
      user.follow(other_user)
    end

    describe "follow" do
      it "succeeds" do
        expect(user.following?(other_user)).to be_truthy
      end
    end

    describe "followers" do
      it "succeeds" do
        expect(other_user.followers.include?(user)).to be_truthy
      end
    end

    describe "unfollow" do
      it "succeeds" do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsy
      end
    end
  end

  describe "def feed" do
    let(:user) { FactoryBot.create(:user, :with_microposts) }
    let(:other_user) { FactoryBot.create(:user, :with_microposts) }

    context "when user is following other_user" do
      before do
        user.active_relationships.create!(followed_id: other_user.id)
      end

      it "contains other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_following| #ベタ書き修正の余地あり
          expect(user.feed.include?(post_following)).to be_truthy
        end
      end

      it "contains the user's own microposts in the user's Micropost" do
        user.microposts.each do |post_self| #ベタ書き修正の余地あり
          expect(user.feed.include?(post_self)).to be_truthy
        end
      end
    end

    context "when user is not following other_user" do
      it "doesn't contain other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_unfollowed| #ベタ書き修正の余地あり
          expect(user.feed.include?(post_unfollowed)).to be_falsy
        end
      end
    end
  end
end
