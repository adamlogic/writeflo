require 'spec_helper'

feature "a peer reviews a writeflo" do
  scenario "reviewing a specific version" do
    doc            = create(:doc, content: 'initial content')
    first_version  = doc.latest_version
    second_version = create(:version, content: 'updated content', doc: doc)

    visit new_review_path(doc, version: 1)
    writeflo_content = page.find('#review_content').value
    writeflo_content.should_not include('updated')

    visit new_review_path(doc, version: 2)
    writeflo_content = page.find('#review_content').value
    writeflo_content.should include('updated')
  end
end
