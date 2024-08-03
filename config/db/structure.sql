CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `seasons`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `title` text NOT NULL,
  `slug` text NOT NULL,
  `timezone` text NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
);
CREATE UNIQUE INDEX `seasons_slug_index` ON `seasons`(`slug`);
CREATE INDEX `seasons_title_index` ON `seasons`(`title`);
CREATE TABLE `events`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `season_id` integer NOT NULL,
  `slug` text NOT NULL,
  `title` text NOT NULL,
  `max_registrations` integer NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
);
CREATE UNIQUE INDEX `events_slug_index` ON `events`(`slug`);
CREATE UNIQUE INDEX `events_season_id_title_index` ON `events`(
  'season_id',
  'title'
);
CREATE TABLE `registrations`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `event_id` integer NOT NULL,
  `name` text NOT NULL,
  `role` text NOT NULL,
  `notification_email` text NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
);
CREATE INDEX `registrations_event_id_name_index` ON `registrations`(
  `event_id`,
  `name`
);
INSERT INTO schema_migrations (filename) VALUES
('20240727171457_create_seasons.rb'),
('20240728171518_create_events.rb'),
('20240728173841_create_registrations.rb');
