require "rails_helper"

RSpec.describe "edit controls", type: :system do
  let!(:post) { create :post }
  let!(:url) { "/admin/resources/posts/#{post.id}/edit?via_view=index" }

  after do
    Avo::Resources::Post.restore_controls_from_backup
  end

  context "default controls" do
    it "shows the default edit controls" do
      visit url

      # Back button
      expect(page).to have_link "Cancel", href: "/admin/resources/posts"

      # Action list
      # Open
      expect(page).to have_text "Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Save button
      expect page.find("[data-action='click->loading-button#attemptSubmit']").text.eql? "Save"
    end
  end

  context "custom controls" do
    before do
      Avo::Resources::Post.with_temporary_controls do
        self.edit_controls = -> do
          link_to "Information about #{record.name}", "https://www.google.com",
            icon: "heroicons/outline/information-circle", target: :_blank
          action Avo::Actions::TogglePublished, label: "Toggle Published #{record.id}", style: :primary,
            color: :blue, icon: "heroicons/outline/hand-raised"
          actions_list style: :primary, color: :slate, label: "Edit Actions"
          save_button label: "Save Post"
          back_button label: "Go back", title: "Go back now"
        end
      end
    end

    it "shows the custom edit controls" do
      visit url

      # Back button
      expect(page).to have_link "Go back", href: "/admin/resources/posts"

      # Action list
      # Open
      expect(page).to have_text "Edit Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Save button
      expect page.find("[data-action='click->loading-button#attemptSubmit']").text.eql? "Save Post"

      # Information link
      expect(page).to have_link "Information about #{post.name}", href: "https://www.google.com"

      # Action button
      expect(page).to have_link "Toggle Published #{post.id}", href: "/admin/resources/posts/#{post.id}/actions/toggle_published"

      # Information link
      expect(page).to have_link "Information about #{post.name}", href: "https://www.google.com"

      # Action button
      expect(page).to have_link "Toggle Published #{post.id}", href: "/admin/resources/posts/#{post.id}/actions/toggle_published"
    end
  end
end
