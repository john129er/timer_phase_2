require 'pg'
require 'pry'

class DatabasePersistence
  def initialize(logger)
    @db = if Sinatra::Base.production?
            PG.connect(ENV['DATABASE_URL'])
          else
            PG.connect(dbname: 'timer')
          end
    @logger = logger
  end
  
  def query(statement, *params)
    @logger.info("#{statement}: #{params}")
    @db.exec_params(statement, params)
  end
  
  def current_task
    sql = <<~SQL
      SELECT tasks.name AS task_name
        FROM tasks
        JOIN timetable ON tasks.id = timetable.task_id
        WHERE timetable.end_at IS NULL AND
              timetable.duration IS NULL;
    SQL
    
    result = query(sql)
    tuple_to_hash(result).first
  end
  
  def all_tasks
    result = query('SELECT name FROM tasks;')
    result.map { |tuple| { name: tuple['name'] } }
  end

  def timer_start(task_name)
    sql = <<~SQL
      INSERT INTO timetable 
        (task_id, start_at)
        SELECT id, date_trunc('minute', NOW())
        FROM tasks 
        WHERE name = $1;
    SQL
    query(sql, task_name)
  end
  
  def timer_stop
    sql = <<~SQL
      UPDATE timetable
        SET end_at = date_trunc('minute', NOW())
        WHERE duration IS NULL;
    SQL
    query(sql)
    compute_task_duration
  end
  
  def compute_task_duration
    sql = <<~SQL
      UPDATE timetable
        SET duration = (end_at - start_at)
        WHERE duration IS NULL;
    SQL
    query(sql)
  end
  
  def add_task(task_name)
    query('INSERT INTO tasks (name) VALUES ($1)', task_name)
  end
  
  def latest_task_completed?
    sql = <<~SQL
      SELECT 1 FROM timetable
        WHERE end_at IS NULL AND duration IS NULL;
    SQL
    query(sql).ntuples == 0
  end
  
  def tasks_completed_for_date(date)
    sql = <<~SQL
      SELECT tasks.name AS task_name,
             TO_CHAR(timetable.start_at, 'HH12:MI') AS start_at,
             TO_CHAR(timetable.end_at, 'HH12:MI') AS end_at,
             TO_CHAR(timetable.duration, 'HH24:MI') AS duration,
             timetable.start_at::date AS task_date
        FROM tasks
        JOIN timetable ON tasks.id = timetable.task_id
        WHERE timetable.start_at::date = $1::date
          AND timetable.duration IS NOT NULL
        ORDER BY tasks.name ASC;
    SQL
    
    result = query(sql, date)
    
    tuple_to_hash(result)
  end
  
  def total_time_tasks_for_date(date)
    sql = <<~SQL
      SELECT SUM(duration) FROM timetable
        WHERE start_at::date = $1::date;
    SQL
    result = query(sql, date)
    
    result.getvalue(0, 0).slice(0, 5)
  end
  
  def tasks_last_seven_days
    sql = <<~SQL
      SELECT TO_CHAR(start_at::date, 'Mon DD') AS date_stamp,
             TO_CHAR(SUM(duration), 'HH24:MI') AS duration,
             start_at::date AS task_date
        FROM timetable
        WHERE start_at::date BETWEEN CURRENT_DATE - 7 AND CURRENT_DATE
        GROUP BY date_stamp, task_date
        ORDER BY date_stamp DESC;
    SQL
    
    result = query(sql)
    
    tuple_to_hash(result)
  end
  
  def total_time_last_seven_days
    sql = <<~SQL
      SELECT TO_CHAR(SUM(duration), 'HH24:MI')
        FROM timetable
        WHERE start_at::date BETWEEN CURRENT_DATE - 7 AND CURRENT_DATE
    SQL
    result = query(sql)
    
    result.getvalue(0, 0)
  end
  
  def format_date(date)
    sql = <<~SQL
      SELECT TO_CHAR($1::date, 'Mon DD YYYY') AS today;
    SQL
    result = query(sql, date)
    result.getvalue(0, 0)
  end
  
  def data_for_date?(date)
    return false unless date.match?(/\d{4}-\d{2}-\d{2}/)
    
    sql = <<~SQL
      SELECT 1
        FROM timetable
        WHERE start_at::date = $1::date;
    SQL
    
    result = query(sql, date)
    result.ntuples > 0
  end
  
  def exists_sample_data?
    result = query('SELECT 1 FROM timetable;')
    result.ntuples > 0
  end
  
  def populate_data    
    sql_file_tasks = File.open('schema_tasks.sql') { |file| file.read }
    query(sql_file_tasks)
    
    sql_file_timetable = File.open('schema_timetable.sql') { |file| file.read }
    query(sql_file_timetable)
  end
  
  def delete_data
    query('DELETE FROM timetable;')
    query('DELETE FROM tasks;')
  end
  
  def disconnect
    @db.close
  end
  
  private
  
  def tuple_to_hash(result)    
    result.map do |tuple|
      {
        task_name: tuple['task_name'],
        start_at: tuple['start_at'],
        end_at: tuple['end_at'],
        total_time: tuple['duration'],
        task_date: tuple['task_date'],
        date_stamp: tuple['date_stamp']
      }
    end
  end
end
