# frozen_string_literal: true

season_repo = Hanami.app["repos.season_repo"]
event_repo = Hanami.app["repos.event_repo"]
registration_repo = Hanami.app["repos.registration_repo"]

season0 = season_repo.create(slug: "vpld", title: "Saison 2023-2024")
event0 = event_repo.create(season: season0, slug: "nhnl", title: "2024-01 IGA Noël", max_registrations: 6,
  start_at: Time.parse("2024-01-10T10:00-0500"))
registration_repo.create(event: event0, name: "Francois", role: "Animateur responsable, Chouettes",
  notification_email: "francois@example.org")
registration_repo.create(event: event0, name: "Jane Dow", role: "Chouettes", notification_email: "francois@example.org")
registration_repo.create(event: event0, name: "John Dow", role: "Aigles", notification_email: "francois@example.org")

event1 = event_repo.create(season: season0, title: "2024-04 IGA Pâques", max_registrations: 4,
  start_at: Time.parse("2024-04-20T09:00-0400"))
registration_repo.create(event: event1, name: "Jane Smith", role: "Castors",
  notification_email: "john.smith@example.org")
registration_repo.create(event: event1, name: "John Smith", role: "Papa Jane Smith",
  notification_email: "john.smith@example.org")

season_repo.create(title: "Saison 2024-2025")
