# frozen_string_literal: true

module Scoutatt
  class Routes < Hanami::Routes
    get '/seasons', to: 'seasons.index', as: :seasons
    get '/seasons/new', to: 'seasons.new', as: :new_season
    get '/seasons/:slug', to: 'seasons.show', as: :show_season
    post '/seasons', to: 'seasons.create', as: :create_season
    get '/seasons/:slug/edit', to: 'seasons.edit', as: :edit_season
    patch '/seasons/:slug', to: 'seasons.update', as: :update_season
    delete '/seasons/:slug', to: 'seasons.destroy', as: :destroy_season

    get '/seasons/:slug/events', to: 'events.index', as: :events
    post '/seasons/:slug/events', to: 'events.create', as: :create_event

    post '/registrations/:slug', to: 'registrations.create', as: :create_registrations

    post '/events', to: 'events.create'
    patch '/events/:slug', to: 'events.update', as: :update_event
    delete '/events/:slug', to: 'events.destroy', as: :destroy_event

    get '/attendance/events/:season_slug', to: 'attendances.index', as: :select_event_for_attendance
    get '/attendance/people/:event_slug', to: 'attendance.show', as: :attendances
    post '/attendance/registration/:registration_slug/r',
         to: 'attendance.create_from_registration',
         as: :create_attendance_from_registration
    post '/attendance/:event_slug',
         to: 'attendance.create', as: :create_attendance
    delete '/attendance/:registration_slug',
           to: 'attendance.destroy', as: :destroy_attendance
  end
end
