INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  -- Task for yesterday
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  date_trunc('minute', CURRENT_DATE - interval '12 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '12 hours'),
  '00:30:00'
),
(
  -- Task for 2 days ago
  (SELECT id FROM tasks WHERE name = 'SQL'),
  date_trunc('minute', CURRENT_DATE - interval '32 hours'),
  date_trunc('minute', CURRENT_DATE - interval '29 hours 40 minutes'),
  '02:20:00'
),
(
  (SELECT id FROM tasks WHERE name = 'New Project'),
  date_trunc('minute', CURRENT_DATE - interval '55 hours'),
  date_trunc('minute', CURRENT_DATE - interval '52 hours'),
  '01:00:00'
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '81 hours'),
  date_trunc('minute', CURRENT_DATE - interval '80 hours 25 minutes'),
  '00:35:00'
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '135 hours'),
  date_trunc('minute', CURRENT_DATE - interval '133 hours 30 minutes'),
  '01:30:00'
);
