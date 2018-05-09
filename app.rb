require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark'

 class BookmarkManager < Sinatra::Base

   get '/' do
     @bookmarks = Bookmark.all
     erb(:index)
   end

   post '/add' do
     Bookmark.add(params[:url])
     redirect '/'
   end

 end
