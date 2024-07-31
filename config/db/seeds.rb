# frozen_string_literal: true

season_repo = Hanami.app["repos.season_repo"]
event_repo = Hanami.app["repos.event_repo"]
slot_repo = Hanami.app["repos.slot_repo"]
registration_repo = Hanami.app["repos.registration_repo"]

season0 = season_repo.create(slug: "vpld", title: "Saison 2023-2024", timezone: "America/Montreal")
event0 = event_repo.create(season: season0, title: "2024-01 IGA Noël")
slot0 = slot_repo.create(event: event0, start_at: "2024-01-06T09:00-0400", num_registrations: 4)
registration_repo.create(slot: slot0, name: "Francois", role: "Animateur responsable, Chouettes")
registration_repo.create(slot: slot0, name: "Jane Dow", role: "Chouettes")
registration_repo.create(slot: slot0, name: "John Dow", role: "Aigles")

slot1 = slot_repo.create(event: event0, start_at: "2024-01-06T11:00-0400", num_registrations: 4)
registration_repo.create(slot: slot1, name: "Jane Smith", role: "Castors")
registration_repo.create(slot: slot1, name: "John Smith", role: "Papa")

slot_repo.create(event: event0, start_at: "2024-01-06T13:00-0400", num_registrations: 4)
slot_repo.create(event: event0, start_at: "2024-01-06T15:00-0400", num_registrations: 4)

event1 = event_repo.create(season: season0, title: "2024-04 IGA Pâques")
slot_repo.create(event: event1, start_at: "2024-01-06T09:00-0400", num_registrations: 4)
# slot_repo.create(event: event1, start_at: '2024-01-06T11:00-0400', num_registrations: 4)
# slot_repo.create(event: event1, start_at: '2024-01-06T13:00-0400', num_registrations: 4)
# slot_repo.create(event: event1, start_at: '2024-01-06T15:00-0400', num_registrations: 4)

# event_repo.create(season: season0, title: '2023-09-15 Vert & Or 1/4')
# event_repo.create(season: season0, title: '2023-09-30 Vert & Or 2/4')
# event_repo.create(season: season0, title: '2023-10-15 Vert & Or 3/4')
# event_repo.create(season: season0, title: '2023-10-30 Vert & Or 4/4')
# event_repo.create(season: season0, title: '2024-03-08 Phénix 1/4')
# event_repo.create(season: season0, title: '2024-03-28 Phénix 2/4')
# event_repo.create(season: season0, title: '2024-04-12 Phénix 3/4')
# event_repo.create(season: season0, title: '2024-05-20 Phénix 4/4')

season_repo.create(title: "Saison 2024-2025", timezone: "America/Montreal")
