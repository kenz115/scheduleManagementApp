require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "存在、重複の確認" do
  
    it "タイトル、開始日、終了日があれば有効な状態であること" do
      schedule = FactoryBot.build(:schedule)
      expect(schedule).to be_valid
    end
  
    it "タイトルがなければ無効な状態であること" do
      schedule = FactoryBot.build(:schedule, title: nil)
      schedule.valid?
      expect(schedule.errors[:title]).to include("を入力してください")
    end
  
    it "開始日がなければ無効な状態であること" do
      schedule = FactoryBot.build(:schedule, start_date: nil, end_date: nil)
      schedule.valid?
      expect(schedule.errors[:start_date]).to include("を入力してください")
    end
  
    it "終了日がなければ無効な状態であること" do
      schedule = FactoryBot.build(:schedule, end_date: nil)
      schedule.valid?
      expect(schedule.errors[:end_date]).to include("を入力してください")
    end
  
    it "重複したタイトルなら無効な状態であること" do
      FactoryBot.create(:schedule, title: "重複タイトル")
      schedule = FactoryBot.build(:schedule, title: "重複タイトル")
      schedule.valid?
      expect(schedule.errors[:title]).to include("はすでに存在します")
    end  
  end
  
  describe "文字数制限の確認" do

    before do
      @schedule = FactoryBot.build(:schedule, :over_characters)
    end

    it "タイトルが21文字以上なら無効な状態であること" do
      @schedule.valid?
      expect(@schedule.errors[:title]).to include("は20文字以内で入力してください")
    end

    it "メモが51文字以上なら無効な状態であること" do
      @schedule.valid?
      expect(@schedule.errors[:memo]).to include("は50文字以内で入力してください")
    end
  end

  describe "無効な日付が入力されていないかの確認" do
    before do
      @schedule = FactoryBot.build(:schedule, :error_date)
    end

    it "開始日が過去の日付なら無効な状態であること" do
      @schedule.valid?
      expect(@schedule.errors[:start_date]).to include("は本日以降の日付を入力して下さい")
    end

    it "終了日が開始日より過去の日付なら無効な状態であること" do
      @schedule.valid?
      expect(@schedule.errors[:end_date]).to include("は開始日以降の日付を入力してください")
    end
  end
end
