# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Note.destroy_all

10.times do |i|
  title = Faker::Hipster.word
  description = Faker::Hipster.sentence(8)
  deadline = DateTime.new(2017, rand(1..12), rand(1..30))

  note = Note.new(title:        title,
                  description:  description,
                  note_type:    rand(0..1)
                  )

  note.deadline = deadline if note.note_type == "goal"
  note.save
end

p "Created #{Note.count} notes"
