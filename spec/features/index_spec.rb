require 'rails_helper'

feature 'As a user, when I visit the root path' do
  scenario 'I should see a button to create a new note' do
    visit root_path

    expect(page).to have_selector(:link_or_button, 'create a new note')
    expect(page).to have_content('my notes')
  end

  scenario 'If I visit a non-existant path I am re-directed to root_path' do
    visit '/cats'

    expect(page).to have_current_path(root_path)
  end

  scenario 'I should see a list of all notes' do
    note = Note.create(title: 'This is a title',
                       description: 'this is a description',
                       note_type: 'goal',
                       deadline: DateTime.now
                       )
    visit root_path

    expect(page).to have_content(note.title)
    expect(page).not_to have_content(note.description)
    expect(page).to have_content(note.deadline.strftime('%m/%d/%Y'))
    expect(page).to have_content(note.created_at.strftime('%m/%d/%Y'))
    expect(page).to have_content(note.updated_at.strftime('%m/%d/%Y'))
  end
end
