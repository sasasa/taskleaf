require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:project_a) { create(:project, name: "初回プロジェクト", user: user_a) }
  let!(:task_a) { create(:task, name: "初回タスク", user: user_a, project: project_a) }

  before do
    # ユーザーA or Bでログインする C
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したプロジェクトが表示される' do
        visit projects_path
        expect(page).to have_content '初回プロジェクト'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したプロジェクトが表示されない' do
        visit projects_path
        expect(page).to have_no_content '初回プロジェクト'
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    
    before do
      visit new_project_path
      fill_in 'プロジェクト名称', with: project_name
      fill_in 'タスク名称', with: task_name
      
      click_button '登録する'
    end
    
    context 'タスク名称を入力したとき' do
      context '新規作成画面でプロジェクト名称を入力しないとき' do
        let(:project_name) { '' }
        let(:task_name) { 'タスク名' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'プロジェクト名称を入力してください'
          end
        end
      end
  
      context '新規作成画面で重複したプロジェクト名称を入力したとき' do
        let(:project_name) { '初回プロジェクト' }
        let(:task_name) { 'タスク名' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'プロジェクト名称はすでに存在します'
          end
        end
      end
  
      context '新規作成画面でプロジェクト名称を入力したとき' do
        let(:project_name) { '次回プロジェクト' }
        let(:task_name) { 'タスク名' }
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: 'プロジェクト「次回プロジェクト」を登録しました。'
        end
      end

      context '新規作成画面で重複したタスク名称と正しいプロジェクト名称を入力したとき' do
        let(:project_name) { '次回プロジェクト' }
        let(:task_name) { '初回タスク' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'タスク名称はすでに存在します'
          end
        end
      end
    end

    context 'タスク名称を入力しないとき' do
      context '新規作成画面でプロジェクト名称を入力したとき' do
        let(:project_name) { '次回プロジェクト' }
        let(:task_name) { '' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'タスク名称を入力してください'
          end
        end
      end
    end
  end


end
