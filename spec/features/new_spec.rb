require 'rails_helper'

feature 'As a user when I visit new_note_path' do
  it 'I should see a form to create a new note' do
    visit new_note_path

    expect(page).to have_content('create a new note')
    expect(page).to have_content('title')
    expect(page).to have_content('description')
    expect(page).to have_select('type', options: ['note', 'goal'])
  end

  xit 'If type: goal is selected, I should see an input for deadline' do
    visit new_note_path

    # select type = goal

    expect(page).to have_content('deadline')
  end

  xit 'I should be able to submit a valid note' do
    visit new_note_path

    fill_in 'title', with: 'My First Note'
    fill_in 'description', with: 'A very good description'
    # select type = goal
    fill_in 'deadline', with: "07/18/2017"
    click_on 'save'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('You have successfully created a new note.')
  end

  xit 'I should not be able to submit a not without a title' do
    visit new_note_path

    fill_in 'title', with: ''
    fill_in 'description', with: 'A very good description'
    # select type = goal
    fill_in 'deadline', with: "07/18/2017"
    click_on 'save'

    expect(page).to have_current_path(new_note_path)
    expect(page).to have_content('A very good description')
    expect(page).to have_content('title cannot be blank')
  end

  xit 'I should not be able to submit a goal without a deadline' do
    visit new_note_path

    fill_in 'title', with: ''
    fill_in 'description', with: 'A very good description'
    # select type = goal
    fill_in 'deadline', with: "07/18/2017"
    click_on 'save'

    expect(page).to have_current_path(new_note_path)
  end
end
