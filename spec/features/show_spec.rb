require 'rails_helper'

feature "As a user, I can see a note's show page" do
  scenario 'by clicking on the note in the index view' do
    note = Note.create(title: 'This is a title',
                       description: 'this is a description',
                       note_type: 'goal',
                       deadline: DateTime.now
                       )

    visit root_path

    expect(page).to have_content(:link_or_button, note.title)
  end

  scenario "and I see the note's details" do
    note = Note.create(title: 'This is a title',
                       description: 'this is a description',
                       note_type: 'goal',
                       deadline: DateTime.now
                       )

    visit note_path(note)

    expect(page).to have_current_path("/notes/#{note.id}")
    expect(page).to have_content(note.title)
    expect(page).to have_content(note.description)
    expect(page).to have_content(note.note_type)
    expect(page).to have_content(note.deadline.strftime('%m/%d/%Y'))
  end
end
