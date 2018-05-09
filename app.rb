require 'sinatra'
require 'sinatra/base'
require_relative 'lib/bookmark'
require 'sinatra/flash'
require 'uri'

 class BookmarkManager < Sinatra::Base
   enable :sessions
   register Sinatra::Flash

   helpers do

      def valid_url?(url)
         !!(url =~ /\A#{URI::regexp}\z/)
      end

   end

   get '/' do
     @bookmarks = Bookmark.all
     erb(:index)
   end

   post '/add' do
     url = params[:url]
     if valid_url?(url)
       Bookmark.add(params[:url])
     else
       flash[:notice] = "Not a valid url"
     end
     redirect '/'
   end

 end
