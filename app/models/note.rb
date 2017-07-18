class Note < ApplicationRecord
  enum note_type: [:note, :goal]
  validates_presence_of :title
  validates_presence_of :note_type
  validates_length_of :title, maximum: 40
  validates_length_of :description, maximum: 1000
  validates :deadline, presence: true, if: :is_goal?

  def is_goal?
    note_type == "goal"
  end
end
