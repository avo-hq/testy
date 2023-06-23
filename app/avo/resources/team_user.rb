class Avo::Resources::TeamUser < Avo::BaseResource
  self.title = :id
  self.includes = []
  self.model_class = 'User'
  self.find_record_method = -> do
    query.friendly.find id
  end
  self.search = {
    query: -> {
      query.ransack(id_eq: params[:q], m: "or").result(distinct: false)
    }
  }

  def fields
    field :id, as: :id
  end
end
