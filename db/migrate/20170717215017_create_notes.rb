class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.column :note_type, :integer, default: 0
      t.datetime :deadline

      t.timestamps
    end
  end
end
