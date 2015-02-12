require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = []

# this will store an id to user for your users
# you'll need to increment it every time you add
# a new user, but don't decrement it
id = 1

# routes to implement:
#
# GET / - show all users
#-----------------------------------------------------
get '/' do
  @users = users
  erb :index
end

# GET /users/new - display a form for making a new user
#-----------------------------------------------------
get '/users/new' do
  erb :new
end
#
# POST /users - create a user based on params from form
#-----------------------------------------------------
#define a user object, (an empty hash)
#assign a key of name user[:name] = :params[:name] 

post '/users' do
user = {}
user[:name] = params[:name]
user[:id] = id 

users.push(user)
id += 1            # id = id + 1
redirect '/'
end
# params = {
#   name: "Bob"
# }

# params[:name] = "Bob"
# GET /users/:id - show a user's info by their id, this should display the info in a form
#-----------------------------------------------------
get '/users/:id' do
  users.each do |user|
    if user[:id] == params[:id].to_i
      @user = user
      
    end
  end  

  erb :edit
end

#
# PUT /users/:id - update a user's info based on the form from GET /users/:id
#-----------------------------------------------------
put '/users/:id' do
  user = users[params[:id].to_i - 1]
  user[:name] = params[:name]
  redirect to '/'
end
#
# DELETE /users/:id - delete a user by their id
#-----------------------------------------------------
delete '/users/:id' do
  #DONT NEED THE FOLLOWING!!!!!
  # user = users[params[:id].to_i]
  users.delete_if { |user| user[:id] == params[:id].to_i}
  redirect to '/'
end


# @users = users
#   users.each_withindex
#   users.delete_if [{ |key, value| value == user[:id] }]



# user = users[params[:id].to_i - 1]
#   user[:name] = params[:name]
#   users.delete(:name)
#   redirect to '/'
