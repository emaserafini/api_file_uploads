class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @images = Image.all
  end

  def create
    mime = MIME::Types[request.headers["Content-Type"]].first
    raise 'unknown content type' unless mime # gestire il caso di un content type non riconosciuto
    asset = request.body
    asset.define_singleton_method(:original_filename) do
      File.basename("asset.#{mime.preferred_extension}")
    end
    image = Image.new(asset: asset)
    if image.save
      render json: { image: { asset_url: image.asset.url } }, status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  end
end
