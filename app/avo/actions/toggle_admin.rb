class Avo::Actions::ToggleAdmin < Avo::BaseAction
  self.name = "Toggle admin"
  self.no_confirmation = true
  self.visible = -> {
    # puts ["view->", view].inspect
    # view == :edit
    # view == :new
    true
  }

  def handle(**args)
    records, fields, current_user, resource = args.values_at(:records, :fields, :current_user, :resource)

    records.each do |model|
      if model.roles["admin"].present?
        model.update roles: model.roles.merge!({"admin": false})
      else
        model.update roles: model.roles.merge!({"admin": true})
      end
    end

    succeed "New admin(s) on the board!"
  end
end
