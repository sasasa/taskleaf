require 'rails_helper'

describe 'タスク管理機能', type: :system  do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:project_a) { create(:project, name: "初回プロジェクト", user: user_a) }
  let!(:task_a) { create(:task, name: '最初のタスク', user: user_a, project: project_a) }
  let!(:task_b) { create(:task, name: '2番目のタスク', user: user_a, project: project_a) }

  before do
    # ユーザーA or Bでログインする C
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end
  
  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認 C
        expect(page).to have_no_content '最初のタスク'
        # expect(page).not_to have_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      
      it 'ユーザーAが作成したタスクが表示される' do
        visit task_path(task_a)
        expect(page).to have_content '最初のタスク'
      end
    end
    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されずエラーになる' do
        expect{ visit task_path(task_a) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '新規作成機能' do
    context 'プロジェクトを選択しなかったとき' do
      let(:login_user) { user_a }
    
      before do
        visit new_task_path
        fill_in '名称', with: task_name
        select "選択してください", from: 'task_project_id'
        click_button '登録する'
      end
      
      context '新規作成画面で名称を入力したとき' do
        let(:task_name) { '新規作成のテストを書く' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'プロジェクトを入力してください'
          end
        end
      end
    end

    context 'プロジェクトを選択した時' do
      let(:login_user) { user_a }
    
      before do
        visit new_task_path
        fill_in '名称', with: task_name
        select "初回プロジェクト", from: 'task_project_id'
        click_button '登録する'
      end
      
      context '新規作成画面で名称を入力したとき' do
        let(:task_name) { '新規作成のテストを書く' }
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
        end
      end
  
      context '更新画面で重複する名称を入力したとき' do
        let(:task_name) { '最初のタスク' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称はすでに存在します'
          end
        end
      end
      
      context '新規作成画面で名称を入力しなかったとき' do
        let(:task_name) { '' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称を入力してください'
          end
        end
      end
    end
  end

  describe '更新機能' do
    context 'プロジェクトを選択しなかったとき' do
      let(:login_user) { user_a }
    
      before do
        visit edit_task_path(task_b)
        fill_in '名称', with: task_name
        select "選択してください", from: 'task_project_id'
        click_button '更新する'
      end
      
      context '更新画面で名称を入力したとき' do
        let(:task_name) { '2番目のタスク' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content 'プロジェクトを入力してください'
          end
        end
      end      
    end
    
    context 'プロジェクトを選択した時' do
      let(:login_user) { user_a }
    
      before do
        visit edit_task_path(task_b)
        fill_in '名称', with: task_name
        select "初回プロジェクト", from: 'task_project_id'
        click_button '更新する'
      end
      
      context '更新画面で名称を入力したとき' do
        let(:task_name) { '2番目のタスク' }
        it '正常に登録される' do
          expect(page).to have_selector '.alert-success', text: 'タスク「2番目のタスク」を更新しました。'
        end
      end
  
      context '更新画面で重複する名称を入力したとき' do
        let(:task_name) { '最初のタスク' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称はすでに存在します'
          end
        end
      end
      
      context '更新画面で名称を入力しなかったとき' do
        let(:task_name) { '' }
        it 'エラーとなる' do
          within '#error_explanation' do
            expect(page).to have_content '名称を入力してください'
          end
        end
      end
    end
  end

  describe '削除機能', js: true do
    let(:login_user) { user_a }
    before do
      visit task_path(task_a)
      click_link '削除'
    end
    context '削除するとき' do
      it '一覧に遷移して削除される' do
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_selector '.alert-success', text: "タスク「最初のタスク」を削除しました。"
      end
    end
    context '削除しないとき' do
      it '遷移せず画面は変わらない' do
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end