module ApplicationHelper
  
  def full_title(page_title = '')
    base_title = "sample"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  require 'chunky_png'


  def qrcode_tag(text, options = {})
      qr = ::RQRCode::QRCode.new(text)
    return ChunkyPNG::Image.from_datastream(qr.as_png.resize(500,500).to_datastream).to_data_url
  end
end