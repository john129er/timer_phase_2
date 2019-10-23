require 'sinatra'
require 'tilt/erubis'
require 'pry'

require_relative 'database_persistence'

configure(:development) do
  require 'sinatra/reloader'
  also_reload 'database_persistence.rb'
end

configure do
  enable :sessions
  set :erb, :escape_html => true
end

before do
  @storage = DatabasePersistence.new(logger)
  
  # Methods for populating sample data
  if @storage.no_new_data?
    @storage.remove_unfinished_tasks
    @storage.add_sample_data
  end
end

after do
  @storage.disconnect
end

get '/' do
  redirect '/timer'
end

get '/timer' do
  @tasks = @storage.load_tasks
  erb :home, layout: :layout
end

post '/start_time' do
  task_name = params[:task_name]

  if @storage.latest_task_completed?
    @storage.timer_start(task_name)
    session[:success] = "The timer has started for task: #{task_name}."
    redirect '/timer'
  else
    @tasks = @storage.load_tasks
    session[:error] = 'Please end the current task before starting another.'
    erb :home, layout: :layout
  end
end

post '/end_time' do
  current_task = @storage.current_task
  if current_task
    task_name = current_task[:task_name]
    @storage.timer_stop
    session[:success] = "Task #{task_name} has been completed."
    redirect '/timer'
  else
    session[:error] = 'Please begin a task before clicking End Time.'
    @tasks = @storage.load_tasks
    erb :home, layout: :layout
  end
end

post '/task/add' do
  new_task = params[:new_task]
  @storage.add_task(new_task)
  redirect '/timer'
end

get '/timer/history' do
  @tasks_today = @storage.tasks_completed_for_date('today')
  @current_date = @storage.format_date('today')
  @total_time_today = @storage.total_time_tasks_for_date('today') unless @tasks_today.nil?
  
  @tasks_last_seven_days = @storage.tasks_last_seven_days
  @total_time = @storage.total_time_last_seven_days unless @tasks_last_seven_days.nil?
  
  erb :history, layout: :layout
end

get '/timer/:date_stamp' do
  date_stamp = params[:date_stamp]
  redirect '/' unless @storage.data_for_date?(date_stamp)
  
  @formatted_date = @storage.format_date(date_stamp)
  @tasks = @storage.tasks_completed_for_date(date_stamp)
  
  erb :date, layout: :layout
end

not_found do
  redirect '/'
end
