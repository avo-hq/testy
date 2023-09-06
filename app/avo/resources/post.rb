class Avo::Resources::Post < Avo::BaseResource
  self.title = :name
  self.search = {
    query: -> {
      scope.ransack(id_eq: params[:q], name_cont: params[:q], body_cont: params[:q], m: "or").result(distinct: false)
    },
    help: "- search by id, name or body"
  }

  self.includes = [:user]
  self.default_view_type = :grid

  self.grid_view = {
    card: -> do
      {
        cover_url:
        if record.cover_photo.attached?
          main_app.url_for(record.cover_photo.url)
        end,
        title: record.name,
        body: ActionView::Base.full_sanitizer.sanitize(record.body).truncate(120)
      }
    end
  }

  # self.show_controls = -> do
  #   detach_button
  #   edit_button
  #   link_to "google", "goolee"
  # end

  def fields
    field :id, as: :id
    field :name, as: :text, required: true, sortable: true
    field :body,
      as: :trix,
      placeholder: "Enter text",
      always_show: false,
      attachment_key: :attachments,
      hide_attachment_url: true,
      hide_attachment_filename: true,
      hide_attachment_filesize: true
    field :tags,
      as: :tags,
      # disabled: true,
      acts_as_taggable_on: :tags,
      close_on_select: false,
      placeholder: "add some tags",
      suggestions: -> { Post.tags_suggestions },
      enforce_suggestions: true,
      help: "The only allowed values here are `one`, `two`, and `three`"
    field :cover_photo, as: :file, is_image: true, as_avatar: :rounded, full_width: true, hide_on: [], accept: "image/*"
    field :cover_photo, as: :external_image, name: "Cover photo", required: true, hide_on: :all, link_to_record: true, as_avatar: :rounded, format_using: -> { value.present? ? value&.url : nil }
    field :audio, as: :file, is_audio: true, accept: "audio/*"
    field :excerpt, as: :text, hide_on: :all, as_description: true do
      extract_excerpt record.body
    end

    field :is_featured, as: :boolean, visible: -> do
      Avo::Current.context[:user].is_admin?
    end
    field :is_published, as: :boolean do
      record.published_at.present?
    end
    field :user, as: :belongs_to, placeholder: "—"
    field :status, as: :select, enum: ::Post.statuses, display_value: false
    field :comments, as: :has_many, use_resource: Avo::Resources::PhotoComment
  end

  def filters
    filter Avo::Filters::FeaturedFilter
    filter Avo::Filters::PublishedFilter
    filter Avo::Filters::PostStatusFilter
  end

  def actions
    action Avo::Actions::TogglePublished
  end
end
