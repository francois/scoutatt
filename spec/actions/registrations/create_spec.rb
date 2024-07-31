# frozen_string_literal: true

RSpec.describe Scoutatt::Actions::Registrations::Create do
  let(:season_repo) { Hanami.app["repos.season_repo"] }
  let(:event_repo) { Hanami.app["repos.event_repo"] }
  let(:slot_repo) { Hanami.app["repos.slot_repo"] }
  let(:registration_repo) { Hanami.app["repos.registration_repo"] }

  context "given a season, an event, and a slot" do
    let!(:season) { season_repo.create(title: "2023-2024", timezone: "America/New_York") }
    let!(:event) { event_repo.create(season:, title: "IGA") }
    let!(:slot) { slot_repo.create(event:, start_at: "2024-01-05T09:00-0400") }

    context "when calling with a valid slot ID" do
      let(:params) do
        {
          slug: season.slug,
          registration: {
            :email => "moi@example.com",
            event.slug => {
              slot.slug => {
                name: "jane doe",
                role: "chouettes"
              }
            }
          }
        }
      end

      it "adds the registration" do
        response = subject.call(params)
        expect(response).to be_successful
      end
    end
  end
end
