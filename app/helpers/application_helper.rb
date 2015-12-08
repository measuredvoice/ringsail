module ApplicationHelper
  def pluralize_word(count, singular, plural = nil)
    ((count == 1 || count == '1') ? singular : (plural || singular.pluralize))
  end


  def language_select_options
    language_select_options = []
    LANGUAGE_LIST.each do |lang|
      language_select_options << [ lang, lang ]
    end
    language_select_options
  end
end
