require 'spec_helper'

feature "a peer reviews a writeflo" do
  let(:doc) { create(:doc, content: 'initial content') }

  scenario "reviewing a specific version" do
    first_version  = doc.latest_version
    second_version = create(:version, content: 'updated content', doc: doc)

    visit new_review_path(first_version)
    content = page.find('#doc-content').value
    content.should_not include('updated')

    visit new_review_path(second_version)
    content = page.find('#doc-content').value
    content.should include('updated')
  end

  scenario "previewing a review" do
    visit new_review_path(doc.latest_version)

    fill_in 'doc-content', with: 'updated content'
    click_button 'preview your edits'

    page.should have_selector('.deleted', text: 'initial')
    page.should have_selector('.added', text: 'updated')
    current_path.should match(%r{share/.*/reviews/.*/preview})
  end

  scenario "saving a review" do
    visit new_review_path(doc.latest_version)

    fill_in 'doc-content', with: 'updated content'
    click_button 'save your review'

    page.should have_content('Thanks')
  end

  scenario "previewing and saving a review with no changes" do
    visit new_review_path(doc.latest_version)
    fill_in 'doc-content', with: 'initial content'

    expect {
      click_button 'preview your edits'
    }.to_not change { Review.count }

    fill_in 'doc-content', with: 'initial content'

    expect {
      click_button 'save your review'
    }.to_not change { Review.count }

    page.should have_content('Thanks')
  end
end
