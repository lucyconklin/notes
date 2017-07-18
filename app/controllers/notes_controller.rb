class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:success] = "You successfully created a new note."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :deadline, :note_type)
  end
end
