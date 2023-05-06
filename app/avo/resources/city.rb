class Avo::Resources::City < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = ->(params:) do
  #   query.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  self.extra_params = [:fish_type, :something_else, properties: [], information: [:name, :history]]

  def fields
    field :id, as: :id
    with_options hide_on: :forms do
      field :name, as: :text, help: "The name of your city", filterable: true
      field :population, as: :number, filterable: true
      field :is_capital, as: :boolean, filterable: true
      field :features, as: :key_value
      field :metadata, as: :code
      field :image_url, as: :external_image
      field :description, as: :trix
      field :tiny_description, as: :markdown
      field :status, as: :badge, enum: ::City.statuses
    end
    field :created_at, as: :date_time, filterable: true

    tool Avo::ResourceTools::CityEditor, only_on: :forms
  end
end
