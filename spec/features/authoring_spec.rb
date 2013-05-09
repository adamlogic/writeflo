require 'spec_helper'

feature "an author creates a writeflo" do
  scenario "initial page load" do
    visit new_doc_path
    content = page.find('#doc-content').value
    content.should == 'Start writing.'
  end
end
