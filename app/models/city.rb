# == Schema Information
#
# Table name: cities
#
#  id               :bigint           not null, primary key
#  name             :string
#  population       :integer
#  is_capital       :boolean
#  features         :json
#  metadata         :json
#  image_url        :string
#  description      :text
#  status           :string
#  tiny_description :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class City < ApplicationRecord
  enum status: {Open: "open", Closed: "closed", Quarantine: "On Quarantine"}

  def random_image=(value)
  end

  def random_image
    "https://source.unsplash.com/random"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "features", "id", "image_url", "is_capital", "metadata", "name", "population", "status", "tiny_description", "updated_at"]
  end
end
