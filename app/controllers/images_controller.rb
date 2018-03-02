class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @images = Image.all
  end

  def create
    mime = MIME::Types[request.headers["Content-Type"]].first
    raise 'unknown content type' unless mime # gestire il caso di un content type non riconosciuto
    asset = ActionDispatch::Http::UploadedFile.new({
      tempfile: temp_file,
      content_type: mime.to_s,
      filename: File.basename("asset.#{mime.preferred_extension}")
    })
    image = Image.new(asset: asset)
    if image.save
      render json: { image: { asset_url: image.asset.url } }, status: :created
    else
      render json: image.errors, status: :unprocessable_entity
    end
  ensure
    clean_tempfile
  end

  private

  def temp_file
    @temp_file ||= Tempfile.new('temp-file').tap do |file|
      file.binmode
      file.write request.body
      file.rewind
    end
  end

  def clean_tempfile
    if temp_file
      temp_file.close
      temp_file.unlink
    end
  end
end
