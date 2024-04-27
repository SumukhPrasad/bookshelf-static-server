require 'sinatra'
require 'mime/types'
set :port, 3001
set :bind, 'localhost'

# IMAGES
IMAGES_FOLDER = './images/'

get '/images/:image_name' do |image_name|
     image_path = File.join(IMAGES_FOLDER, image_name)
     if File.exist?(image_path)
          content_type MIME::Types.type_for(image_path).first.to_s
          send_file image_path
     else
          status 404
          'File Not Found'
     end
end