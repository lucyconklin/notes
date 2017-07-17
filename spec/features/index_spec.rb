require 'rails_helper'

feature 'As a user, when I visit the root path' do
  scenario 'I should see a button to create a new note' do
    visit root_path

    expect(page).to have_selector(:link_or_button, 'create a new note')
    expect(page).to have_content('my notes')
  end

  xscenario 'If I visit a non-existant path I am re-directed to root_path' do
    visit '/cats'

    expect(page).to have_current_path(root_path)
  end
end
