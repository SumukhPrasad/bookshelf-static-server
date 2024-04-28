require 'sinatra/base'
require 'mime/types'

MEDIA_PATH = './media/'
IMAGES_FOLDER = '/images/'

class BookshelfStaticAssetServer < Sinatra::Base
     
     # ERROR HANDLING
     error do
          render_error 500, env['sinatra.error'].message
     end
     
     not_found do
            render_error 404, 'Not found.'
     end
     
     error 403 do
            render_error 403, 'Forbidden.'
     end
     
     def render_error code, message
          halt code, erb(:error, locals: {status: code, message: message})
     end
     
     error 405...510 do
            erb(:error, locals: {status: -1, message: 'Unknown error.'})
     end
     
     

     # Routes
     get '/images/*' do |image_subpath|
          image_path = File.join(MEDIA_PATH, IMAGES_FOLDER, image_subpath)
          if File.exist?(image_path)
               content_type MIME::Types.type_for(image_path).first.to_s
               send_file image_path
          else
               404
          end
     end
       
     run! if app_file == $0
end