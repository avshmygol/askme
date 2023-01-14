module QuestionsHelper
  def render_with_hashtags(body)
    body
      .gsub(Tag::REGEXP) { |word| link_to word, "/questions/hashtags/#{word.downcase.delete("#")}" }
      .gsub(/\n/, "<br/>")
      .html_safe
  end
end
