class Image::Cell < Template::Cell
  def show
    render
  end

  def klass
    options[:klass]
  end

  def id
    options[:id]
  end

  def style
    options[:style]
  end

  def image_url
    if model.try(:image_file)
      image_url = model.image_file.url
      image_url = default_image_url if image_url.nil?
    else
      image_url = default_image_url
    end
    image_url
  end

  def image
    image_tag(image_url, id: id, class: klass, style: style)
  end

  def image_16x9
    image_tag(image_url, id: id, class: klass, style: "position: absolute;object-fit: cover;width: 100%;height: 100%;")
  end

  def default_image_url
    image_path 'users/user-avatar-default.svg'
  end
end
