require 'sinatra'
require 'sinatra/base'
require_relative './lib/bookmark'
require_relative './lib/database_mapper'
require 'sinatra/flash'

 class BookmarkManager < Sinatra::Base

   configure do
     use Rack::MethodOverride
     @@orm = DatabaseMapper.new
     enable :sessions
     register Sinatra::Flash
   end

   get '/' do
     redirect '/bookmarks'
   end

   get '/bookmarks' do
     @bookmarks = @@orm.all(Bookmark, 'bookmarks')
     erb(:index)
   end

   post '/bookmarks' do
     flash[:notice] = "Not a valid url" unless @@orm.add_bookmark(params[:url], params[:title])
     redirect '/'
   end

   delete '/bookmarks/:id' do
     @@orm.delete(params[:id].to_i, 'bookmarks')
     redirect '/bookmarks'
   end

   post '/bookmarks/:id/edit' do
     redirect  '/bookmarks/' + params[:id] + '/edit'
   end

   get '/bookmarks/:id/edit' do
      @bookmark = @@orm.find_bookmark(params[:id])
     erb(:update)
   end

   patch '/bookmarks/:id' do
     @@orm.update_bookmark(params[:id],params[:title],params[:url])
     redirect '/bookmarks'
   end

 end
