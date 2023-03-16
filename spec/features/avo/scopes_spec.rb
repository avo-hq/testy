require "rails_helper"

RSpec.feature "Scopes", type: :system do
  let!(:user_admin) { create :user, first_name: 'John Admin', roles: {"admin": true} }
  let!(:user_non_admin) { create :user, first_name: 'John Non Admin', roles: {"admin": false} }
  let!(:team) { create :team, name: 'Nice Team' }
  let!(:team_membership) { team.team_members << [user_admin, user_non_admin] }
  let!(:base_url) { "/admin/resources/teams/#{team.id}/team_members" }
  let!(:turbo_frame) { "turbo_frame=has_many_field_show_team_members" }
  let!(:active_scope_class) { "block px-4 text-sm pt-3 py-2 group hover:text-gray-900 text-gray-900" }
  let!(:non_active_scope_class) { "block px-4 text-sm pt-3 py-2 group hover:text-gray-900 text-gray-600" }

  describe "on has many" do
    it "are there" do
      visit "#{base_url}?#{turbo_frame}"
      wait_for_loaded
      expect(page).to have_text 'Team members'
      expect(page).to have_link "All", href: "#{base_url}?#{turbo_frame}", class: active_scope_class
      expect(page).to have_link 'Even', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AEvenId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Odd', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AOddId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Non admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3ANonAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Active', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AActive&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_text 'John Admin'
      expect(page).to have_text 'John Non Admin'
    end

    it "apply admin scope" do
      visit "#{base_url}?#{turbo_frame}"
      wait_for_loaded
      click_on 'Admins'
      wait_for_loaded
      expect(page).to have_text 'Team members'
      expect(page).to have_text 'John Admin'
      expect(page).to_not have_text 'John Non Admin'
      expect(page).to have_link "All", href: "#{base_url}?#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Even', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AEvenId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Odd', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AOddId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AAdmins&#{turbo_frame}", class: active_scope_class
      expect(page).to have_link 'Non admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3ANonAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Active', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AActive&#{turbo_frame}", class: non_active_scope_class
    end

    it "apply non admin scope then all scope" do
      visit "#{base_url}?#{turbo_frame}"
      wait_for_loaded
      click_on 'Non admins'
      wait_for_loaded
      expect(page).to have_link "All", href: "#{base_url}?#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Even', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AEvenId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Odd', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AOddId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Non admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3ANonAdmins&#{turbo_frame}", class: active_scope_class
      expect(page).to have_link 'Active', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AActive&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_text 'Team members'
      expect(page).to have_text 'John Non Admin'
      expect(page).to_not have_text 'John Admin'

      click_on 'All'
      wait_for_loaded
      expect(page).to have_link "All", href: "#{base_url}?#{turbo_frame}", class: active_scope_class
      expect(page).to have_link 'Even', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AEvenId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Odd', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AOddId&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Non admins', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3ANonAdmins&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_link 'Active', href: "#{base_url}?scope=Avo%3A%3AScopes%3A%3AActive&#{turbo_frame}", class: non_active_scope_class
      expect(page).to have_text 'Team members'
      expect(page).to have_text 'John Non Admin'
      expect(page).to have_text 'John Admin'
    end
  end
end
