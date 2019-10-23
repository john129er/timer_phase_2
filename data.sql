INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  '2019-10-18 10:05:00',
  '2019-10-18 10:35:00',
  '00:30:00'
);

INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  '2019-10-18 10:40:00',
  '2019-10-18 13:00:00',
  '02:20:00'
);

INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'New Project'),
  '2019-10-18 13:35:00',
  '2019-10-18 15:35:00',
  '02:00:00'
);

INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  '2019-10-18 16:00:00',
  '2019-10-18 16:35:00',
  '00:35:00'
);

INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'Ruby'),
  '2019-10-18 17:00:00',
  '2019-10-18 18:30:00',
  '01:30:00'
);

INSERT INTO timetable (task_id, start_at, end_at, duration) VALUES
(
  (SELECT id FROM tasks WHERE name = 'Vocabulary'),
  '2019-10-18 20:05:00',
  '2019-10-18 20:35:00',
  '00:30:00'
);

