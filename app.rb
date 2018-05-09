require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark_factory'

 class BookmarkManager < Sinatra::Base

   get '/' do
     bf = BookmarkFactory.new
     @bookmarks = bf.all
     erb(:index)
   end

 end
