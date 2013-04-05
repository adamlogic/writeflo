require 'spec_helper'

feature "an author views his feedback" do
  let(:doc) { create(:doc, content: 'initial content') }

  scenario "paginating through reviews" do
    first_review  = create(:review, version: doc.latest_version, content: 'updated content')
    second_review = create(:review, version: doc.latest_version, content: 'more content')

    visit doc_path(doc)
    page.should have_content('updated content')
    page.should_not have_content('more content')

    click_link '->'
    page.should have_content('more content')
    page.should_not have_content('updated content')

    click_link '<-'
    page.should have_content('updated content')
    page.should_not have_content('more content')
  end

  scenario "my writeflo has no reviews yet" do
    visit doc_path(doc)
    page.should have_selector('#doc-content')
  end
end
