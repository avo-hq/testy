class Avo::Scopes::Active < Avo::BaseScope
  self.name = "Active"
  self.description = "Active only"
  self.scope = :active
  self.visible = -> { true }
end
