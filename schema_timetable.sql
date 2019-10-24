INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  -- Task for yesterday
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  date_trunc('minute', CURRENT_DATE - interval '12 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '12 hours'),
  date_trunc('minute', CURRENT_DATE - interval '12 hours') -
  date_trunc('minute', CURRENT_DATE - interval '12 hours 30 minutes')
),
(
  -- Task for 2 days ago
  (SELECT id FROM tasks WHERE name = 'SQL'),
  date_trunc('minute', CURRENT_DATE - interval '32 hours'),
  date_trunc('minute', CURRENT_DATE - interval '29 hours 40 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '29 hours 40 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '32 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Timer Project'),
  date_trunc('minute', CURRENT_DATE - interval '55 hours'),
  date_trunc('minute', CURRENT_DATE - interval '52 hours'),
  date_trunc('minute', CURRENT_DATE - interval '52 hours') -
  date_trunc('minute', CURRENT_DATE - interval '55 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '81 hours'),
  date_trunc('minute', CURRENT_DATE - interval '80 hours 25 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '80 hours 25 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '81 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '135 hours'),
  date_trunc('minute', CURRENT_DATE - interval '133 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '133 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '135 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Leisure Reading'),
  date_trunc('minute', CURRENT_DATE - interval '140 hours 2 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '136 hours 34 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '136 hours 34 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '140 hours 2 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Spanish'),
  date_trunc('minute', CURRENT_DATE - interval '142 hours 10 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '141 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '141 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '142 hours 10 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Exercise'),
  date_trunc('minute', CURRENT_DATE - interval '160 hours'),
  date_trunc('minute', CURRENT_DATE - interval '158 hours 31 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '158 hours 31 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '160 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '188 hours 3 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '186 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '186 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '188 hours 3 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  date_trunc('minute', CURRENT_DATE - interval '191 hours'),
  date_trunc('minute', CURRENT_DATE - interval '190 hours 37 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '190 hours 37 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '191 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'SQL'),
  date_trunc('minute', CURRENT_DATE - interval '202 hours'),
  date_trunc('minute', CURRENT_DATE - interval '200 hours 17 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '200 hours 17 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '202 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Spanish'),
  date_trunc('minute', CURRENT_DATE - interval '254 hours'),
  date_trunc('minute', CURRENT_DATE - interval '252 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '252 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '254 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Leisure Reading'),
  date_trunc('minute', CURRENT_DATE - interval '275 hours 18 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '271 hours 12 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '271 hours 12 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '275 hours 18 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Leisure Reading'),
  date_trunc('minute', CURRENT_DATE - interval '301 hours'),
  date_trunc('minute', CURRENT_DATE - interval '299 hours 56 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '299 hours 56 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '301 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Timer Project'),
  date_trunc('minute', CURRENT_DATE - interval '318 hours 18 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '316 hours 12 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '316 hours 12 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '318 hours 18 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Timer Project'),
  date_trunc('minute', CURRENT_DATE - interval '320 hours'),
  date_trunc('minute', CURRENT_DATE - interval '319 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '319 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '320 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '326 hours'),
  date_trunc('minute', CURRENT_DATE - interval '324 hours 45 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '324 hours 45 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '326 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Spanish'),
  date_trunc('minute', CURRENT_DATE - interval '345 hours'),
  date_trunc('minute', CURRENT_DATE - interval '343 hours 45 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '343 hours 45 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '345 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  date_trunc('minute', CURRENT_DATE - interval '375 hours 18 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '371 hours 12 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '371 hours 12 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '375 hours 18 minutes')
),
(
  (SELECT id FROM tasks WHERE name = 'Timer Project'),
  date_trunc('minute', CURRENT_DATE - interval '387 hours'),
  date_trunc('minute', CURRENT_DATE - interval '386 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '386 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '387 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Exercise'),
  date_trunc('minute', CURRENT_DATE - interval '399 hours'),
  date_trunc('minute', CURRENT_DATE - interval '398 hours 37 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '398 hours 37 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '399 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Spanish'),
  date_trunc('minute', CURRENT_DATE - interval '402 hours'),
  date_trunc('minute', CURRENT_DATE - interval '400 hours 30 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '400 hours 30 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '402 hours')
),
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  date_trunc('minute', CURRENT_DATE - interval '405 hours'),
  date_trunc('minute', CURRENT_DATE - interval '404 hours 13 minutes'),
  date_trunc('minute', CURRENT_DATE - interval '404 hours 13 minutes') -
  date_trunc('minute', CURRENT_DATE - interval '405 hours')
);
