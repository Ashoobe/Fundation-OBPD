require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "json"
require "bcrypt"

# Database configuration
set :database_file, "./config/database.yml"

# Set port to 3000
set :port, 3000

# Enable sessions for authentication
enable :sessions
set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

# Load models
require_relative './models/user'
require_relative './models/page'
require_relative './models/menu_item'
require_relative './models/news_article'
require_relative './models/image'
require_relative './models/setting'
require_relative './models/contact_submission'

# Helper methods
helpers do
  def logged_in?
    session[:user_id] && User.find_by(id: session[:user_id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect '/admin/login' unless logged_in?
  end

  def require_admin
    require_login
    halt 403, "Access denied" unless current_user&.admin?
  end

  def render_page(page_name)
    erb page_name.to_sym, layout: :layout
  end
end

# Public routes
get "/" do
  @menu_items = MenuItem.root_items.active
  @news_articles = NewsArticle.published.limit(3)
  erb :index, layout: :layout
end

get "/page/:slug" do
  @page = Page.find_by(slug: params[:slug])
  halt 404, "Page not found" unless @page && @page.published
  @menu_items = MenuItem.root_items.active
  erb :page, layout: :layout
end

get "/news" do
  @news_articles = NewsArticle.published
  @menu_items = MenuItem.root_items.active
  erb :news, layout: :layout
end

get "/news/:id" do
  @article = NewsArticle.find(params[:id])
  halt 404, "Article not found" unless @article && @article.published
  @menu_items = MenuItem.root_items.active
  erb :news_article, layout: :layout
end

get "/contact" do
  @menu_items = MenuItem.root_items.active
  erb :contact, layout: :layout
end

post "/contact" do
  submission = ContactSubmission.new(
    name: params[:name],
    email: params[:email],
    message: params[:message]
  )
  
  if submission.save
    redirect "/contact?success=1"
  else
    @error = "Please fill in all fields correctly."
    @menu_items = MenuItem.root_items.active
    erb :contact, layout: :layout
  end
end

# Admin routes
get "/admin/login" do
  # Always show login form, no redirects to avoid confusion
  erb :admin_login, layout: false
end

post "/admin/login" do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/admin"
  else
    @error = "Invalid username or password"
    erb :admin_login, layout: false
  end
end

get "/admin/logout" do
  session.clear
  redirect "/admin/login"
end

get "/admin" do
  require_login
  erb :admin_dashboard, layout: :admin_layout
end

# Admin API endpoints
get "/admin/api/pages" do
  require_login
  content_type :json
  Page.all.order(:position).to_json
end

post "/admin/api/pages" do
  require_login
  halt 403 unless current_user.can_edit?
  
  page = Page.new(JSON.parse(request.body.read))
  if page.save
    content_type :json
    page.to_json
  else
    halt 400, { errors: page.errors.full_messages }.to_json
  end
end

put "/admin/api/pages/:id" do
  require_login
  halt 403 unless current_user.can_edit?
  
  page = Page.find(params[:id])
  if page.update(JSON.parse(request.body.read))
    content_type :json
    page.to_json
  else
    halt 400, { errors: page.errors.full_messages }.to_json
  end
end

delete "/admin/api/pages/:id" do
  require_login
  halt 403 unless current_user.can_edit?
  
  page = Page.find(params[:id])
  page.destroy
  content_type :json
  { success: true }.to_json
end

# Similar routes for menu_items, news_articles, users, etc.
get "/admin/api/menu_items" do
  require_login
  content_type :json
  MenuItem.all.order(:position).to_json
end

get "/admin/api/news" do
  require_login
  content_type :json
  NewsArticle.all.order(created_at: :desc).to_json
end

get "/admin/api/settings" do
  require_login
  content_type :json
  Setting.all.to_json
end

post "/admin/api/settings" do
  require_login
  halt 403 unless current_user.admin?
  
  data = JSON.parse(request.body.read)
  Setting.set(data['key'], data['value'])
  content_type :json
  { success: true }.to_json
end
