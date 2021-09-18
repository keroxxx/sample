class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロードされたファイルがない場合に表示するデフォルトの画像の指定
  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  
  # アップロード可能なファイル拡張子を jpg, jpeg, png, gif に制限    
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  
  def size_range
    0..5.megabytes
  end

  process resize_to_fit:[400,400]

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
