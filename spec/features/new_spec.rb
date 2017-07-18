require 'rails_helper'

feature 'As a user when I visit new_note_path', js: true do
  it 'I should see a form to create a new note' do
    visit new_note_path

    expect(page).to have_content('create a new note')
    expect(page).to have_content('Title')
    expect(page).to have_content('Description')
    expect(page).to have_select('note_note_type', options: ['note', 'goal'])
  end

  it 'If type: goal is selected, I should see an input for deadline' do
    visit new_note_path

    fill_in 'Title', with: "This is a title"
    fill_in 'Description', with: "A description of my note..."
    find("option[value='goal']").click

    expect(page).to have_content('Deadline')
  end

  it 'If type: note is selected, I not should see an input for deadline' do
    visit new_note_path

    fill_in 'Title', with: "This is a title"
    fill_in 'Description', with: "A description of my note..."
    find("option[value='note']").click

    expect(page).not_to have_content('Deadline')
  end

  it 'I should be able to submit a valid note' do
    visit new_note_path

    fill_in 'Title', with: 'My First Note'
    fill_in 'Description', with: 'A very good description'
    find("option[value='goal']").click
    click_on 'Create Note'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You successfully created a new note.')
  end

  it 'I should not be able to submit a note without a title' do
    visit new_note_path

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'A very good description'
    find("option[value='goal']").click
    fill_in 'Deadline', with: "07/18/2017"
    click_on 'Create Note'

    expect(page).to have_content('create a new note')
    expect(page).to have_content('A very good description')
    expect(page).to have_content("Title can't be blank")
  end

  it 'I should not be able to submit a goal without a deadline' do
    visit new_note_path

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'A very good description'
    find("option[value='goal']").click
    click_on 'Create Note'

    expect(page).to have_selector(:link_or_button, 'Create Note')
    expect(page).to have_content('A very good description')
    expect(page).to have_content("Title can't be blank")
  end
end
