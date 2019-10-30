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

def error_for_task_name(task_name)
  if !(1..30).cover?(task_name.size)
    'List name must be between 1 and 100 characters.'
  elsif @storage.all_tasks.any? { |task| task[:name] == task_name }
    'Task name must be unique.'
  end
end

before do
  @storage = DatabasePersistence.new(logger)
end

after do
  @storage.disconnect
end

get '/' do
  redirect '/timer'
end

get '/timer' do
  @tasks = @storage.all_tasks
  erb :home, layout: :layout
end

post '/start_time' do
  task_name = params[:task_name]

  if @storage.latest_task_completed?
    @storage.timer_start(task_name)
    session[:success] = "The timer has started for task: #{task_name}."
    redirect '/timer'
  else
    @tasks = @storage.all_tasks
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
    @tasks = @storage.all_tasks
    erb :home, layout: :layout
  end
end

post '/task/add' do
  task_name = params[:task_name].strip

  error = error_for_task_name(task_name)
  if error
    session[:error] = error
    @tasks = @storage.all_tasks
    erb :home, layout: :layout
  else
    @storage.add_task(task_name)
    session[:success] = "Task #{task_name} was added successfully."
    redirect '/timer'
  end
end

get '/timer/history' do
  @tasks_today = @storage.tasks_completed_for_date('today')
  @current_date = @storage.format_date('today')
  @total_time_today = @storage.total_time_tasks_for_date('today') unless @tasks_today.empty?
  
  @tasks_last_seven_days = @storage.tasks_last_seven_days
  @total_time = @storage.total_time_last_seven_days unless @tasks_last_seven_days.empty?
  
  erb :history, layout: :layout
end

get '/timer/:date_stamp' do
  date_stamp = params[:date_stamp]
  redirect '/timer' unless @storage.data_for_date?(date_stamp)
  
  @formatted_date = @storage.format_date(date_stamp)
  @tasks = @storage.tasks_completed_for_date(date_stamp)
  @total_time = @storage.total_time_tasks_for_date(date_stamp)
  
  erb :date, layout: :layout
end

post '/create_sample_data' do
  if @storage.exists_sample_data?
    session[:error] = 'Please delete old sample data before populating new sample data.'
  else
    @storage.populate_data
    session[:success] = 'New sample data has been populated.'
  end
  redirect '/timer'
end

post '/delete_all_data' do
  @storage.delete_data
  session[:success] = 'All data has been removed from the database.'
  redirect '/timer'
end

not_found do
  redirect '/timer'
end
