require "rails_helper"

RSpec.describe "row controls", type: :system do
  let!(:posts) { create_list :post, 2 }
  let!(:url) { "/admin/resources/posts" }

  after do
    Avo::Resources::Post.restore_controls_from_backup
  end

  context "default controls" do
    it "shows the default row controls" do
      visit "#{url}?view_type=table"
      posts.each_with_index do |post, index|
        # Edit row button
        expect(page).to have_link "", href: "/admin/resources/posts/#{post.id}/edit?via_view=index"
        page.find("[data-target='control:edit'][data-control='edit'][data-resource-id='#{post.id}']").hover
        expect_tipy_text "Edit post"

        # Show row button
        show_url = "/admin/resources/posts/#{post.id}"
        expect(page).to have_link "", href: show_url
        page.find("[data-target='control:view'][data-control='show'][href='#{show_url}']").hover
        expect_tipy_text "View post"

        # Destroy row button
        page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").hover
        expect_tipy_text "Delete post"

        # Destroy working
        if index == 0
          page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").click
          text = page.driver.browser.switch_to.alert.text
          expect(text).to eq "Are you sure?"
          confirm_alert
          expect(page).to have_text "Record destroyed"
          expect(page).to have_current_path "/admin/resources/posts?view_type=table"
        end
      end
    end
  end

  context "custom controls" do
    before do
      Avo::Resources::Post.with_temporary_controls do
        self.row_controls = -> do
          link_to "Information about #{record.name}", "https://www.google.com",
            icon: "heroicons/outline/information-circle", target: :_blank, style: :icon
          action Avo::Actions::TogglePublished, label: "Toggle Published #{record.id}", style: :primary,
            color: :blue, icon: "heroicons/outline/hand-raised"
          edit_button title: "Edit this Post now!"
          show_button title: "Show this Post now!"
          delete_button title: "Delete this Post now!", confirmation_message: "Delete this Post now?"
          actions_list style: :primary, color: :slate, label: "Row Actions"
        end
      end
    end

    it "shows the custom row controls" do
      visit "#{url}?view_type=table"
      posts.each_with_index do |post, index|
        # Information link
        within("[data-component-name='avo/index/table_row_component'][data-resource-id='#{post.id}']") do
          page.find("[href='https://www.google.com']").hover
        end
        expect_tipy_text "Information about #{post.name}"

        # Action button
        expect(page).to have_link "Toggle Published #{post.id}", href: "/admin/resources/posts/#{post.id}/actions/toggle_published"

        # Action list
        within("[data-component-name='avo/index/table_row_component'][data-resource-id='#{post.id}']") do
          # Open
          page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click

          # Check panel
          expect(page).to have_selector "[data-toggle-target='panel'][data-controller='actions-overflow']"

          # Close
          page.find("[data-action='click->toggle#togglePanel'][data-actions-dropdown-button='posts']").click
        end

        # Edit row button
        expect(page).to have_link "", href: "/admin/resources/posts/#{post.id}/edit?via_view=index"
        page.find("[data-target='control:edit'][data-control='edit'][data-resource-id='#{post.id}']").hover
        expect_tipy_text "Edit this Post now!"

        # Show row button
        show_url = "/admin/resources/posts/#{post.id}"
        expect(page).to have_link "", href: show_url
        page.find("[data-target='control:view'][data-control='show'][href='#{show_url}']").hover
        expect_tipy_text "Show this Post now!"

        # Destroy row button
        page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").hover
        expect_tipy_text "Delete this Post now!"

        # Destroy working
        if index == 0
          page.find("[data-control='destroy'][data-turbo-method='delete'][data-resource-id='#{post.id}']").click
          text = page.driver.browser.switch_to.alert.text
          expect(text).to eq "Delete this Post now?"
          confirm_alert
          expect(page).to have_text "Record destroyed"
          expect(page).to have_current_path "/admin/resources/posts?view_type=table"
        end
      end
    end
  end
end

def expect_tipy_text(text)
  expect(page.find(".tippy-content[data-state='visible']")).to have_text text
end
