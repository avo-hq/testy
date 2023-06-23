class Avo::Resources::Product < Avo::BaseResource
  self.title = :title
  self.includes = []
  self.default_view_type = :grid

  self.grid_view = {
    card: -> do
      {
        cover_url:
          if record.image.attached?
            main_app.url_for(record.image.url)
          end,
        title: record.title,
        body: simple_format(record.description)
      }
    end,
    html: -> do
      {
        cover: {
          index: {
            wrapper: {
              style: "background: pink;"
            }
          }
        }
      }
    end
  }

  def fields
    field :id, as: :id
    field :title, as: :text, html: {
      show: {
        label: {
          classes: "bg-gray-50 !text-pink-600"
        },
        content: {
          classes: "bg-gray-50 !text-pink-600"
        },
        wrapper: {
          classes: "bg-gray-50"
        }
      }
    }
    field :description, as: :trix
    field :image, as: :file, is_image: true
    field :price, as: :number
    field :category, as: :select, enum: ::Product.categories
  end
end
