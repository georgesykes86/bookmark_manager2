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

 end
