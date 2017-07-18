require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(40) }
    it { is_expected.to validate_presence_of(:note_type) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
  end
end
