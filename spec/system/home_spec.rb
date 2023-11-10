require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  before do
    driven_by(:rack_test)
  end

  before do
    driven_by :selenium_chrome_headless
  end

 describe 'トップページの検証' do
  it 'Home#top という文字列が表示される' do
     visit '/'

     expect(page).to have_content('Home#top')


  # pending "add some scenarios (or delete) #{__FILE__}"
   end
  end
end
