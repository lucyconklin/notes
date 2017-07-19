# Notes App

## About

This is a simple CRUD app for notes built with Rails.

## Table of Contents
- [Setup](#setup)
- [Highlights](#highlights)
- [Next Steps](#next-steps)

## Setup

First clone this repo:
```
git clone https://github.com/lucyconklin/notes.git
```
Then navigate into the folder:
```
cd notes
```

Bundle:
```
bundle
```

Set up your database:
```
rails db:create
rails db:migrate
rails db:seed
rails db:test:prepare
```

Run the test suite:
```
rspec
```

Spin up the rails server
```
rails s
```

And navigate to [http://localhost:3000/](http://localhost:3000/) to see it in the browser. Click on 'Create a new note' to get started.

## Highlights

I just wanted to point out a few fun things in this repo.

### Enum and Conditional Validation
First, I'm using an enum for note.note_type, and this field is conditionally validated. If they note is saved as a goal, then it must also have a deadline.

```
app/models/note.rb

...

enum note_type: [:note, :goal]

...

validates :deadline, presence: true, if: :is_goal?

def is_goal?
  note_type == "goal"
end

```

### JavaScript for the optional deadline field
I used JavaScript to display the deadline field when "goal" is selected as the type of note.
```
$("select")
  .on("change", function(e){
    var isGoal = this.value == "goal";
    $(".form-deadline").toggleClass("hidden", !isGoal);
  }).change();
```

This also required me to enable JavaScript in the Capybara tests and run it through the browser. Previously, I have used selenium to run it in a very old version of Firefox, which always felt a little strange, and possibly unsafe. The [chromedriver-helper gem](https://github.com/flavorjones/chromedriver-helper) was a big help here and enabled me to run these tests in Chrome.

### Partial views for form and errors
For the new and edit views, I knew there would be a lot of repeated code and styling so I made a `_form.html.erb` partial. For the same reason there is an `_errors.html.erb` partial to handle errors when creating or editing notes.

### Seed file with Faker
This admittedly took longer than expected because I was running into the character limit on title and creating invalid notes. But once I got past that I was good, and it ran smoothly. Here I am using Faker::Hipster to make titles and descriptions.

```
./db/seeds.rb

...

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

...

```

## Next Steps

### UI Improvements
When the deadline field appears in the form, I'd love for that to happen more slowly with a nice smooth animated transition. An even better feature would be to have the content there, but faded and disabled if the note type is 'note'. When 'goal' is selected from the dropdown, it would then be normal opacity. Like this from my original mockups:

<img width="1008" alt="screen shot 2017-07-18 at 10 06 51 pm" src="https://user-images.githubusercontent.com/16562801/28347831-791d3a14-6c07-11e7-986d-1a8015d8170a.png">

I decided not to go with Bootstrap or SASS on this app, because I only wanted to do one massive styling push. I think the forms could be improved with the bootstrap-form gem, and the whole app with a styling framework, but I just kept it simple.

As for the responsiveness, I used percentages wherever possible, but it falls apart with the table. To solve this I would probably redesign those rows to better display on smaller devices. Most likely I would stack the information on top of the edit and delete buttons.

### Grouping by creation date
This does not completely follow the spec because the note are not grouped on the index page. Since I populated the database with a seed file they all have nearly identical creation times, so rather than manufacture data, I decided that it would be a better use of my time to style it. With more time I'd love to group them by deadline, or assign an importance to them that the user could change.

Also, I thought that this part of the spec was probably to see if I could manipulate the data coming from the controller into the views. Here is my controller method and ActiveRecord query:
```
./app/controllers/notes_controller.rb

...

def index
  @notes = Note.select(:id, :title, :note_type, :deadline, :created_at).order('created_at desc')
end

...
```

### A separate front end
This kind of app seems like a great candidate for a decoupled backend API, and frontend React App or something. For the sake of time and simplicity I decided not to go that route, but it would be a good way to complete the challenge as a single page app.
