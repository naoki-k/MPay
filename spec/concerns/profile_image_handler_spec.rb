require "rails_helper"

describe ProfileImage::Handler do
  let(:handler) { test_class.new }
  let(:test_class) do
    Struct.new(:handler) do
      include ProfileImage::Handler
    end
  end

  describe "to_base64" do
    let(:blob_to_base64) { handler.to_base64(blob) }
    let(:blob) { File.open("spec/factories/images/admin_user.png").read }

    it :aggregate_failures do
       expect(blob_to_base64.bytesize % 4).to eq 0
       expect(blob_to_base64).to match(/\A[a-zA-Z\d\/+]+={,2}\z/)
    end
  end

  describe "formatted_blob" do
    let(:original_blob) { File.open("spec/factories/images/admin_user.png").read }
    let(:formatted_blob) { handler.formatted_blob(original_blob) }
    let(:formatted_image) { Magick::Image.from_blob(formatted_blob).first }
    
    it :aggregate_failures do
      expect(original_blob.bytesize).to be > test_class::MAX_BYTE_SIZE
      expect(formatted_blob.bytesize).to be < test_class::MAX_BYTE_SIZE
      expect(formatted_image.columns).to eq test_class::IMAGE_SIZE_X
      expect(formatted_image.rows).to eq test_class::IMAGE_SIZE_Y
      expect(formatted_image.format).to eq "JPEG"
    end
  end
end
