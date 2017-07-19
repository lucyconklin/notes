require 'rails_helper'

feature 'As a user, I can edit notes' do
  before :each do
    @note = Note.create(title: 'This is a title',
                       description: 'this is a description',
                       note_type: 'goal',
                       deadline: DateTime.now
                       )
  end

  scenario 'from the index page' do
    visit root_path

    expect(page).to have_content(:link_or_button, 'Edit')
  end

  scenario 'from the show page' do
    visit note_path(@note)

    expect(page).to have_content(:link_or_button, 'Edit')
  end

  scenario 'I can edit all fields' do
    visit edit_note_path(@note)

    expect(page).to have_content('edit note')
    expect(page).to have_content(@note.description)
    expect(page).to have_content(@note.note_type)
  end

  scenario 'I can save a valid note' do
    title = "Something new"
    description = "New stuff"
    deadline = DateTime.new(2001,2,3)

    visit edit_note_path(@note)

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Deadline', with: deadline
    click_on 'Save Note'

    expect(page).to have_content(:link_or_button, 'Edit')
    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content(@note.note_type)
    expect(page).to have_content('02/03/2001')

    expect(page).not_to have_content('This is a title')
    expect(page).not_to have_content('this is a description')
  end

  scenario 'invalid titles cannot be saved' do
    title = ""
    description = "New stuff"
    deadline = DateTime.new(2001,2,3)

    visit edit_note_path(@note)

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Deadline', with: deadline
    click_on 'Save Note'

    expect(page).to have_content('edit note')
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'invalid deadlines cannot be saved' do
    title = "Title"
    description = "New stuff"
    deadline = ""

    visit edit_note_path(@note)

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Deadline', with: deadline
    click_on 'Save Note'

    expect(page).to have_content('edit note')
    expect(page).to have_content("Deadline can't be blank")
  end
end
