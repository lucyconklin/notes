require 'rails_helper'

feature 'As a user, I can delete notes' do
  before :each do
    @note = Note.create(title: 'This is a title',
                       description: 'this is a description',
                       note_type: 'goal',
                       deadline: DateTime.now
                       )
  end

  scenario 'from the index page' do
    visit root_path

    expect(page).to have_content(:link_or_button, 'Delete')

    click_on 'Delete'

    expect(page).not_to have_content(@note.title)
    expect(page).to have_current_path(root_path)
    expect(Note.count).to eq(0)
  end

  scenario 'from the show page' do
    visit note_path(@note)

    expect(page).to have_content(:link_or_button, 'Delete')

    click_on 'Delete'

    expect(page).not_to have_content(@note.title)
    expect(page).to have_current_path(root_path)
    expect(Note.count).to eq(0)
  end
end
