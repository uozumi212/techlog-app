require 'rails_helper'

describe User do
  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:user) { User.new(nickname: nickname, email: email, password: password, password_confirmation: password) } # 変数に格納

  describe '.first' do
    before do
      create(:user, nickname: nickname, email: email)
    end

    subject { described_class.first }

    it '事前に作成した通りのUserを返す' do
      expect(subject.nickname).to eq('テスト太郎')
      expect(subject.email).to eq('test@example.com')
    end
  end

  describe 'validation' do
    let(:password) { '12345678' }

    describe 'nickname属性' do
      describe '文字数制限の検証' do
        context 'nicknameが20文字以下の場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

          it 'User オブジェクトは有効である' do
            expect(user.valid?).to be(true)
          end
        end

        context 'nicknameが20文字を超える場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

          it 'User オブジェクトは無効である' do
            user.valid?

            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include('は20文字以下に設定して下さい。')
          end
        end
      end

      describe '存在性の検証' do
        context 'nicknameが空欄の場合' do
          let(:nickname) { '' }

          it 'User オブジェクトは無効である' do
            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include("が入力されていません。")
          end
        end
      end
    end
  end
end




# require 'rails_helper'

# describe 'User', type: :system do
#   before { driven_by :selenium_chrome_headless }

#   # ユーザー情報入力用の変数
#   let(:email) { 'test@example.com' }
#   let(:nickname) { 'テスト太郎' }
#   let(:password) { 'password' }
#   let(:password_confirmation) { password }

#   describe 'ユーザー登録機能の検証' do
#     before { visit '/users/sign_up' }

#     # ユーザー登録を行う一連の操作を subject にまとめる
#     subject do
#       fill_in 'user_nickname', with: nickname
#       fill_in 'user_email', with: email
#       fill_in 'user_password', with: password
#       fill_in 'user_password_confirmation', with: password_confirmation
#       click_button 'ユーザー登録'
#     end

#     context '正常系' do
#       it 'ユーザーを作成できる' do
#         expect { subject }.to change(User, :count).by(1) # Userが1つ増える
#         expect(current_path).to eq('/') # ユーザー登録後はトップページにリダイレクト
#       end
#     end

#     context '異常系' do
#       context 'nicknameが空の場合' do
#         let(:nickname) { '' }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count) # Userが増えない
#           expect(page).to have_content("Nickname can't be blank") # エラーメッセージのチェック
#         end
#       end

#       context 'nicknameが20文字を超える場合' do
#         let(:nickname) { 'あ' * 21 }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content('Nickname is too long (maximum is 20 character')
#         end
#       end

#       context 'emailが空の場合' do
#         let(:email) { '' }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content("Email can't be blank")
#         end
#       end

#       context 'passwordが空の場合' do
#         let(:password) { '' }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content("Password can't be blank")
#         end
#       end

#       context 'passwordが6文字未満の場合' do
#         let(:password) { 'a' * 5 }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content('Password is too short (minimum is 6 characters')
#         end
#       end

#       context 'passwordが128文字を超える場合' do
#         let(:password) { 'a' * 129 }
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content('Password is too long (maximum is 128 characters)')
#         end
#       end

#       context 'passwordとpassword_confirmationが一致しない場合' do
#         let(:password_confirmation) { "#{password}hoge" } # passwordに"hoge"を足した文字列にする
#         it 'ユーザーを作成せず、エラーメッセージを表示する' do
#           expect { subject }.not_to change(User, :count)
#           expect(page).to have_content("Password confirmation doesn't match Password")
#         end
#       end
#     end
#   end

#   describe 'ログイン機能の検証' do
#     # 事前にユーザー作成
#     before do
#       create(:user, nickname: nickname, email: email, password: password, password_confirmation: password) # 事前にユーザー作成

#       visit '/users/sign_in'
#       fill_in 'user_email', with: email
#       fill_in 'user_password', with: 'password'
#       click_button 'ログイン'
#     end

#     context '正常系' do
#       it 'ログインに成功し、トップページにリダイレクトする' do
#         expect(current_path).to eq('/')
#       end
#     end

#     context '異常系' do
#       let(:password) { 'NGpassword' }
#       it 'ログインに失敗し、ページ遷移しない' do
#         expect(current_path).to eq('/users/sign_in')
#       end
#         it 'ログイン失敗時のフラッシュメッセージを表示する' do  # 追加
#           expect(page).to have_content('Invalid Email or password')
    
#     end
#   end
# end