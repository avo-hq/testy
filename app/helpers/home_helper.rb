module HomeHelper
  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers::UrlHelper
    include ActionView::Context
  end

  def extract_excerpt(body)
    ActionView::Base.full_sanitizer.sanitize(body).truncate 120
  end
end
