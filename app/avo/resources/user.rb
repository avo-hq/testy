class Avo::Resources::User < Avo::BaseResource
  self.title = :name
  self.description = -> {
    "Users of the app. view: #{view}"
  }
  self.translation_key = "avo.resource_translations.user"
  self.search = {
    query: -> {
      query.order(created_at: :desc).ransack(id_eq: params[:q], first_name_cont: params[:q], last_name_cont: params[:q], m: "or").result(distinct: false)
    }
  }
  self.grid_view = {
    card: -> do
      {
        cover_url: record.avatar,
        title: record.name,
        body: record.url
      }
    end
  }
  self.index_query = -> {
    query.order(last_name: :asc)
  }
  self.find_record_method = -> {
    # When using friendly_id, we need to check if the id is a slug or an id.
    # If it's a slug, we need to use the find_by_slug method.
    # If it's an id, we need to use the find method.
    # If the id is an array, we need to use the where method in order to return a collection.
    if id.is_a?(Array)
      return id.first.to_i == 0 ? query.where(slug: id) : query.where(id: id)
    end

    id.to_i == 0 ? query.find_by_slug(id) : query.find(id)
  }
  self.includes = [:posts, :post]
  self.devise_password_optional = true

  def fields
    field :id, as: :id, link_to_record: true
    field :email, as: :gravatar, link_to_record: true, as_avatar: :circle, only_on: :index
    field :user_information, as: :heading
    field :first_name, as: :text, placeholder: "John", stacked: true
    field :last_name, as: :text, placeholder: "Doe", filterable: true
    field :email, as: :text, name: "User Email", required: true, protocol: :mailto
    field :active, as: :boolean, name: "Is active", only_on: :index
    field :cv, as: :file, name: "CV"
    field :is_admin?, as: :boolean, name: "Is admin", only_on: :index
    field :roles, as: :boolean_group, options: {admin: "Administrator", manager: "Manager", writer: "Writer"}
    field :roles, as: :text, hide_on: :all, as_description: true do
      "This user has the following roles: #{record.roles.select { |key, value| value }.keys.join(", ")}"
    end
    field :birthday,
      as: :date,
      first_day_of_week: 1,
      picker_format: "F J Y",
      format: "cccc, d LLLL yyyy", # Wednesday, 10 February 1988
      placeholder: "Feb 24th 1955",
      required: true,
      only_on: [:index]

    field :is_writer, as: :text,
      sortable: ->(query, direction) {
        # Order by something else completely, just to make a test case that clearly and reliably does what we want.
        query.order(id: direction)
      },
      hide_on: :edit do
        record.posts.to_a.size > 0 ? "yes" : "no"
      end

    field :password, as: :password, name: "User Password", required: false, except_on: :forms, help: 'You may verify the password strength <a href="http://www.passwordmeter.com/" target="_blank">here</a>.'
    field :password_confirmation, as: :password, name: "Password confirmation", required: false

    field :dev, as: :heading, label: '<div class="underline uppercase font-bold">DEV</div>', as_html: true
    field :team_id, as: :hidden, default: 0 # For testing purposes

    sidebar do
      field :email, as: :gravatar, link_to_record: true, as_avatar: :circle, only_on: :show
      field :heading, as: :heading, label: ""
      field :active, as: :boolean, name: "Is active", only_on: :show
      field :is_admin?, as: :boolean, name: "Is admin", only_on: :index
      field :birthday,
        as: :date,
        first_day_of_week: 1,
        picker_format: "F J Y",
        format: "cccc, d LLLL yyyy", # Wednesday, 10 February 1988
        placeholder: "Feb 24th 1955",
        required: true,
        filterable: true,
        only_on: [:show]
      field :is_writer, as: :text,
        hide_on: :edit do
          record.posts.to_a.size > 0 ? "yes" : "no"
        end
      field :outside_link, as: :text, only_on: [:show], format_using: -> { link_to("hey", value, target: "_blank") } do
        main_app.hey_url
      end
      field :custom_css, as: :code, theme: "dracula", language: "css", help: "This enables you to edit the user's custom styles.", height: "250px"
    end

    tabs do
      tab "Birthday", description: "hey you", hide_on: :show do
        panel do
          field :birthday,
            as: :date,
            first_day_of_week: 1,
            picker_format: "F J Y",
            format: "DDDD",
            placeholder: "Feb 24th 1955",
            required: true
        end
      end

      field :fish, as: :has_one
      field :teams, as: :has_and_belongs_to_many
      field :people,
        as: :has_many,
        show_on: :edit,
        translation_key: "avo.field_translations.people"
      field :spouses, as: :has_many # STI has_many resource
      field :projects, as: :has_and_belongs_to_many
      field :team_memberships, as: :has_many
    end

    tabs do
      field :post,
        as: :has_one,
        name: "Main post",
        translation_key: "avo.field_translations.people"
      field :posts,
        as: :has_many,
        show_on: :edit,
        attach_scope: -> { query.where.not(user_id: parent.id).or(query.where(user_id: nil)) }
      field :comments,
        as: :has_many,
        # show_on: :edit,
        scope: -> { query.starts_with parent.first_name[0].downcase },
        description: "The comments listed in the attach modal all start with the name of the parent user."
    end

    tool Avo::ResourceTools::UserTool
  end

  def actions
    action Avo::Actions::ToggleInactive
    action Avo::Actions::ToggleAdmin
    action Avo::Actions::DummyAction
    action Avo::Actions::DownloadFile
  end

  def scopes
    scope Avo::Scopes::OddId
    scope Avo::Scopes::EvenId
    scope Avo::Scopes::Admins
    scope Avo::Scopes::NonAdmins
    scope Avo::Scopes::Active
  end

  def filters
    filter Avo::Filters::UserNamesFilter
    filter Avo::Filters::IsAdmin
    filter Avo::Filters::DummyMultipleSelectFilter
  end
end
