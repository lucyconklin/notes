require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(40) }
    it { is_expected.to validate_presence_of(:note_type) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }

    it 'if validates deadline if note-type is goal' do
      note = Note.new(title: 'Title',
                      note_type: 1,
                      )
      note_2 = Note.new(title: 'Title',
                        note_type: 1,
                        deadline: DateTime.now
                        )

      expect(note).not_to be_valid
      expect(note_2).to be_valid
    end
  end
end
