require 'rails_helper'

RSpec.feature "Schedules", type: :feature do
    scenario "スケジュールを作成する" do

        schedule = FactoryBot.build(:schedule)
        visit "/schedules"
        click_link "スケジュール新規登録"

        expect {
            find('input[type="text"]').set(schedule.title)
            find('#start_date').set(schedule.start_date)
            find('#end_date').set(schedule.end_date)
            find('input[type="checkbox"]').set(schedule.all_day)
            find('textarea').set(schedule.memo)
            click_button "スケジュールを新規登録する"

            expect(page).to have_content "スケジュールを登録しました。"
            expect(page).to have_content "勉強"
            expect(page).to have_content "3021年 05月22日"
            expect(page).to have_content "3021年 05月23日"
            expect(page).to have_content "○"
            expect(page).to have_content "確認"
            expect(page).to have_content "編集"
            expect(page).to have_content "削除"
        }.to change(Schedule, :count).by(1)
    end

    feature do
        before do

            FactoryBot.create(:schedule)
            visit "/schedules"
            click_link "確認"

        end
        scenario "スケジュールを閲覧して一覧画面に戻る" do
    
            expect(page).to have_content "スケジュール詳細"
            expect(page).to have_content "勉強"
            expect(page).to have_content "3021年 05月22日"
            expect(page).to have_content "3021年 05月23日"
            expect(page).to have_content "○"
            expect(page).to have_content "メモ"
            click_link "スケジュール一覧に戻る"
            expect(page).to have_content "スケジュール一覧"
    
        end
        scenario "スケジュールを閲覧して編集画面に遷移する" do
    
            expect(page).to have_content "スケジュール詳細"
            expect(page).to have_content "勉強"
            expect(page).to have_content "3021年 05月22日"
            expect(page).to have_content "3021年 05月23日"
            expect(page).to have_content "○"
            expect(page).to have_content "メモ"
            click_link "スケジュールを編集する"
            expect(page).to have_content "スケジュール編集"
    
        end
        scenario "スケジュールを閲覧して削除する" do
            
            expect {
                expect(page).to have_content "スケジュール詳細"
                expect(page).to have_content "勉強"
                expect(page).to have_content "3021年 05月22日"
                expect(page).to have_content "3021年 05月23日"
                expect(page).to have_content "○"
                expect(page).to have_content "メモ"
                click_link "スケジュールを削除する"
                expect(page).to have_content "スケジュールを削除しました"
            }.to change(Schedule, :count).by(-1)
    
        end
    end

    feature do
        before do
            FactoryBot.create(:schedule)
            visit "/schedules"
            click_link "編集"
        end

        scenario "スケジュールを編集する" do
    
            expect {
                expect(page).to have_content "スケジュール編集"
                find('input[type="text"]').set("食事")
                find('#start_date').set("3021-5-23")
                find('#end_date').set("3021-5-24")
                find('input[type="checkbox"]').set(false)
                click_button "スケジュールの編集を完了する"
    
                expect(page).to have_content "スケジュールを編集しました。"
                expect(page).to have_content "食事"
                expect(page).to have_content "3021年 05月23日"
                expect(page).to have_content "3021年 05月24日"
                expect(page).to_not have_content "○"
                expect(page).to have_content "確認"
                expect(page).to have_content "編集"
                expect(page).to have_content "削除"
            }.to change(Schedule, :count).by(0)
    
        end

        scenario "編集画面からスケジュール一覧画面に戻る" do
            expect(page).to have_content "スケジュール編集"
            click_link "スケジュール一覧に戻る"
            expect(page).to have_content "スケジュール一覧"
            expect(page).to have_content "勉強"
            expect(page).to have_content "3021年 05月22日"
            expect(page).to have_content "3021年 05月23日"
            expect(page).to have_content "○"
        end
    end

    scenario "スケジュールを削除する" do

        FactoryBot.create(:schedule)
        visit "/schedules"
        
        expect {
            click_link "削除"
            expect(page).to have_content "スケジュールを削除しました"
        }.to change(Schedule, :count).by(-1)

    end
end
