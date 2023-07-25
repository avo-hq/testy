class Avo::Scopes::OddId < Avo::Pro::Scopes::BaseScope
  self.name = "Odd"
  self.description = "tooltip ;)"
  self.scope = -> { query.where("#{resource.model_key}.id % 2 = ?", "1") }
  self.visible = -> { true }
end
