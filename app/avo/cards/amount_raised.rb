class Avo::Cards::AmountRaised < Avo::Cards::MetricCard
  self.id = "amount_raised"
  self.label = "Amount raised"
  # self.description = "Some description"
  # self.cols = 1
  # self.initial_range = 30
  # self.ranges = [7, 30, 60, 365, "TODAY", "MTD", "QTD", "YTD", "ALL"]
  self.prefix = "$"
  # self.suffix = ""
  self.format = -> {
    number_to_social value, start_at: 1_000
  }

  def query
    result 9001
  end
end
