require 'sinatra'
require 'sinatra/base'
require_relative './lib/bookmark'
require_relative './lib/database_mapper'
require 'sinatra/flash'

 class BookmarkManager < Sinatra::Base
   enable :sessions
   register Sinatra::Flash

   configure do
     @@orm = DatabaseMapper.new
   end

   helpers do

     def update_params_handler(params)
       update_hash = Hash.new
       params.each do |key, value|
         id, field = key.split("_")[0].to_i, key.split("_")[1]
         update_hash[id] ||= {}
         update_hash[id][field.to_sym] = value
       end
       update_hash
     end

     def update_all(bookmarks)
       bookmarks.each do |id, value_hash|
         @@orm.update_bookmark(id, value_hash[:title], value_hash[:url], )
       end
     end

   end

   get '/' do
     @bookmarks = @@orm.all(Bookmark, 'bookmarks')
     erb(:index)
   end

   post '/add' do
     flash[:notice] = "Not a valid url" unless @@orm.add_bookmark(params[:url], params[:title])
     redirect '/'
   end

   post '/delete/:id' do
     @@orm.delete(params[:id].to_i, 'bookmarks')
     redirect '/'
   end

   post '/update' do
     session[:selection] = @@orm.find_bookmark(params[:update_title])
     redirect '/update'
   end

   get '/update' do
     erb(:update)
   end

   post '/updated' do
     update_all(update_params_handler(params))
     redirect '/'
   end

 end
