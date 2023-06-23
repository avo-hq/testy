class Avo::Resources::Fish < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> {
      query.ransack(id_eq: params[:q], name_cont: params[:q], m: "or").result(distinct: false)
    }
  }

  self.extra_params = [:fish_type, :something_else, properties: [], information: [:name, :history], reviews_attributes: [:body, :user_id]]

  self.show_controls = -> do
    back_button label: "", title: "Go back now"
    link_to "Fish.com", "https://fish.com", icon: "heroicons/outline/academic-cap", target: :_blank
    link_to "Turbo demo", "/admin/resources/fish/#{params[:id]}?change_to=🚀🚀🚀 I told you it will change 🚀🚀🚀",
      class: ".custom-class",
      data: {
        turbo_frame: "fish_custom_action_demo"
      }
    delete_button label: "", title: "something"
    detach_button label: "", title: "something"
    actions_list exclude: [Avo::Actions::ReleaseFish], style: :primary, color: :slate, label: "Runnables"
    action Avo::Actions::ReleaseFish, style: :primary, color: :fuchsia, icon: "heroicons/outline/globe"
    edit_button label: ""
  end

  self.edit_controls = -> do
    back_button label: "", title: "Go back now"
    link_to "Fish.com", "https://fish.com", icon: "heroicons/outline/academic-cap", target: :_blank
    delete_button label: "", title: "something"
    detach_button label: "", title: "something"
    actions_list exclude: [Avo::Actions::ReleaseFish], style: :primary, color: :slate, label: "Runnables"
    action Avo::Actions::ReleaseFish, style: :primary, color: :fuchsia, icon: "heroicons/outline/globe" if view != :new
    save_button label: "Save Fish"
  end

  self.index_controls = -> do
    link_to "Fish.com", "https://fish.com", icon: "heroicons/outline/academic-cap", target: :_blank
    actions_list exclude: [Avo::Actions::DummyAction], style: :primary, color: :slate, label: "Runnables" if Fish.count > 0
    action Avo::Actions::DummyAction, style: :primary, color: :fuchsia, icon: "heroicons/outline/globe" if Fish.count > 0
    attach_button label: "Attach one Fish"
    create_button label: "Create a new and fresh Fish"
  end

  self.row_controls = -> do
    action Avo::Actions::ReleaseFish, label: "Release #{record.name}", style: :primary, color: :blue,
      icon: "heroicons/outline/hand-raised" unless params[:view_type] == "grid"
    edit_button title: "Edit this Fish now!"
    show_button title: "Show this Fish now!"
    delete_button title: "Delete this Fish now!", confirmation_message: "Are you sure you want to delete this Fish?"
    actions_list style: :primary, color: :slate, label: "Actions" unless params[:view_type] == "grid"
    action Avo::Actions::ReleaseFish, title: "Release #{record.name}", icon: "heroicons/outline/hand-raised", style: :icon
    link_to "Information about #{record.name}", "https://en.wikipedia.org/wiki/#{record.name}",
      icon: "heroicons/outline/information-circle", target: :_blank, style: :icon
  end

  self.grid_view = {
    card: -> do
      {
        title: record.name
      }
    end
  }

  def fields
    field :id, as: :id
    field :id, as: :number, only_on: :forms, disabled: -> { view != :new }
    field :name, as: :text, required: -> { view == :new }, help: "help text"
    field :user, as: :belongs_to
    field :type, as: :text, hide_on: :forms
    field :reviews, as: :has_many

    tool Avo::ResourceTools::NestedFishReviews, only_on: :new
    tool Avo::ResourceTools::FishInformation, show_on: :forms

    tabs do
      tab "big useless tab here" do
        panel do
          field :id, as: :id
        end
      end

      tab "another big useless tab here 2" do
        panel do
          field :id, as: :id
        end
      end

      tab "big tab here 3" do
        panel do
          field :id, as: :id
        end
      end

      tab "big tab here 3.5" do
        panel do
          field :id, as: :id
        end
      end

      tab "tab here 4" do
        panel do
          field :id, as: :id
        end
      end

      tab "tab" do
        panel do
          field :id, as: :id
        end
      end

      tab "big useless tab here 6" do
        panel do
          field :id, as: :id
        end
      end

      tab "big useless tab here 7" do
        panel do
          field :id, as: :id
        end
      end

      tab "big tab 8" do
        panel do
          field :id, as: :id
        end
      end
    end
  end

  def filters
    filter Avo::Filters::NameFilter, arguments: {
      case_insensitive: true
    }
  end

  def actions
    action Avo::Actions::DummyAction, arguments: {
      special_message: true
    }
    action Avo::Actions::ReleaseFish
  end
end
