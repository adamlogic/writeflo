require 'spec_helper'

feature "an author shares a writeflo" do
  scenario "sharing multiple versions" do
    visit '/'
    fill_in 'doc-content', with: 'This is my first writeflo!'
    click_button 'share your writeflo'

    page.should have_content('This URL is for you to share')
    share_link = page.find('#new_review_url').value
    share_link.should match(/v1$/)

    click_link 'keep editing'
    fill_in 'doc-content', with: 'This is my updated writeflo!'
    click_button 'share your writeflo'

    page.should have_content('This URL is for you to share')
    share_link = page.find('#new_review_url').value
    share_link.should match(/v2$/)
  end
end
