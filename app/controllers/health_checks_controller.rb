class HealthChecksController < ApplicationController
  def show
    ChatDirectRoom.last.present?
    render text: :ok
  end
end
