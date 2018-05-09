require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark'
require 'sinatra/flash'
require 'uri'

 class BookmarkManager < Sinatra::Base
   enable :sessions
   register Sinatra::Flash


   get '/' do
     @bookmarks = Bookmark.all
     erb(:index)
   end

   post '/add' do
     flash[:notice] = "Not a valid url" unless Bookmark.add(params[:url])
     redirect '/'
   end

 end
