module ApplicationHelper
  def pluralize_word(count, singular, plural = nil)
    ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
  end
end
