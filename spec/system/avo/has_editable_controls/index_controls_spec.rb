require "rails_helper"

RSpec.describe "index controls", type: :system do
  let!(:posts) { create_list :post, 5 }
  let!(:person) { create :person }
  let!(:url) { "/admin/resources/posts" }

  after do
    Avo::Resources::Post.restore_controls_from_backup
    Avo::Resources::Spouse.restore_controls_from_backup
  end

  context "default controls" do
    it "shows the default index controls" do
      visit url

      # Action list
      # Open
      expect(page).to have_text "Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Create new button
      expect(page).to have_link "Create new post", href: "/admin/resources/posts/new"
    end

    it "shows the default has many index controls" do
      visit "/admin/resources/people/#{person.id}"
      # Attach spouse button
      expect(page).to have_link "Attach spouse", href: /\/admin\/resources\/people\/#{person.id}\/spouses\/new/

      # Create new spouse button
      expect(page).to have_link "Create new spouse", href: "/admin/resources/spouses/new?via_record_id=#{person.id}&via_relation=spouses&via_relation_class=Person"
    end
  end

  context "custom controls" do
    before do
      Avo::Resources::Post.with_temporary_controls do
        self.index_controls = -> do
          link_to "Google", "https://google.com", icon: "heroicons/outline/academic-cap", target: :_blank
          actions_list style: :primary, color: :slate, label: "Post Actions"
          action Avo::Actions::DummyAction, style: :primary, color: :fuchsia, icon: "heroicons/outline/globe"
          create_button label: "Create a new Post!"
        end
      end

      Avo::Resources::Spouse.with_temporary_controls do
        self.index_controls = -> do
          attach_button label: "Attach one spouse now"
          create_button label: "Create a new spouse now"
        end
      end
    end

    it "shows the custom index controls" do
      visit url

      # Action list
      # Open
      expect(page).to have_text "Post Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Create new button
      expect(page).to have_link "Create a new Post!", href: "/admin/resources/posts/new"

      # Dummy action
      expect(page).to have_link "Dummy action", href: "/admin/resources/posts/actions/dummy_action"

      # Google link
      expect(page).to have_link "Google", href: "https://google.com"
    end

    it "shows the custom has many index controls" do
      visit "/admin/resources/people/#{person.id}"
      # Attach spouse button
      expect(page).to have_link "Attach one spouse now", href: /\/admin\/resources\/people\/#{person.id}\/spouses\/new/

      # Create new spouse button
      expect(page).to have_link "Create a new spouse now", href: "/admin/resources/spouses/new?via_record_id=#{person.id}&via_relation=spouses&via_relation_class=Person"
    end
  end
end
