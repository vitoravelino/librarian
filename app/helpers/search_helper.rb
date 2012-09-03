module SearchHelper
  
  def excerpt(hit)
    if not hit.highlights(:text).empty? then
      field = sanitize hit.highlights(:text).first.format { |word| "<strong>#{word}</strong>" }
    end

    concat(field || hit.instance.text[0..100])
  end

end