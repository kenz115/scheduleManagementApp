require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "GET /index" do
    it "スケジュール一覧画面が正常にレスポンスを返すこと" do
      get "/schedules"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "スケジュール新規作成画面が正常にレスポンスを返すこと" do
      get "/schedules/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    before do
      @schedule_params = FactoryBot.attributes_for(:schedule)
    end

    it "スケジュールを登録すること" do
      expect {
        post "/schedules", params: {schedule: @schedule_params}
      }.to change(Schedule, :count).by(1)
    end

    it "スケジュール一覧画面に遷移すること" do
      post "/schedules", params: {schedule: @schedule_params}
      expect(response).to redirect_to "/schedules"
    end
  end

  describe "GET /show" do
    it "スケジュール閲覧画面が正常にレスポンスを返すこと" do
      schedule = FactoryBot.create(:schedule)
      get "/schedules", params: {id: schedule.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "スケジュール編集画面が正常にレスポンスを返すこと" do
      schedule = FactoryBot.create(:schedule)
      get "/schedules/#{schedule.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    before do
      @schedule = FactoryBot.create(:schedule)
      @schedule_params = FactoryBot.attributes_for(:schedule, :edit_schedule)
    end

    it "スケジュールを編集すること" do
      patch "/schedules/#{@schedule.id}", params: {schedule: @schedule_params}
      expect(@schedule.reload.title).to eq("食事1")
    end

    it "スケジュール一覧画面に遷移すること" do
      patch "/schedules/#{@schedule.id}", params: {schedule: @schedule_params}
      expect(response).to redirect_to "/schedules"
    end
  end

  describe "GET /destroy" do
    before do
      @schedule = FactoryBot.create(:schedule)
    end

    it "スケジュールを削除すること" do
      expect {
        delete "/schedules/#{@schedule.id}"
      }.to change(Schedule, :count).by(-1)
    end

    it "スケジュール一覧画面に遷移すること" do
      delete "/schedules/#{@schedule.id}"
      expect(response).to redirect_to "/schedules"
    end
  end
end
