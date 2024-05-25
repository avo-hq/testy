Rails.application.routes.draw do
  root to: redirect(Avo.configuration.root_path)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "hey", to: "home#index"

  # Regular single-tenant mounting technique
  authenticate :user, ->(user) { user.is_admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  # Multi-tenantn mounting technique
  # config.default_url_options value
  # scope "/t/:tenant_id" do
  #   authenticate :user, ->(user) { user.is_admin? } do
  #     mount Avo::Engine, at: Avo.configuration.root_path

  #     # Mount Avo engines under the right path.
  #     scope Avo.configuration.root_path do
  #       instance_exec(&Avo.mount_engines)
  #     end
  #   end
  # end

  # Locale-based routes
  # scope "(:locale)" do
  #   mount Avo::Engine, at: Avo.configuration.root_path
  # end

    # TODO: support locale based routes
    scope "(:locale)" do
      # mount Avo::Engine, at: Avo.configuration.root_path
    end
  end
end

if defined? ::Avo
  Avo::Engine.routes.draw do
    get "custom_tool", to: "tools#custom_tool", as: :custom_tool

    scope :resources do
      get "courses/cities", to: "courses#cities"
      get "users/get_users", to: "users#get_users"
    end
  end
end
