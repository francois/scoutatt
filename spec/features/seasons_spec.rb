# frozen_string_literal: true

RSpec.feature "Seasons" do
  let(:seasons) { Hanami.app["relations.seasons"] }

  scenario "happy-path season management: CRUD" do
    aggregate_failures do
      visit "/seasons"
      expect(page).to have_content "Aucune saison enregistrée"
    end

    aggregate_failures do
      click_link("add-season")
      expect(page.status_code).to eq(200)
      expect(page).to have_current_path("/seasons/new")
    end

    aggregate_failures do
      fill_in "season-title", with: "2024-2025"
      click_button("Enregistrer")
    end

    aggregate_failures do
      expect(page).to have_current_path("/seasons")
      expect(page).to have_content("Saison 2024-2025 enregistrée")
      expect(page).to have_selector("td", text: "2024-2025")
    end

    aggregate_failures do
      click_link("2024-2025")
      season = seasons.where(title: "2024-2025").one!
      expect(page).to have_current_path("/seasons/#{season[:slug]}/edit")
    end

    aggregate_failures do
      fill_in "season-title", with: "2025-2026"
      click_button "Mettre à jour"
      expect(page).to have_current_path("/seasons")
      expect(page).to have_selector("td", text: "2025-2026")
    end

    aggregate_failures do
      click_button "X"
      expect(page).to have_current_path("/seasons")
      expect(page).to have_content "Aucune saison enregistrée"
    end
  end
end
