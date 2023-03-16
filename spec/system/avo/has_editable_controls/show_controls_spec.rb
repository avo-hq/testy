require "rails_helper"

RSpec.describe "show controls", type: :system do
  let!(:post) { create :post }
  let!(:url) { "/admin/resources/posts/#{post.id}" }

  after do
    Avo::Resources::Post.restore_controls_from_backup
  end

  context "default controls" do
    it "shows the default show controls" do
      visit url

      # Back button
      expect(page).to have_link "Go back", href: "/admin/resources/posts"

      # Action list
      # Open
      expect(page).to have_text "Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Edit button
      expect(page).to have_link "Edit", href: "/admin/resources/posts/#{post.id}/edit"

      # Delete button
      expect page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").text.eql? "Delete"
    end
  end

  context "custom controls" do
    before do
      Avo::Resources::Post.with_temporary_controls do
        self.show_controls = -> do
          link_to "Information about #{record.name}", "https://www.google.com",
            icon: "heroicons/outline/information-circle", target: :_blank
          action Avo::Actions::TogglePublished, label: "Toggle Published #{record.id}", style: :primary,
            color: :blue, icon: "heroicons/outline/hand-raised"
          actions_list style: :primary, color: :slate, label: "Show Actions"
          back_button label: "Go to posts", title: "Go back now"
          delete_button label: "Delete post", title: "something"
          detach_button label: "Detach post", title: "something"
          edit_button label: "Edit post"
        end
      end
    end

    it "shows the custom show controls" do
      visit url

      # Back button
      expect(page).to have_link "Go to posts", href: "/admin/resources/posts"

      # Action list
      # Open
      expect(page).to have_text "Show Actions"
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Check panel
      expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

      # Close
      page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

      # Edit button
      expect(page).to have_link "Edit post", href: "/admin/resources/posts/#{post.id}/edit"

      # Delete button
      expect page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").text.eql? "Delete post"
    end
  end
end
