# frozen_string_literal: true

module Scoutatt
  class Routes < Hanami::Routes
    get "/seasons", to: "seasons.index", as: :seasons
    get "/seasons/new", to: "seasons.new", as: :new_season
    get "/seasons/:slug", to: "seasons.show", as: :show_season
    post "/seasons", to: "seasons.create", as: :create_season
    get "/seasons/:slug/edit", to: "seasons.edit", as: :edit_season
    patch "/seasons/:slug", to: "seasons.update", as: :update_season
    delete "/seasons/:slug", to: "seasons.destroy", as: :destroy_season

    post "/registrations/:slug", to: "registrations.create", as: :create_registrations
  end
end
