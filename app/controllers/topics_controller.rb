class TopicsController < ApplicationController
  def index
    note_ids = Tag.where(topic_id:params[:id]).pluck(:note_id).uniq
    @notes = Note.where(id:note_ids)
  end
end
