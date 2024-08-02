# frozen_string_literal: true

season_repo = Hanami.app["repos.season_repo"]
event_repo = Hanami.app["repos.event_repo"]
registration_repo = Hanami.app["repos.registration_repo"]

season0 = season_repo.create(slug: "vpld", title: "Saison 2023-2024", timezone: "America/Montreal")
event0 = event_repo.create(season: season0, title: "2024-01 IGA Noël", max_registrations: 6)
registration_repo.create(event: event0, name: "Francois", role: "Animateur responsable, Chouettes")
registration_repo.create(event: event0, name: "Jane Dow", role: "Chouettes")
registration_repo.create(event: event0, name: "John Dow", role: "Aigles")

event1 = event_repo.create(season: season0, title: "2024-04 IGA Pâques", max_registrations: 4)
registration_repo.create(event: event1, name: "Jane Smith", role: "Castors")
registration_repo.create(event: event1, name: "John Smith", role: "Papa Jane Smith")

season_repo.create(title: "Saison 2024-2025", timezone: "America/Montreal")
