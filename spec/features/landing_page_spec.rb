require 'spec_helper'

feature "a user comes to the landing page" do
  before do
    load 'db/seeds.rb'
  end

  scenario "viewing the landing page content" do
    visit root_path
    page.should have_content('YOU WRITE THINGS')
  end
end
