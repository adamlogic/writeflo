require 'spec_helper'

feature "an author shares a writeflo" do
  scenario "sharing multiple versions" do
    visit new_doc_path
    fill_in 'doc-content', with: 'This is my first writeflo!'
    click_button 'share your writeflo'

    version = Version.last
    page.should have_content('This URL is for you to share')
    share_link = page.find('#new_review_url').value
    share_link.should match(/share\/#{version.permalink}$/)

    click_link 'keep editing'
    fill_in 'doc-content', with: 'This is my updated writeflo!'
    click_button 'share your writeflo'

    version = Version.last
    page.should have_content('This URL is for you to share')
    share_link = page.find('#new_review_url').value
    share_link.should match(%r{share/#{version.permalink}$})
  end
end
