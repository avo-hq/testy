class Avo::Dashboards::Dashy < AvoDashboards::BaseDashboard
  self.id = "dashy"
  self.name = "Dashy"
  self.description = "The first dashbaord"
  self.grid_cols = 3
  # self.visible = -> do
  #   true
  # end

  self.authorize = -> do
    current_user.is_admin?
  end

  def cards
    card Avo::Cards::ExampleMetric, visible: -> { true }
    card Avo::Cards::ExampleAreaChart
    card Avo::Cards::ExampleScatterChart
    card Avo::Cards::ExampleMetric,
      label: "Active users metric",
      description: "Count of the active users.",
      arguments: {
        active_users: true
      }
    card Avo::Cards::PercentDone
    card Avo::Cards::ExampleLineChart, cols: 2
    card Avo::Cards::AmountRaised
    card Avo::Cards::ExampleColumnChart
    card Avo::Cards::ExamplePieChart
    card Avo::Cards::ExampleBarChart, cols: 2
    card Avo::Cards::MetricFromParam

    divider label: "Custom partials"

    card Avo::Cards::MapCard
    card Avo::Cards::ExampleCustomPartial,
      arguments: {
        deprecate_options: "On favor of arguments",
        block: ->(params = nil) {
          "Hello from the arguments block"
        }
      }
  end
end
