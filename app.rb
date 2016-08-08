require 'sinatra'
require 'rmagick'
require 'slim'
require 'logger'

logger = Logger.new(STDOUT)

get '/' do
  slim :index
end

post '/' do
  message = params['message']
  image = Magick::ImageList.new('image.png')
  draw = Magick::Draw.new
  draw.annotate(image, 0, 0, 50, 100, message) do
    self.font = 'logotype.otf'
    self.fill = '#333333'
    self.align = Magick::LeftAlign
    self.stroke = 'transparent'
    self.pointsize = 30
    self.text_antialias = true
    self.kerning = 1
  end
  image.write('public/tmp.png')
  slim :index
end
