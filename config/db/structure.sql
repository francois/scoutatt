CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `seasons`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `title` text NOT NULL,
  `slug` text NOT NULL,
  `timezone` text NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
);
CREATE INDEX `seasons_title_index` ON `seasons`(`title`);
CREATE UNIQUE INDEX `seasons_slug_index` ON `seasons`(`slug`);
INSERT INTO schema_migrations (filename) VALUES
('20240727171457_create_seasons.rb');
