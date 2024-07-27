insert into seasons(title) values ('2024-2025');
insert into events(season_id, title)
  select season_id, t0.title
  from seasons, (values ('Vert & Or'), ('Phénix'), ('Canet-O-Thon'), ('Classique PIF')) as t0(title);

insert into slots(season_id, event_id, start_at)
  select season_id, event_id, start_at::timestamp with time zone
  from events, (values ('2024-09-14T10:00-0400'), ('2024-09-28T10:00-0400'), ('2024-10-13T10:00-0400'), ('2024-10-27T10:00-0400')) as t0(start_at), generate_series(1, 6, 1) as t1(n)
  where title = 'Vert & Or'
  union all
  select season_id, event_id, start_at::timestamp with time zone
  from events, (values ('2025-01-10T20:00-0500'), ('2025-01-26T17:00-0500'), ('2025-02-09T17:00-0500'), ('2025-02-28T20:00-0500')) as t0(start_at), generate_series(1, 6, 1) as t1(n)
  where title = 'Phénix'
  union all
  select season_id, event_id, start_at::timestamp with time zone
  from events, (values ('2025-01-04T09:00-0500'), ('2025-01-04T11:00-0500'), ('2025-01-04T13:00-0500'), ('2025-01-04T15:00-0500'), ('2025-01-05T09:00-0500'), ('2025-01-05T11:00-0500'), ('2025-01-05T13:00-0500'), ('2025-01-05T15:00-0500')) as t0(start_at), generate_series(1, 6, 1) as t1(n)
  where title = 'Canet-O-Thon'
  union all
  select season_id, event_id, start_at::timestamp with time zone
  from events, (values ('2025-01-26T22:00-0400'), ('2025-01-27T22:00-0400'), ('2025-01-28T22:00-0400'), ('2025-01-29T22:00-0400'), ('2025-01-30T22:00-0400'), ('2025-07-01T22:00-0400')) as t0(start_at), generate_series(1, 4, 1) as t1(n)
  where title = 'Classique PIF'
  union all
  select season_id, event_id, start_at::timestamp with time zone
  from events, (values ('2025-07-03T19:00-0400')) as t0(start_at), generate_series(1, 10, 1) as t1(n)
  where title = 'Classique PIF';
