require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark'
require 'sinatra/flash'

 class BookmarkManager < Sinatra::Base
   enable :sessions
   register Sinatra::Flash


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

 end
