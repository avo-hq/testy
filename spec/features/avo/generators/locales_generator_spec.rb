require "rails_helper"
require "rails/generators"

RSpec.feature "locales generator", type: :feature do
  it "generates the files" do
    locales = %w[en fr nn nb pt-BR pt ro tr]

    files = locales.map do |locale|
      Rails.root.join("config", "locales", "avo.#{locale}.yml").to_s
    end

    # Manually remove the files so the generator creates them
    files.each do |file|
      File.delete(file) if File.exist?(file)
    end

    Rails::Generators.invoke("avo:locales", ["-q"], {destination_root: Rails.root})

    # We should
    check_files_and_clean_up files, delete: false
  end
end
