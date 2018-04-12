module HomeHelper
  def no_pending_research?
    research = Research.last

    if research.present? == false or research.concluded == false
      content_tag(:span, 'Research Running, finish the last one, before open another.')
    else
      link_to "Release Research", release_research_path
    end
  end
end
