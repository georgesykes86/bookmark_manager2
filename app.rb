require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark'
require 'sinatra/flash'

 class BookmarkManager < Sinatra::Base
   enable :sessions
   register Sinatra::Flash

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
         Bookmark.update(id: id, url: value_hash[:url], title: value_hash[:title])
       end
     end

   end

   get '/' do
     @bookmarks = Bookmark.all
     erb(:index)
   end

   post '/add' do
     flash[:notice] = "Not a valid url" unless Bookmark.add(params[:url], params[:title])
     redirect '/'
   end

   post '/delete/:id' do
     Bookmark.delete(params[:id].to_i)
     redirect '/'
   end

   post '/update' do
     session[:selection] = Bookmark.find(params[:update_title])
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
