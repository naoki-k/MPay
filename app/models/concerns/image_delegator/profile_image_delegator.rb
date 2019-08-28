module ProfileImageDelegator
  # TODO: rescue処理を書く

  MAX_BYTE_SIZE = 50_000
  IMAGE_SIZE_X = 300
  IMAGE_SIZE_Y = 300

  def to_base64(original_image)
    Base64.strict_encode64(formatted_blob(original_image))  
  end

  private

    def formatted_blob(original_image)
      image = Magick::Image.from_blob(original_image.read).shift
      image = image.resize_to_fill(IMAGE_SIZE_X, IMAGE_SIZE_Y)

      # ファイルサイズが大きければクオリティを下げる
      (0..100).step(5).reverse_each do |quality|
        blob = image.to_blob { self.quality = quality }

        break blob if blob.bytesize <= MAX_BYTE_SIZE
      end
    end
end
