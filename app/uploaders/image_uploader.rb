class ImageUploader < Shrine
  plugin :derivatives
  require "image_processing/mini_magick"
  Attacher.derivatives_processor do |original|
    processor = ImageProcessing::MiniMagick.source(original)

    {
      large:  processor.resize_to_limit!(800, 800),
      medium: processor.resize_to_limit!(300, 300),
      small:  processor.resize_to_limit!(70, 70),
    }
  end
end
