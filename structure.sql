drop schema public cascade;
create schema public;

create extension if not exists citext;

create table seasons(
    season_id bigint generated always as identity
  , title citext not null check(length(trim(title)) > 2)
  , timezone text not null default 'America/Montreal'

  , created_at timestamp with time zone not null default now()
  , updated_at timestamp with time zone not null default now()

  , primary key(season_id)
);

create table events(
    season_id bigint not null
  , event_id bigint not null generated always as identity
  , title citext not null check(length(trim(title)) > 2)

  , created_at timestamp with time zone not null default now()
  , updated_at timestamp with time zone not null default now()

  , primary key(season_id, event_id)
  , foreign key(season_id) references seasons
);

create table slots(
    season_id bigint not null
  , event_id bigint not null
  , slot_id bigint not null generated always as identity
  , start_at timestamp with time zone not null

  , created_at timestamp with time zone not null default now()
  , updated_at timestamp with time zone not null default now()

  , primary key(season_id, event_id, slot_id)
  , foreign key(season_id, event_id) references events
);

create table registrations(
    season_id bigint not null
  , event_id bigint not null
  , slot_id bigint not null

  , name citext not null check(length(trim(name)) > 2)
  , role citext not null check(length(trim(role)) > 2)

  , created_at timestamp with time zone not null default now()
  , updated_at timestamp with time zone not null default now()

  , primary key(season_id, event_id, slot_id)
  , foreign key(season_id, event_id, slot_id) references slots
);

create table attendances(
    season_id bigint not null
  , event_id bigint not null
  , start_at timestamp with time zone not null

  , name citext not null check(length(trim(name)) > 2)
  , role citext not null check(length(trim(role)) > 2)

  , primary key(season_id, event_id, start_at, name)
  , foreign key(season_id, event_id) references events
);
