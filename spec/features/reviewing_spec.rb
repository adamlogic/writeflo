require 'spec_helper'

feature "a peer reviews a writeflo" do
  scenario "reviewing a specific version" do
    doc            = create(:doc, content: 'initial content')
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
    doc = create(:doc, content: 'initial content')
    visit new_review_path(doc.latest_version)

    fill_in 'doc-content', with: 'updated content'
    click_button 'preview your edits'

    page.should have_selector('.deleted', text: 'initial')
    page.should have_selector('.added', text: 'updated')
    current_path.should match(%r{share/.*/reviews/.*/preview})
  end

  scenario "saving a review" do
    doc = create(:doc, content: 'initial content')
    visit new_review_path(doc.latest_version)

    fill_in 'doc-content', with: 'updated content'
    click_button 'save your review'

    page.should have_content('Thanks')
  end
end
