module HomeHelper
  def no_pending_research?
    research = Research.last

    if research.present? and research.concluded == false
      render partial: "research_running"
    elsif Research.count == 0
      render partial: "menu_researches"
    else
      render partial: "menu_researches"
    end
  end
end
