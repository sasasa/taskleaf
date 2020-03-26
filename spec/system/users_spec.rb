require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com', admin: false) }

  before do
    # ユーザーA or Bでログインする C
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context '管理ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      it 'ユーザーの一覧が表示される' do
        visit admin_users_path
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'ユーザーB'
      end
    end

    context '管理ユーザーでないBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーの一覧が表示されない' do
        visit admin_users_path
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認 C
        expect(page).to have_no_content 'ユーザーA'
        expect(page).to have_no_content 'ユーザーB'
      end
    end
  end

  describe '更新機能' do
    let(:login_user) { user_a }
    
    before do
      visit edit_admin_user_path(user_b)
      fill_in '名前', with: user_name
      fill_in 'メールアドレス', with: email
      check 'user_admin'

      click_button '登録する'
    end
    
    context '更新画面で全て入力したとき' do
      let(:user_name) { 'ごとうまさし' }
      let(:email) { 'sample@gmail.com' }

      it '正常に更新されて管理者権限が付与される' do
        expect(page).to have_selector '.alert-success', text: 'ユーザー「ごとうまさし」を更新しました。'
        expect(page).to have_selector 'table td', text: 'あり'
        expect(user_b.reload.admin).to be_truthy
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    
    before do
      visit new_admin_user_path
      fill_in '名前', with: user_name
      fill_in 'メールアドレス', with: email
      fill_in 'パスワード', with: password
      fill_in 'パスワード(確認)', with: password_confirm
      check 'user_admin'

      click_button '登録する'
    end
    
    context '新規作成画面で全て入力したとき' do
      let(:user_name) { 'ごとうまさし' }
      let(:email) { 'sample@gmail.com' }
      let(:password) { 'password' }
      let(:password_confirm) { 'password' }

      it '正常に登録されて管理者権限が付与される' do
        expect(page).to have_selector '.alert-success', text: 'ユーザー「ごとうまさし」を登録しました。'
        expect(page).to have_selector 'table td', text: 'あり'
        expect(User.find_by(name: 'ごとうまさし').admin).to be_truthy
      end
    end

    context '新規作成画面でパスワード(確認)以外を入力したとき' do
      let(:user_name) { 'ごとうまさし' }
      let(:email) { 'sample@gmail.com' }
      let(:password) { 'password' }
      let(:password_confirm) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'パスワード(確認)とパスワードの入力が一致しません'
        end
      end
    end

    context '新規作成画面でパスワード以外を入力したとき' do
      let(:user_name) { 'ごとうまさし' }
      let(:email) { 'sample@gmail.com' }
      let(:password) { '' }
      let(:password_confirm) { 'password' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'パスワードを入力してください'
        end
      end
    end

    context '新規作成画面でメールアドレス以外を入力したとき' do
      let(:user_name) { 'ごとうまさし' }
      let(:email) { '' }
      let(:password) { 'password' }
      let(:password_confirm) { 'password' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'メールアドレスを入力してください'
        end
      end
    end

    context '新規作成画面で名前以外を入力したとき' do
      let(:user_name) { '' }
      let(:email) { 'sample@gmail.com' }
      let(:password) { 'password' }
      let(:password_confirm) { 'password' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名前を入力してください'
        end
      end
    end
  end

  describe '削除機能', js: true do
    let(:login_user) { user_a }
    before do
      visit admin_user_path(user_b)
      click_link '削除'
    end
    context '削除するとき' do
      it '一覧に遷移して削除される' do
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_selector '.alert-success', text: "ユーザー「ユーザーB」を削除しました。"
      end
    end
    context '削除しないとき' do
      it '遷移せず画面は変わらない' do
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_content 'ユーザーB'
      end
    end
    it 'confirmの文字列のテスト' do
      expect(page.driver.browser.switch_to.alert.text).to eq 'ユーザー「ユーザーB」を削除します。よろしいですか？'
      page.driver.browser.switch_to.alert.dismiss
    end

    
  end
end
