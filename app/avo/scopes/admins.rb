class Avo::Scopes::Admins < Avo::BaseScope
  self.name = "Admins"
  self.description = "Admins only"
  self.scope = :admins
  self.visible = -> { true }
end
