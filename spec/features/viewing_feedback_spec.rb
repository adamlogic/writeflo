require 'spec_helper'

feature "an author reviews his feedback" do
  scenario "paginating through reviews" do
    doc           = create(:doc, content: 'initial content')
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
end
