class NotesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource


  def index
    @notes = Note.all
    @topics = Topic.all
    @note = Note.new
    respond_with(@notes)
  end

  def show
  end

  def new
    respond_with(@note)
  end

  def edit
  end

  def create
    @note.user_id = current_user.id
    @tags = @note.tagsline.split(';')

    respond_to do |format|
      if @note.save
        @tags.each do |tag|
          if Topic.where(name: tag.downcase).exists?
            @topic = Topic.find_by(name: tag.downcase)
            @tag = @note.tags.new(topic_id:@topic.id)
            @tag.save
          else
            @topic = Topic.create(name:tag.downcase)
            @note.tags.create(topic_id:@topic.id)
          end
        end
        format.html { redirect_to notes_url, :gflash => { :success => 'Note was successfully created' } }
      else
        format.html { redirect_to notes_url, :gflash => { :error => 'Something went wrong, Note wasn\'t created' } }
      end
    end
  end

  def update
    @note.update(note_params)
    respond_with(@note)
  end

  def destroy
    @note.destroy
    respond_with(@note)
  end

  private

    def note_params
      params.require(:note).permit(:title, :body, :tagsline)
    end
end
