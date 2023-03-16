require "rails_helper"

RSpec.describe "uncountable fish resource", type: :feature do
  context "create a fish" do
    let(:url) { "/admin/resources/fish" }

    describe "without any fish" do
      it "can visit the page" do
        visit url

        expect(page).to have_link("Create a new and fresh Fish")

        click_on "Create a new and fresh Fish"

        expect(page).to have_current_path "/admin/resources/fish/new"

        fill_in "fish_name", with: "Nemo"

        click_on "Save Fish"
        wait_for_loaded

        nemo = Fish.first

        expect(current_path).to eql "/admin/resources/fish/#{nemo.id}"
        expect(page).to have_text "Nemo"
      end
    end
  end
end
