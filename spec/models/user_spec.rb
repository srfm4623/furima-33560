require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規登録できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@がなければ登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '登録済みのemailでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwaordが6文字以下では登録できない' do
        @user.password = 'Aa1'
        @user.password_confirmation = 'Aa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字混同でなければ登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  Include both letters and numbers')
      end
      it 'pasawordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'AAaa11'
        @user.password_confirmation = '11aaAA'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角の漢字・かな・カナでなければ登録できない' do
        @user.last_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角の漢字・かな・カナ出なければ登録できない' do
        @user.first_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      it 'last_name_readingが空では登録できない' do
        @user.last_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end
      it 'last_name_readingが全角のカナでなければ登録できない' do
        @user.last_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading Full-width katakana characters')
      end
      it 'first_name_readingが空では登録できない' do
        @user.first_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'first_name_readingが全角のカナでなければ登録できない' do
        @user.first_name_reading = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading Full-width katakana characters')
      end
      it 'dateが空では登録できない' do
        @user.date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Date can't be blank")
      end
    end
  end
end
