class BrowsedPlacesController < ApplicationController
  class BrowsedPlaceNotFound < StandardError; end
  rescue_from ActionController::BadRequest, with: :render_404
  rescue_from BrowsedPlaceNotFound, with: :render_404

  def index
    respond_to :json
  end

  private

  def render_404
    head :not_found
  end
end
