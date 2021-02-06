require 'rails_helper'

RSpec.describe OrderingParty, type: :model do
  describe '商品購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @ordering_party = FactoryBot.build(:ordering_party, user_id: @user.id, item_id: @item.id)
      sleep 0.1 # 0.1秒待機
    end
    context '商品購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@ordering_party).to be_valid
      end
      it 'building_nameが空でも保存できる' do
        @ordering_party.building_name = nil
        expect(@ordering_party).to be_valid
      end
    end
    context '商品購入できないとき' do
      it 'tokenが空だと保存できない' do
        @ordering_party.token = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_numberが空だと保存できない' do
        @ordering_party.post_number = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("Post number can't be blank", 'Post number input correctly')
      end
      it 'post_numberにハイフンがないと保存できない' do
        @ordering_party.post_number = '1234567'
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include('Post number input correctly')
      end
      it 'prefecture_idを選択しないと保存できない' do
        @ordering_party.prefecture_id = 0
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include('Prefecture select')
      end
      it 'cityが空だと保存できない' do
        @ordering_party.city = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できない' do
        @ordering_party.house_number = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("House number can't be blank")
      end
      it 'house_numberが空だと保存できない' do
        @ordering_party.phone_number = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @ordering_party.phone_number = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include("Phone number can't be blank", 'Phone number input only number')
      end
      it 'phone_numberにハイフンがあると保存できない' do
        @ordering_party.phone_number = '090-1234-5678'
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include('Phone number input only number')
      end
      it 'phone_numberは11桁以下でないと保存できない' do
        @ordering_party.phone_number = '0901234567'
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include('Phone number input only number')
      end
      it 'phone_numberは12桁以上でないと保存できない' do
        @ordering_party.phone_number = '090123456789'
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include('Phone number input only number')
      end
      it 'user_idがないと保存できない' do
        @user = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include
      end
      it 'item_idがないと保存できない' do
        @item = nil
        @ordering_party.valid?
        expect(@ordering_party.errors.full_messages).to include
      end
    end
  end
end
