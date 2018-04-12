module HomeHelper
  def no_pending_research?
    research = Research.last

    if research.present? and research.concluded == false
      content_tag(:span, 'Research Running, finish the last one, before open another.')
    elsif Research.count == 0
      link_to "Release Research", release_research_path
    else
      link_to "Release Research", release_research_path
    end
  end
end
